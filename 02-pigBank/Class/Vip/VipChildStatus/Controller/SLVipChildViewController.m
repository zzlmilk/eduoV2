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

#import "SLVipStatusCell.h"
#import "SLVipChildTableHeadView.h"

#import "SLVipProductViewController.h"

#import "SLVipChildClassTool.h"

#import "MJRefresh.h"

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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /**
     *  添加tableHeadView
     */
    SLVipChildTableHeadView *headView = [[SLVipChildTableHeadView alloc] init];
    headView.delegate = self;
    self.tableView.tableHeaderView = headView;
    self.headView = headView;
    
    [self.locMgr startUpdatingLocation];
    
    self.tableView.rowHeight = 70;
    
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
    
    // 3.发送请求
    [SLVipChildClassTool vipChildStatusesWithParameters:self.parameters success:^(NSArray *vipChildStatusFrameArray) {
        
        [self.vipStatusFrames addObjectsFromArray:vipChildStatusFrameArray];
        
        if (vipChildStatusFrameArray.count > 19) {
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
/**
 *  // 刷新数据(向服务器获取更新的数据)
 */
- (void)loadNewData
{
    self.currentPage = 1;
#warning ----- 我觉的这个数据不需要缓存,因为取数据时需要传入位置信息,而位置信息几乎不可能相同,所以即使缓存了当传入的坐标不一致时也无法获取到数据库中的信息,而且这样会增大数据库的冗余信息~
    
    // 封装请求数据
    self.parameters.plateId = @1;
    self.parameters.classId = self.classId;
    self.parameters.scale = self.scale;
    self.parameters.latitude = [NSNumber numberWithDouble:self.location.coordinate.latitude];
    self.parameters.longitude = [NSNumber numberWithDouble:self.location.coordinate.longitude];
    self.parameters.pageSize = @20;
    self.parameters.curPage = [NSNumber numberWithLong:self.currentPage];
    
    // 3.发送请求
    [SLVipChildClassTool vipChildStatusesWithParameters:self.parameters success:^(NSArray *vipChildStatusFrameArray) {
        
        self.vipStatusFrames = nil;
        [self.vipStatusFrames addObjectsFromArray:vipChildStatusFrameArray];
        
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

//- (void)setupInternetData
//{
//    SLVipChildClassParameters *parameters = [SLVipChildClassParameters parameters];
//    
//#warning ----- 我觉的这个数据不需要缓存,因为取数据时需要传入位置信息,而位置信息几乎不可能相同,所以即使缓存了当传入的坐标不一致时也无法获取到数据库中的信息,而且这样会增大数据库的冗余信息~
//    
//    // 封装请求数据
//    parameters.plateId = @1;
//    parameters.classId = self.classId;
//    parameters.scale = self.scale;
//    parameters.latitude = [NSNumber numberWithDouble:self.location.coordinate.latitude];
//    parameters.longitude = [NSNumber numberWithDouble:self.location.coordinate.longitude];
//    parameters.pageSize = @20;
//    parameters.curPage = @1;
//    
//    // 3.发送请求
//    [SLVipChildClassTool vipChildStatusesWithParameters:parameters success:^(NSArray *vipChildStatusFrameArray) {
//        
//        self.vipStatusFrames = vipChildStatusFrameArray;
//        
//        [self.tableView reloadData];
//        
//    } failure:^(NSError *error) {
//        
//    }];
//}

#pragma mark ----- CLLocationManager的代理方法
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    self.location = [locations firstObject];
    
    [self.header beginRefreshing];
    
    [self.locMgr stopUpdatingLocation];
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
    
    if (vipStatus.firstMaterialInfo.templetType == 2) {
        SLVipProductViewController *vipProductController = [[SLVipProductViewController alloc] init];
        
        vipProductController.vipStatus = vipStatus;
        
        [self.navigationController pushViewController:vipProductController animated:YES];
        
    } else {
        //        self.titleLabel.text = [NSString stringWithFormat:@"【VIP特权】%@", homeStatus.title];
    }
}

@end
