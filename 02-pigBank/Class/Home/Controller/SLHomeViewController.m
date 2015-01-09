//
//  SLHomeViewController.m
//  02-pigBank
//
//  Created by 陆承东 on 14-9-13.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLHomeViewController.h"



#import "SLFinanceProductFrame.h"
#import "SLFinanceProduct.h"
#import "SLConsultant.h"

#import "SLFinanceProductParameters.h"
#import "SLConsultantParameters.h"
#import "SLPlateParameters.h"
#import "SLHomeStatus.h"
#import "SLHomeStatusFrame.h"
#import "SLMaterialParameters.h"
#import "SLVipStatus.h"

#import "SLHomeStatusCell.h"
#import "SLSearchBar.h"

#import "SLFinanceProductController.h"
#import "SLTabBarController.h"
#import "SLSearchController.h"
#import "SLNavigationController.h"
#import "ICSDrawerController.h"
#import "SLVipProductViewController.h"

#import "SLFinanceProductCacheTool.h"
#import "SLHttpTool.h"
#import "SLHomeStatusTool.h"
#import "SLConsultantTool.h"
#import "UIBarButtonItem+SL.h"
#import "SLAccountTool.h"
#import "SLMaterialTool.h"

#import "UIImageView+WebCache.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "UIViewController+REXSideMenu.h"


@interface SLHomeViewController ()<UIActionSheetDelegate, MJRefreshBaseViewDelegate>

@property (nonatomic, strong) NSMutableArray *homeStatusFrames;

@property (nonatomic, strong) SLConsultant *consultant;

/**
 *  导航栏右边的items数组(里面装着uibarbuttonItem对象)
 */
@property (nonatomic, strong) NSArray *rightBarButtonItems;

@property (nonatomic, strong) NSMutableArray *financeProductFrames;

@property (nonatomic, weak) MJRefreshHeaderView *header;
@property (nonatomic, weak) MJRefreshFooterView *footer;

@property (nonatomic, assign) long currentPage;

@property (nonatomic, strong) SLHomeStatusParameters *homeStatusParameters;

@end

@implementation SLHomeViewController

- (NSMutableArray *)homeStatusFrames
{
    if (_homeStatusFrames == nil) {
        _homeStatusFrames = [NSMutableArray array];
    }
    return _homeStatusFrames;
}
- (NSMutableArray *)financeProductFrames
{
    if (_financeProductFrames == nil) {
        _financeProductFrames = [NSMutableArray array];
    }
    return _financeProductFrames;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 获取当前理财顾问
    [self getCurrentconsultant];
    
    // 集成刷新控件
    [self setupRefreshView];
    
    [self setupAllPlate];
}
- (void)setupAllPlate
{
    NSString *url = [SLHttpUrl stringByAppendingString:@"/plate/listPlateInfo"];
    SLPlateParameters *parameters = [SLPlateParameters parameters];
    
    [SLHttpTool postWithUrlstr:url parameters:parameters.keyValues success:^(id responseObject) {
        
    } failure:^(NSError *error) {
        
    }];
}

/**
 *  集成刷新控件
 */
- (void)setupRefreshView
{
    // 1.下拉刷新
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    header.scrollView = self.tableView;
    header.delegate = self;
    // 自动进入刷新状态
    [header beginRefreshing];
    self.header = header;
    
    // 2.上拉刷新(上拉加载更多数据)
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = self.tableView;
    footer.delegate = self;
    self.footer = footer;
}

#pragma mark ----- 代理方法,mj刷新包的代理方法
/**
 *  刷新控件进入开始刷新状态的时候调用
 */
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if ([refreshView isKindOfClass:[MJRefreshFooterView class]]) { // 上拉刷新
        [self loadMoreData];
    } else { // 下拉刷新
        [self loadNewData];
    }
}

/**
 *  发送请求加载更多的数据
 */
- (void)loadMoreData
{
    SLHomeStatusParameters *parameters = [SLHomeStatusParameters parameters];
    
    self.currentPage += 1;
    
    parameters.curPage = [NSNumber numberWithLong:self.currentPage];
    parameters.search = @"";
    parameters.pageSize = @20;
    
    [SLHomeStatusTool homeStatusesWithParameters:parameters success:^(NSArray *homeStatusArray) {
        NSMutableArray *homeStatusFrameArray = [NSMutableArray array];
        for (SLHomeStatus *homeStatus in homeStatusArray) {
            SLHomeStatusFrame *homeStatusFrame = [[SLHomeStatusFrame alloc] init];
            homeStatusFrame.homeStatus = homeStatus;
            [homeStatusFrameArray addObject:homeStatusFrame];
        }
        [self.homeStatusFrames addObjectsFromArray:homeStatusFrameArray];
        
        [self.tableView reloadData];
        
        // 让刷新控件停止显示刷新状态
        [self.footer endRefreshing];
    } failure:^(NSError *error) {
        [self.footer endRefreshing];
    }];
}
 /**
 *  // 刷新数据(向服务器获取更新的数据)
 */
- (void)loadNewData
{
    self.currentPage = 1;
    
    // 2.2封装请求数据
    SLHomeStatusParameters *parameters = [SLHomeStatusParameters parameters];
    parameters.search = @"";
    parameters.pageSize = @20;
    parameters.curPage = [NSNumber numberWithLong:self.currentPage];

    [SLHomeStatusTool homeStatusesWithParameters:parameters success:^(NSArray *homeStatusArray) {
        NSMutableArray *homeStatusFrameArray = [NSMutableArray array];
        NSArray *homeStatuses = homeStatusArray;
        for (SLHomeStatus *homeStatus in homeStatuses) {
            SLHomeStatusFrame *homeStatusFrame = [[SLHomeStatusFrame alloc] init];
            homeStatusFrame.homeStatus = homeStatus;
            [homeStatusFrameArray addObject:homeStatusFrame];
        }
//        [self.homeStatusFrames addObjectsFromArray:homeStatusFrameArray];
        self.homeStatusFrames = homeStatusFrameArray;
        
        [self.tableView reloadData];
        
        // 让刷新控件停止显示刷新状态
        [self.header endRefreshing];
    } failure:^(NSError *error) {
        [self.header endRefreshing];
    }];
}

- (void)dealloc
{
    // 释放内存
    [self.header free];
    [self.footer free];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self setupNavBar];
    
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}

/**
 *  获取当前账户的理财顾问
 */
- (void)getCurrentconsultant
{
    SLConsultantParameters *parameters = [SLConsultantParameters parameters];
    parameters.consultantId = [NSNumber numberWithLong:[SLAccountTool getAccount].accountInfo.vipDetail.userConsultant];
    
    [SLConsultantTool consultantWithParameters:parameters success:^(SLConsultant *consultant) {
        self.consultant = consultant;
    } failure:^(NSError *error) {
        
    }];
}

/**
 *  设置导航栏
 */
- (void)setupNavBar
{
    UINavigationBar *navBar = self.navigationController.navigationBar;
    // 设置背景
    [navBar setBackgroundImage:[UIImage imageNamed:@"bjNavigationBarPurple"] forBarMetrics:UIBarMetricsDefault];
    
    NSMutableDictionary *attri = [NSMutableDictionary dictionary];
    attri[UITextAttributeTextColor] = [UIColor whiteColor];
    [navBar setTitleTextAttributes:attri];
    
    // 设置右上角的barButton
    UIBarButtonItem *findItem = [UIBarButtonItem itemWithImage:@"iconSearch" highlightImage:@"iconSearchPress" target:self action:@selector(find)];
    UIBarButtonItem *callItem = [UIBarButtonItem itemWithImage:@"dianHua" highlightImage:@"dianHua" target:self action:@selector(call)];
    self.rightBarButtonItems = @[findItem, callItem];
    self.navigationItem.rightBarButtonItems = self.rightBarButtonItems;
    
    // 设置左上角的barButton
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"iconMore" highlightImage:@"iconMorePress" target:self action:@selector(presentLeftMenuViewController:)];
}

- (void)find
{
    SLSearchController *searchController = [[SLSearchController alloc] init];
    
    SLNavigationController *nav = [[SLNavigationController alloc] initWithRootViewController:searchController];
    
    [self presentViewController:nav animated:YES completion:^{
        nil;
    }];
}

#pragma mark ----- 设置打电话的item
- (void)call
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:self.consultant.dispName delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:[NSString stringWithFormat:@"%@", self.consultant.mobile], nil];
    
    [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIWebView *callWebView = [[UIWebView alloc] init];
    [self.view addSubview:callWebView];
    
    if (buttonIndex == 0) {
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", self.consultant.mobile]];
        [callWebView loadRequest:[NSURLRequest requestWithURL:url]];
    } else if (buttonIndex == 1) {
    }
}

- (void)textClick:(UIButton *)button
{
    self.tabBarItem.badgeValue = @"111";
    self.tabBarItem.title = @"猪子";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.homeStatusFrames.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 创建cell
    SLHomeStatusCell *cell = [SLHomeStatusCell cellWithTableView:tableView];
    
    // 传递frame模型数据
    SLHomeStatusFrame *homeStatusFrame = self.homeStatusFrames[indexPath.row];
    cell.homeStatusFrame = homeStatusFrame;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SLHomeStatusFrame *homeStatusFrame = self.homeStatusFrames[indexPath.row];
    SLHomeStatus *homeStatus = homeStatusFrame.homeStatus;
    
    if ([homeStatus.templetType intValue] == 3) {
        SLFinanceProductController *financeProductController = [[SLFinanceProductController alloc] init];
        financeProductController.materialId = homeStatus.materialId;
        
        [self.navigationController pushViewController:financeProductController animated:YES];
    } else if ([homeStatus.templetType intValue] == 2) {
        SLVipProductViewController *vpvc = [[SLVipProductViewController alloc] init];
        vpvc.materialId = homeStatus.materialId;
        [self.navigationController pushViewController:vpvc animated:YES];
    }
}

#pragma mark - 代理方法 - 设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SLHomeStatusFrame *homeStatusFrame = self.homeStatusFrames[indexPath.row];
    return homeStatusFrame.cellHeight;
}

@end
