//
//  SLVipChildViewController.m
//  02-pigBank
//
//  Created by 陆承东 on 14-10-14.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

#import "SLVipChildViewController.h"

#import "SLVipChildClassParameters.h"
#import "SLPlateInfo.h"

#import "SLVipStatusCell.h"
#import "SLVipChildTableHeadView.h"
#import "SLBackButton.h"

#import "SLVipProductViewController.h"

#import "SLVipChildClassTool.h"
#import "SLPlateInfoTool.h"

@interface SLVipChildViewController () <CLLocationManagerDelegate, SLVipChildTableHeadViewDelegate, MJRefreshBaseViewDelegate>

/** 位置管理者 */
@property (nonatomic, strong) CLLocationManager *locMgr;

@property (nonatomic, strong) CLLocation *location;

/** vipStatusFrame */
@property (nonatomic, strong) NSMutableArray *vipStatusFrames;

/** headView */
@property (nonatomic, weak) UIView *headView;

@property (nonatomic, copy) NSString *scale;

/** 刷新 */
@property (nonatomic, weak) MJRefreshHeaderView *header;
@property (nonatomic, weak) MJRefreshFooterView *footer;

@property (nonatomic, assign) long currentPage;

@property (nonatomic, strong) SLVipChildClassParameters *parameters;

@end

@implementation SLVipChildViewController

- (CLLocationManager *)locMgr
{
    if (![CLLocationManager locationServicesEnabled]) return nil;
    
    if (_locMgr == nil) {
        _locMgr = [[CLLocationManager alloc] init];
        _locMgr.delegate = self;
    }
    return _locMgr;
}
- (SLVipChildClassParameters *)parameters
{
    if (_parameters == nil) {
        _parameters = [SLVipChildClassParameters parameters];
        _parameters.pageSize = @20;
        _parameters.plateId = self.plateId;
    }
    return _parameters;
}
-(NSMutableArray *)vipStatusFrames
{
    if (_vipStatusFrames == nil) {
        _vipStatusFrames = [NSMutableArray array];
    }
    return _vipStatusFrames;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    SLBackButton *backButton = [SLBackButton button];
    [backButton addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backItem;
}

#pragma mark ----- backButtonClicked返回按钮点击事件
- (void)backButtonClicked:(SLBackButton *)backButton
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTableHeadFootView];
    
    [self.locMgr startUpdatingLocation];
    
    self.tableView.rowHeight = 70;
    
    // 集成刷新控件
    [self setupRefreshView];
}

#pragma mark ----- 设置tableHeadFootView
- (void)setTableHeadFootView
{
    SLVipChildTableHeadView *headView = [[SLVipChildTableHeadView alloc] init];
    headView.delegate = self;
    self.tableView.tableHeaderView = headView;
    self.headView = headView;
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenW, 0.5)];
    footView.backgroundColor = SLLightGray;
    self.tableView.tableFooterView = footView;
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
    int currentPage = [self.parameters.curPage intValue];
    currentPage += 1;
    self.parameters.curPage = [NSNumber numberWithInt:currentPage];
    
    // 3.发送请求
    [SLVipChildClassTool vipChildStatusesWithParameters:self.parameters success:^(NSArray *vipChildStatusFrameArray) {
        
        if (vipChildStatusFrameArray.count > 0) {
            [self.vipStatusFrames addObjectsFromArray:vipChildStatusFrameArray];
            
            [self.tableView reloadData];
        } else {
            [MBProgressHUD showError:@"没有更多数据了..."];
            int currentPage = [self.parameters.curPage intValue];
            currentPage -= 1;
            self.parameters.curPage = [NSNumber numberWithInt:currentPage];
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
    self.parameters.curPage = @1;
    self.parameters.classId = self.classId;
    self.parameters.scale = self.scale;
    self.parameters.latitude = [NSNumber numberWithDouble:self.location.coordinate.latitude];
    self.parameters.longitude = [NSNumber numberWithDouble:self.location.coordinate.longitude];
    
    // 3.发送请求
    [SLVipChildClassTool vipChildStatusesWithParameters:self.parameters success:^(NSArray *vipChildStatusFrameArray) {
        
        if (vipChildStatusFrameArray.count > 0) {
            [self.vipStatusFrames removeAllObjects];
            [self.vipStatusFrames addObjectsFromArray:vipChildStatusFrameArray];
            
            [self.tableView reloadData];
        } else {
            [MBProgressHUD showError:@"没有相关数据"];
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

#pragma mark ----- SLVipChildTableHeadView代理方法
- (void)vipChildTableHeadView:(SLVipChildTableHeadView *)vipChildTableHeadView didClickLocalButton:(UIButton *)localButton
{
    self.scale = @"1";
    
    [self.locMgr startUpdatingLocation];
}
-(void)vipChildTableHeadView:(SLVipChildTableHeadView *)vipChildTableHeadView didClickNationwideButton:(UIButton *)nationwideButton
{
    self.scale = @"2";
    
    [self.locMgr startUpdatingLocation];
}

#pragma mark ----- CLLocationManager的代理方法
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    self.location = [locations firstObject];
    
    [self.header beginRefreshing];
    
    [self.locMgr stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    [self.header beginRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.vipStatusFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SLVipStatusFrame *vipStatusFrame = self.vipStatusFrames[indexPath.row];
    
    // 创建cell
    SLVipStatusCell *cell = [SLVipStatusCell cellWithTableView:tableView];
    
    // 给cell传递数据
    cell.vipStatusFrame = vipStatusFrame;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SLVipStatusFrame *vsf = self.vipStatusFrames[indexPath.row];
    SLVipStatus *vipStatus = vsf.vipStatus;
    SLVipProductViewController *vipProductController = [[SLVipProductViewController alloc] init];
    vipProductController.materialId = vipStatus.firstMaterialInfo.materialId;
    [self.navigationController pushViewController:vipProductController animated:YES];
}

@end
