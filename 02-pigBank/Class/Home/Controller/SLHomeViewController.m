//
//  SLHomeViewController.m
//  02-pigBank
//
//  Created by 陆承东 on 14-9-13.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLHomeViewController.h"

#import "SLConsultant.h"
#import "SLConsultantTool.h"
#import "MJRefresh.h"
#import "SLHttpTool.h"
#import "UIBarButtonItem+SL.h"
#import "SLAccountTool.h"
#import "SLAccount.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
#import "MJExtension.h"

#import "SLSearchController.h"
#import "SLSearchBar.h"
#import "SLNavigationController.h"
#import "SLHomeStatus.h"
#import "SLHomeStatusFrame.h"
#import "SLHomeStatusCell.h"
#import "ICSDrawerController.h"
#import "SLFinanceProductController.h"
#import "SLTabBarController.h"

#import "SLFinanceProductFrame.h"
#import "SLFinanceProduct.h"
#import "SLHomeStatusTool.h"


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
    //    footer.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView){
    //        IWLog(@"refreshing.....");
    //    };
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
        for (SLHomeStatus *homeStatus in homeStatusArray) {
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
    
//    [SLHttpTool postWithUrlstr:@"http://117.79.93.100:8013/data2.0/ds/material/listIndexMaterialInfo" parameters:parameters.keyValues success:^(id responseObject) {
//        // 取出状态字典数组
//        NSArray *dictArray = [responseObject[@"info"] lastObject];
//        
//        NSArray *statusArray = [SLHomeStatus objectArrayWithKeyValuesArray:dictArray];
//        NSArray *financeProductArray = [SLFinanceProduct objectArrayWithKeyValuesArray:dictArray];
//        
//        NSMutableArray *statusFrameArray = [NSMutableArray array];
//        for (SLHomeStatus *homeStatus in statusArray) {
//            SLHomeStatusFrame *homeStatusFrame = [[SLHomeStatusFrame alloc] init];
//            
//            // 将所有homeStatus对象复制给对应的homeStatusFrame对象的homeStatus成员变量
//            homeStatusFrame.homeStatus = homeStatus;
//            
//            [statusFrameArray addObject:homeStatusFrame];
//        }
//        [self.homeStatusFrames addObjectsFromArray:statusFrameArray];
//        
//        NSMutableArray *financeProductFrameArray = [NSMutableArray array];
//        for (SLFinanceProduct *financeProduct in financeProductArray) {
//            SLFinanceProductFrame *financeProductFrame = [[SLFinanceProductFrame alloc] init];
//            
//            financeProductFrame.financeProduct = financeProduct;
//            [financeProductFrameArray addObject:financeProductFrame];
//        }
//        
//        [self.financeProductFrames addObjectsFromArray:financeProductFrameArray];
//    
//        [self.tableView reloadData];
//
//        // 让刷新控件停止显示刷新状态
//        [self.header endRefreshing];
//    } failure:^(NSError *error) {
//        [self.header endRefreshing];
//    }];
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
}

/**
 *  获取当前账户的理财顾问
 */
- (void)getCurrentconsultant
{
    // 1.创建请求管理对象
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.封装请求参数
    // 2.1获取当前用户信息
    SLAccount *account = [SLAccountTool getAccount];
    
    NSMutableDictionary *parameters1 = [NSMutableDictionary dictionary];
    parameters1[@"consultantId"] = [NSNumber numberWithLong:account.accountInfo.vipDetail.userConsultant];
//    SLLog(@"%ld", account.accountInfo.vipDetail.userConsultant);
    parameters1[@"uid"] = [NSNumber numberWithLong:account.uid];
    parameters1[@"token"] = account.token;
    
    [mgr POST:@"http://117.79.93.100:8013/data2.0/ds/user/catchConsultantInfoById" parameters:parameters1 success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // 取出状态字典数组
        NSDictionary *consultantDict = [responseObject[@"info"] lastObject];
        
//        SLLog(@"%@", responseObject);
        
        SLConsultant *consultant = [SLConsultant objectWithKeyValues:consultantDict];
        self.consultant = consultant;
        
        // 归档
        [SLConsultantTool saveConsultantAccount:consultant];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

/**
 *  设置导航栏
 */
- (void)setupNavBar
{
    //    // 取出appearance
    //    UINavigationBar *navBar = [UINavigationBar appearance];
    
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
    UIImage *iconMore = [UIImage imageNamed:@"iconMore"];
    NSParameterAssert(iconMore);
//    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"iconMore" highlightImage:@"iconMorePress" target:self action:@selector(more:)];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"iconMore" highlightImage:@"iconMorePress" target:self action:@selector(more:)];
}



- (void)more:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(homeViewController:didClickMoreButton:)]) {
        [self.delegate homeViewController:self didClickMoreButton:self.navigationItem.leftBarButtonItem];
    }
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
//        SLLog(@"1111");
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
    // Dispose of any resources that can be recreated.
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
    
    if (homeStatus.templetType == 3) {
        SLFinanceProductController *financeProductController = [[SLFinanceProductController alloc] init];
        
        // 2.封装请求参数
        // 2.1获取当前用户信息
        SLAccount *account = [SLAccountTool getAccount];
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        
        // 2.2封装请求数据
        parameters[@"materialId"] = [NSNumber numberWithLong:homeStatus.materialId];
        parameters[@"uid"] = [NSNumber numberWithLong:(long)account.uid];
        parameters[@"token"] = account.token;
        
        [SLHttpTool postWithUrlstr:@"http://117.79.93.100:8013/data2.0/ds/material/catchMaterialInfoById" parameters:parameters success:^(id responseObject) {
            
            // 取出理财产品的info内容
            NSDictionary *dictionary = [responseObject[@"info"] lastObject];
            
            SLFinanceProduct *financeProduct = [SLFinanceProduct objectWithKeyValues:dictionary];
            
            SLFinanceProductFrame *financeProductFrame = [[SLFinanceProductFrame alloc] init];
            financeProductFrame.financeProduct = financeProduct;
            
            financeProductController.financeProductFrame = financeProductFrame;
        } failure:^(NSError *error) {
            
        }];
        
        [self.navigationController pushViewController:financeProductController animated:YES];

        //        self.titleLabel.text = [NSString stringWithFormat:@"【尊享理财】%@", homeStatus.title];
    } else {
        //        self.titleLabel.text = [NSString stringWithFormat:@"【VIP特权】%@", homeStatus.title];
    }
}

#pragma mark - 代理方法 - 设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SLHomeStatusFrame *homeStatusFrame = self.homeStatusFrames[indexPath.row];
    return homeStatusFrame.cellHeight;
}

@end
