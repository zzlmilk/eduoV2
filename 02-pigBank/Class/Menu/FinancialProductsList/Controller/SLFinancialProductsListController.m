//
//  SLFinancialProductsListController.m
//  02-pigBank
//
//  Created by 陆承东 on 14-9-25.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLFinancialProductsListController.h"

#import "SLFinanceProduct.h"
#import "SLFinancialStatusFrame.h"
#import "SLFinanceProductFrame.h"
#import "SLClientPlate.h"
#import "SLFinancialProductParameters.h"

#import "SLFinancialProductListCell.h"
#import "SLFinancialProductListTableHeadView.h"

#import "SLFinanceProductController.h"

#import "UIImage+S_LINE.h"
#import "UIBarButtonItem+SL.h"
#import "SLClientPlatesTool.h"
#import "SLFinancialProductTool.h"

#import "MJRefresh.h"
#import "MJExtension.h"

@interface SLFinancialProductsListController ()<SLFinancialProductListTableHeadViewDelegate, MJRefreshBaseViewDelegate>

@property (nonatomic, strong) NSMutableArray *financialProductStatusFrameArray;

/** headView */
@property (nonatomic, weak) UIView *headView;
/** 预期收益率 */
@property (nonatomic, weak) UIButton *expectedYieldButton;
/** 剩余时间 */
@property (nonatomic, weak) UIButton *leftTimeButton;

/** orderType 网络参数 */
@property (nonatomic, copy) NSString *orderType;

@property (nonatomic, weak) MJRefreshHeaderView *header;
@property (nonatomic, weak) MJRefreshFooterView *footer;

@property (nonatomic, assign) long currentPage;

@property (nonatomic, strong) SLFinancialProductParameters *parameters;

@end

@implementation SLFinancialProductsListController
- (SLFinancialProductParameters *)parameters
{
    if (_parameters == nil) {
        _parameters = [SLFinancialProductParameters parameters];
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

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /**
     *  添加tableHeadView
     */
    SLFinancialProductListTableHeadView *headView = [[SLFinancialProductListTableHeadView alloc] init];
    headView.delegate = self;
    self.tableView.tableHeaderView = headView;
    self.headView = headView;
    
    if (self.tag == 1) {
        // 设置左上角的barButton
        self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"iconMore" highlightImage:@"iconMorePress" target:self action:@selector(more:)];
    }
    
    // 集成刷新控件
    [self setupRefreshView];
    
    self.tableView.rowHeight = 85;
}
- (void)more:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(financialProductListController:didClickMoreButton:)]) {
        [self.delegate financialProductListController:self didClickMoreButton:self.navigationItem.leftBarButtonItem];
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
    
    [SLFinancialProductTool financialProductListWithParameters:self.parameters success:^(NSArray *financialProductStatusFrameArray) {
        
        [self.financialProductStatusFrameArray addObject:financialProductStatusFrameArray];
        
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
    self.parameters.search = @"";
    self.parameters.pageSize = @20;
    self.parameters.curPage = [NSNumber numberWithLong:self.currentPage];
    self.parameters.orderType = self.orderType;
    self.parameters.plateId = [NSNumber numberWithInteger:[SLClientPlatesTool getFinancialProductClientPlate].plateId];
    
    [SLFinancialProductTool financialProductListWithParameters:self.parameters success:^(NSArray *financialProductStatusFrameArray) {
        
        self.financialProductStatusFrameArray = nil;
        [self.financialProductStatusFrameArray addObjectsFromArray:financialProductStatusFrameArray];
        
        if (financialProductStatusFrameArray.count > 19) {
            // 2.上拉刷新(上拉加载更多数据)
            MJRefreshFooterView *footer = [MJRefreshFooterView footer];
            footer.scrollView = self.tableView;
            footer.delegate = self;
            self.footer = footer;
        }
        
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

//- (void)viewWillAppear:(BOOL)animated
//{
//    /**
//     *  请求网络数据
//     */
////    [self expectedYieldButtonClick:self.expectedYieldButton];
//    self.orderType = @"2";
//    [self loadNewData];
//}

#pragma mark ----- 请求网络数据
//- (void)loadFinancialProductsListData
//{
//    SLFinancialProductParameters *parameters = [SLFinancialProductParameters parameters];
//    
//    parameters.orderType = self.orderType;
//    parameters.plateId = [NSNumber numberWithInteger:[SLClientPlatesTool getFinancialProductClientPlate].plateId];
//    
//    [SLFinancialProductTool financialProductListWithParameters:parameters success:^(NSArray *financialProductStatusFrameArray) {
//        
//        _financialProductStatusFrameArray = (NSMutableArray *)financialProductStatusFrameArray;
//        
//        [self.tableView reloadData];
//        
//    } failure:^(NSError *error) {
//        
//    }];
//}

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

//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    SLFinancialStatusFrame *fsf = self.financialProductStatusFrameArray[indexPath.row];
//    
//    return fsf.cellHeight;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SLFinancialStatusFrame *fsf = self.financialProductStatusFrameArray[indexPath.row];
    SLFinanceProduct *financeProduct = fsf.financeProduct;
    
    SLFinanceProductFrame *financeProductFrame = [[SLFinanceProductFrame alloc] init];
    financeProductFrame.financeProduct = financeProduct;
    
    SLFinanceProductController *financeProductController = [[SLFinanceProductController alloc] init];
    
    financeProductController.financeProductFrame = financeProductFrame;
    
    [self.navigationController pushViewController:financeProductController animated:YES];
}

@end
