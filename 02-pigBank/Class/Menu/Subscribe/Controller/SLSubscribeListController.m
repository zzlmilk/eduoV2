//
//  SLSubscribeListController.m
//  02-pigBank
//
//  Created by 陆承东 on 15/1/23.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import "SLSubscribeListController.h"

#import "SLSubscribeListCell.h"

#import "SLSubscribeDetailController.h"
#import "SLSubscribeClassController.h"

#import "SLSubscribeTool.h"
#import "UIBarButtonItem+SL.h"

#import "UIViewController+REXSideMenu.h"
#import "MJRefresh.h"
#import "MJExtension.h"
#import "MBProgressHUD+MJ.h"

@interface SLSubscribeListController ()<MJRefreshBaseViewDelegate>

@property (nonatomic, weak) MJRefreshHeaderView *header;
@property (nonatomic, weak) MJRefreshFooterView *footer;

@property (nonatomic, assign) long currentPage;
@property (nonatomic, strong) SLSubscribeListParameters *parameters;
@property (nonatomic, strong) NSMutableArray *subscribeStatusList;

@end

@implementation SLSubscribeListController

- (NSMutableArray *)subscribeStatusList
{
    if (_subscribeStatusList == nil) {
        _subscribeStatusList = [NSMutableArray array];
    }
    return _subscribeStatusList;
}

- (SLSubscribeListParameters *)parameters
{
    if (_parameters == nil) {
        _parameters = [SLSubscribeListParameters parameters];
        _parameters.pageSize = @20;
    }
    return _parameters;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self loadNewData];
    
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

#pragma mark ----- 右上角按钮点击事件
- (void)rightButtonClicked:(UIButton *)rightButton
{
    SLSubscribeClassController *scvc = [[SLSubscribeClassController alloc] init];
    scvc.title = @"订阅设置";
    scvc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:scvc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = 80;
    
    [self setTableHeadFootView];
    
    [self setupRefreshView];
}

#pragma mark ----- 设置tableHeadFootView
- (void)setTableHeadFootView
{
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenW, 0.5)];
    footView.backgroundColor = SLLightGray;
    self.tableView.tableFooterView = footView;
}

#pragma mark ----- 设置刷新控件
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
    
    [SLSubscribeTool subscribeListWithParameters:self.parameters success:^(SLResult *result) {
        
        if ([result.code isEqualToString:@"0000"]) {
            if (result.info.count > 0) {
                NSArray *dictArray = [result.info lastObject];
                NSArray *subscribeStatusList = [SLSubscribeList objectArrayWithKeyValuesArray:dictArray];
                
                if (subscribeStatusList.count > 0) {
                    [self.subscribeStatusList addObjectsFromArray:subscribeStatusList];
                    
                    [self.tableView reloadData];
                } else {
                    [MBProgressHUD showError:@"没有更多数据了"];
                }
            }
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
    
    self.parameters.curPage = [NSNumber numberWithLong:self.currentPage];
    
    [SLSubscribeTool subscribeListWithParameters:self.parameters success:^(SLResult *result) {
        
        if ([result.code isEqualToString:@"0000"]) {
            if (result.info.count > 0) {
                NSArray *dictArray = [result.info lastObject];
                NSArray *subscribeStatusList = [SLSubscribeList objectArrayWithKeyValuesArray:dictArray];
                [self.subscribeStatusList removeAllObjects];
                
                if (subscribeStatusList.count > 0) {
                    [self.subscribeStatusList addObjectsFromArray:subscribeStatusList];
                } else {
                    [MBProgressHUD showError:@"没有相关数据"];
                }
                [self.tableView reloadData];
            }
        } else {
            [MBProgressHUD showError:@"没有相关数据"];
        }
        
        // 让刷新控件停止显示刷新状态
        [self.header endRefreshing];
        
    } failure:^(NSError *error) {
        [self.header endRefreshing];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Tableview datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.subscribeStatusList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SLSubscribeList *subscribeList = self.subscribeStatusList[indexPath.row];
    
    SLSubscribeListCell *cell = [SLSubscribeListCell cellWithTableView:tableView];
    
    cell.subscribeList = subscribeList;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SLSubscribeList *subscribe = self.subscribeStatusList[indexPath.row];
    
    SLSubscribeDetailController *sdvc = [[SLSubscribeDetailController alloc] init];
    sdvc.siId = subscribe.siId;
    sdvc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:sdvc animated:YES];
}

@end
