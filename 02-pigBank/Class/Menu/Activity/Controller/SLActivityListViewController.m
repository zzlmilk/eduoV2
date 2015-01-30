//
//  SLActivityListViewController.m
//  02-pigBank
//
//  Created by 陆承东 on 15/1/19.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import "SLActivityListViewController.h"

#import "SLActivityListParameters.h"
#import "SLClassesListParameters.h"
#import "SLActivityListCellFrame.h"

#import "SLActivityListCell.h"
#import "SLSwitchButtonView.h"
#import "SLClassScreenCoverView.h"

#import "SLActivityDetailController.h"

#import "UIBarButtonItem+SL.h"
#import "SLActivityTool.h"
#import "SLPlateInfoTool.h"

#import "UIViewController+REXSideMenu.h"
#import "MJRefresh.h"
#import "MBProgressHUD+MJ.h"

@interface SLActivityListViewController () <UITableViewDataSource, UITableViewDelegate, MJRefreshBaseViewDelegate, SLSwitchButtonViewDelegate, SLClassScreenCoverViewDelegate>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) MJRefreshHeaderView *header;
@property (nonatomic, weak) MJRefreshFooterView *footer;
@property (nonatomic, weak) SLClassScreenCoverView *classScreenCoverView;

@property (nonatomic, assign) long currentPage;
@property (nonatomic, strong) NSNumber *classId;
@property (nonatomic, strong) SLActivityListParameters *parameters;
@property (nonatomic, assign) BOOL flag;

@property (nonatomic, strong) NSMutableArray *myActivityStatusList;
@property (nonatomic, strong) NSArray *classesArray;

@end

@implementation SLActivityListViewController

- (NSMutableArray *)myActivityStatusList
{
    if (_myActivityStatusList == nil) {
        _myActivityStatusList = [NSMutableArray array];
    }
    return _myActivityStatusList;
}

- (SLActivityListParameters *)parameters
{
    if (_parameters == nil) {
        _parameters = [SLActivityListParameters parameters];
        _parameters.pageSize = @20;
    }
    return _parameters;
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

#pragma mark ----- 右上角按钮点击事件
- (void)rightButtonClicked:(UIButton *)rightButton
{
    if (self.classScreenCoverView.hidden == YES) {
        self.classScreenCoverView.alpha = 0;
        self.classScreenCoverView.hidden = NO;
        self.tableView.scrollEnabled = NO;
        self.tabBarController.tabBar.userInteractionEnabled = NO;
        [UIView animateWithDuration:0.5 animations:^{
            self.classScreenCoverView.alpha = 1;
        } completion:^(BOOL finished) {
        }];
    } else {
        [UIView animateWithDuration:0.5 animations:^{
            self.classScreenCoverView.alpha = 0;
        } completion:^(BOOL finished) {
            self.classScreenCoverView.hidden = YES;
            self.tableView.scrollEnabled = YES;
            self.tabBarController.tabBar.userInteractionEnabled = YES;
        }];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addSubviews];
    
    [self loadScreenData];
    
    // 集成刷新控件
    [self setupRefreshView];
}

#pragma mark ----- 设置tableHeadFootView
- (void)setTableHeadFootView
{
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenW, 0.25)];
    footView.backgroundColor = SLLightGray;
    self.tableView.tableFooterView = footView;
    
    SLSwitchButtonView *headView = [[SLSwitchButtonView alloc] init];
    headView.delegate = self;
    [headView setLeftTitle:@"所有活动" rightTitle:@"我的活动"];
    self.tableView.tableHeaderView = headView;
}

#pragma mark ----- addSubviews添加子控件
- (void)addSubviews
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 72;
    self.tableView = tableView;
    [self.view addSubview:tableView];
    
    [self setTableHeadFootView];
    
    SLClassScreenCoverView *classScreenCoverView = [[SLClassScreenCoverView alloc] initWithFrame:CGRectMake(0, 64, screenW, screenH)];
    classScreenCoverView.delegate = self;
    self.classScreenCoverView = classScreenCoverView;
    classScreenCoverView.hidden = YES;
    [self.view insertSubview:classScreenCoverView aboveSubview:self.tableView];
}

#pragma mark ----- 获取筛选数据
- (void)loadScreenData
{
    SLClassesListParameters *parameters = [SLClassesListParameters parameters];
    parameters.plateId = @4;
    
    [SLPlateInfoTool classesListInPlateWithParameters:parameters success:^(NSArray *classesArray) {
        
        self.classesArray = classesArray;
        self.classScreenCoverView.classesArray = classesArray;
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark ----- SLSwitchButtonView代理方法
- (void)switchButtonView:(SLSwitchButtonView *)switchButtonView didClickLeftButton:(UIButton *)leftButton
{
    self.flag = NO;
    [self.header beginRefreshing];
}
- (void)switchButtonView:(SLSwitchButtonView *)switchButtonView didClickRightButton:(UIButton *)rightButton
{
    self.flag = YES;
    [self.header beginRefreshing];
}

#pragma mark ----- 刷新数据的方法
- (void)setupRefreshView
{
    // 1.下拉刷新
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    header.scrollView = self.tableView;
    header.delegate = self;
    self.header = header;
    // 加载网络数据
    [header beginRefreshing];
    
    // 2.上拉刷新(上拉加载更多数据)
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = self.tableView;
    footer.delegate = self;
    self.footer = footer;
}

#pragma mark ----- 代理方法,mj刷新包的代理方法
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if ([refreshView isKindOfClass:[MJRefreshFooterView class]]) { // 上拉刷新
        [self loadMoreData];
    } else { // 下拉刷新
        [self loadNewData];
    }
}

#pragma mark ----- loadMoreData加载更多数据
- (void)loadMoreData
{
    self.currentPage += 1;
    self.parameters.curPage = [NSNumber numberWithLong:self.currentPage];
    
    [SLActivityTool activityListWithParameters:self.parameters success:^(NSArray *myActivityStatusList) {
        
        if (myActivityStatusList.count > 0) {
            [self.myActivityStatusList addObjectsFromArray:myActivityStatusList];
        } else {
            [MBProgressHUD showError:@"没有更多数据了..."];
        }
        
        
        [self.tableView reloadData];
        
        // 让刷新控件停止显示刷新状态
        [self.footer endRefreshing];
    } failure:^(NSError *error) {
        [self.footer endRefreshing];
    }];
}

#pragma mark ----- loadNewData向服务器获取最新的数据
- (void)loadNewData
{
    self.currentPage = 1;
    self.parameters.curPage = [NSNumber numberWithLong:self.currentPage];
    self.parameters.plateId = @4;
    if ([self.classId intValue] == 0) {
        self.parameters.classId = nil;
    } else {
        self.parameters.classId = self.classId;
    }
    self.parameters.flag = self.flag;
    
    [SLActivityTool activityListWithParameters:self.parameters success:^(NSArray *myActivityStatusList) {
        
        [self.myActivityStatusList removeAllObjects];
        
        if (myActivityStatusList.count > 0) {
            [self.myActivityStatusList addObjectsFromArray:myActivityStatusList];
        } else {
            [MBProgressHUD showError:@"没有相关数据..."];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Tableview datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.myActivityStatusList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SLActivityList *activityList = self.myActivityStatusList[indexPath.row];
    SLActivityListCellFrame *activityListCellFrame = [[SLActivityListCellFrame alloc] init];
    activityListCellFrame.activityList = activityList;
    
    SLActivityListCell *cell = [SLActivityListCell cellWithTableView:tableView];
    
    cell.activityListCellFrame = activityListCellFrame;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SLActivityList *activityList = self.myActivityStatusList[indexPath.row];
    SLActivityDetailController *advc = [[SLActivityDetailController alloc] init];
    advc.materialId = activityList.materialId;
    advc.title = @"活动详情";
    advc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:advc animated:YES];
}

#pragma mark ----- SLClassScreenCoverView代理方法
- (void)classScreenCoverView:(SLClassScreenCoverView *)classScreenCoverView didSelectedClassId:(NSNumber *)classId
{
    self.classId = classId;
    
    [self.header beginRefreshing];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.classScreenCoverView.alpha = 0;
    } completion:^(BOOL finished) {
        self.classScreenCoverView.hidden = YES;
        self.tableView.scrollEnabled = YES;
        self.tabBarController.tabBar.userInteractionEnabled = YES;
    }];
}

- (void)classScreenCoverViewDidTouchCoverView:(SLClassScreenCoverView *)classScreenCoverView
{
    if (classScreenCoverView.hidden == NO) {
        [UIView animateWithDuration:0.5 animations:^{
            classScreenCoverView.alpha = 0;
        } completion:^(BOOL finished) {
            classScreenCoverView.hidden = YES;
            self.tableView.scrollEnabled = YES;
            self.tabBarController.tabBar.userInteractionEnabled = YES;
        }];
    }
}

@end
