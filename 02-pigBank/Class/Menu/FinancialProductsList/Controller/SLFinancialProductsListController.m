//
//  SLFinancialProductsListController.m
//  02-pigBank
//
//  Created by 陆承东 on 14-9-25.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLFinancialProductsListController.h"

#import "SLPlateInfo.h"
#import "SLFinanceProduct.h"
#import "SLFinancialStatusFrame.h"
#import "SLFinanceProductFrame.h"
#import "SLClientPlate.h"
#import "SLFinancialProductParameters.h"
#import "SLFinancialProductListScreenParameters.h"

#import "SLFinancialProductListCell.h"
#import "SLFinancialProductListTableHeadView.h"
#import "SLFinancialScreenView.h"

#import "SLFinanceProductController.h"

#import "UIImage+S_LINE.h"
#import "UIBarButtonItem+SL.h"
#import "SLClientPlatesTool.h"
#import "SLFinancialProductTool.h"
#import "SLFinancialProductListScreenTool.h"
#import "SLPlateInfoTool.h"

#import "MJRefresh.h"
#import "MJExtension.h"
#import "UIViewController+REXSideMenu.h"
#import "MBProgressHUD+MJ.h"

@interface SLFinancialProductsListController ()<UITableViewDelegate, UITableViewDataSource, SLFinancialProductListTableHeadViewDelegate, MJRefreshBaseViewDelegate, SLFinancialScreenViewDelegate>

@property (nonatomic, strong) NSMutableArray *financialProductStatusFrameArray;

/** headView */
@property (nonatomic, weak) UIView *headView;
/** 预期收益率 */
@property (nonatomic, weak) UIButton *expectedYieldButton;
/** 剩余时间 */
@property (nonatomic, weak) UIButton *leftTimeButton;

/** orderType 网络参数 */
@property (nonatomic, copy) NSString *orderType;

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) MJRefreshHeaderView *header;
@property (nonatomic, weak) MJRefreshFooterView *footer;

@property (nonatomic, assign) long currentPage;

@property (nonatomic, weak) SLFinancialScreenView *financialScreenView;
@property (nonatomic, strong) SLFinancialProductParameters *parameters;
@property (nonatomic, strong) NSArray *financialProductClassArray;
@property (nonatomic, strong) NSNumber *classId;

@end

@implementation SLFinancialProductsListController
- (SLFinancialProductParameters *)parameters
{
    if (_parameters == nil) {
        _parameters = [SLFinancialProductParameters parameters];
        _parameters.pageSize = @20;
    }
    return _parameters;
}
- (NSMutableArray *)financialProductStatusFrameArray
{
    if (_financialProductStatusFrameArray == nil) {
        _financialProductStatusFrameArray = [NSMutableArray array];
    }
    return _financialProductStatusFrameArray;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    
    [self setNavBar];
}

#pragma mark ----- setNavBar设置导航栏
- (void)setNavBar
{
    // 设置左上角的barButton
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"iconMorePress" highlightImage:@"iconMore" target:self action:@selector(presentLeftMenuViewController:)];
    
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 18, 18)];
    [rightButton setImage:[UIImage imageNamed:@"shanXuan"] forState:UIControlStateNormal];
    [rightButton setImage:[UIImage imageNamed:@"shanXuanJiaoHu"] forState:UIControlStateHighlighted];
    [rightButton addTarget:self action:@selector(rightButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)rightButtonClicked:(UIButton *)rightButton
{
    if (self.financialScreenView.hidden == YES) {
        self.financialScreenView.alpha = 0;
        self.financialScreenView.hidden = NO;
        self.tableView.scrollEnabled = NO;
        self.tabBarController.tabBar.userInteractionEnabled = NO;
        [UIView animateWithDuration:0.5 animations:^{
            self.financialScreenView.alpha = 1;
        } completion:^(BOOL finished) {
        }];
    } else {
        [UIView animateWithDuration:0.5 animations:^{
            self.financialScreenView.alpha = 0;
        } completion:^(BOOL finished) {
            self.financialScreenView.hidden = YES;
            self.tableView.scrollEnabled = YES;
            self.tabBarController.tabBar.userInteractionEnabled = YES;
        }];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.header endRefreshing];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadScreenData];
    
    [self addSubviews];
}

- (void)loadScreenData
{
    SLFinancialProductListScreenParameters *parameters = [SLFinancialProductListScreenParameters parameters];
    parameters.plateId = @2;
    
    [SLFinancialProductListScreenTool financialProductListScreenItemWithParameters:parameters success:^(NSArray *financialProductClassArray) {
        
        self.financialProductClassArray = financialProductClassArray;
        self.financialScreenView.financialProductClassArray = financialProductClassArray;
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)addSubviews
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 85;
    self.tableView = tableView;
    [self.view addSubview:tableView];
    
    [self setTableHeadFootView];
    
    // 集成刷新控件
    [self setupRefreshView];
    
    SLFinancialScreenView *financialScreenView = [[SLFinancialScreenView alloc] initWithFrame:CGRectMake(0, 64, screenW, screenH)];
    financialScreenView.delegate = self;
    self.financialScreenView = financialScreenView;
    financialScreenView.hidden = YES;
    [self.view insertSubview:financialScreenView aboveSubview:tableView];
}

#pragma mark ----- 设置TableHeadFootView
- (void)setTableHeadFootView
{
    SLFinancialProductListTableHeadView *headView = [[SLFinancialProductListTableHeadView alloc] init];
    headView.delegate = self;
    self.tableView.tableHeaderView = headView;
    self.headView = headView;
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenW, 0.5)];
    footView.backgroundColor = SLLightGray;
    self.tableView.tableFooterView = footView;
}

- (void)financialScreenView:(SLFinancialScreenView *)financialScreenView didSelectedClassId:(NSNumber *)classId
{
    self.classId = classId;
    
    [self.header beginRefreshing];
    
    [UIView animateWithDuration:0.5 animations:^{
        financialScreenView.alpha = 0;
    } completion:^(BOOL finished) {
        financialScreenView.hidden = YES;
        self.tableView.scrollEnabled = YES;
        self.tabBarController.tabBar.userInteractionEnabled = YES;
    }];
}
- (void)financialScreenViewDidTouchCoverView:(SLFinancialScreenView *)financialScreenView
{
    if (financialScreenView.hidden == NO) {
        [UIView animateWithDuration:0.5 animations:^{
            financialScreenView.alpha = 0;
        } completion:^(BOOL finished) {
            financialScreenView.hidden = YES;
            self.tableView.scrollEnabled = YES;
            self.tabBarController.tabBar.userInteractionEnabled = YES;
        }];
    }
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
    self.currentPage += 1;
    
    self.parameters.curPage = [NSNumber numberWithLong:self.currentPage];
    
    if ([self.classId intValue] == 0) {
        self.parameters.classId = nil;
    } else {
        self.parameters.classId = self.classId;
    }
    
    [SLFinancialProductTool financialProductListWithParameters:self.parameters success:^(NSArray *financialProductStatusFrameArray) {
        
        if (financialProductStatusFrameArray.count > 0) {
            [self.financialProductStatusFrameArray addObject:financialProductStatusFrameArray];
            
            [self.tableView reloadData];
        } else {
            [MBProgressHUD showError:@"没有更多数据了"];
        }
        
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
    self.parameters.search = @"";
    self.parameters.curPage = [NSNumber numberWithLong:self.currentPage];
    self.parameters.orderType = self.orderType;
    self.parameters.classId = self.classId;
    NSArray *internerPlateList = [SLPlateInfoTool getInternetPlateList];
    for (SLPlateInfo *plateInfo in internerPlateList) {
        if ([plateInfo.plateType isEqualToString:@"3"]) {
            self.parameters.plateId = plateInfo.plateId;
        }
    }
    if ([self.classId intValue] == 0) {
        self.parameters.classId = nil;
    } else {
        self.parameters.classId = self.classId;
    }
    
    [SLFinancialProductTool financialProductListWithParameters:self.parameters success:^(NSArray *financialProductStatusFrameArray) {
        
        if (financialProductStatusFrameArray.count > 0) {
            [self.financialProductStatusFrameArray removeAllObjects];
            [self.financialProductStatusFrameArray addObjectsFromArray:financialProductStatusFrameArray];
            
            [self.tableView reloadData];
        } else {
            [MBProgressHUD showError:@"没有相关数据..."];
        }
        
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

- (void)financialProductListTableHeadView:(SLFinancialProductListTableHeadView *)financialProductListTableHeadView didClickExpectedYieldButton:(UIButton *)expectedYieldButton
{
    self.orderType = @"2";
    [self.header beginRefreshing];
}

-(void)financialProductListTableHeadView:(SLFinancialProductListTableHeadView *)financialProductListTableHeadView didClickLeftTimeButton:(UIButton *)leftTimeButton
{
    self.orderType = @"1";
    [self.header beginRefreshing];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _financialProductStatusFrameArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.创建cell
    SLFinancialProductListCell *cell = [SLFinancialProductListCell cellWithTableView:tableView];
    
    SLFinancialStatusFrame *financialStatusFrame = _financialProductStatusFrameArray[indexPath.row];
    
    // 2.给cell传递模型数据
    cell.financialStatusFrame = financialStatusFrame;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SLFinancialStatusFrame *fsf = self.financialProductStatusFrameArray[indexPath.row];
    SLFinanceProduct *financeProduct = fsf.financeProduct;
    
    SLFinanceProductFrame *financeProductFrame = [[SLFinanceProductFrame alloc] init];
    financeProductFrame.financeProduct = financeProduct;
    
    SLFinanceProductController *financeProductController = [[SLFinanceProductController alloc] init];
    
    financeProductController.materialId = financeProductFrame.financeProduct.financialProductsDetail.materialId;
    financeProductController.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:financeProductController animated:YES];
}

@end
