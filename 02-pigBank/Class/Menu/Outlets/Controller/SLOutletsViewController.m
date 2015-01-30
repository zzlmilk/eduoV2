//
//  SLOutletsViewController.m
//  02-pigBank
//
//  Created by 陆承东 on 14-10-16.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

#import "SLOutletsViewController.h"

#import "SLOutletsParameters.h"
#import "SLOutletsInfo.h"
#import "SLOutletsServiceItem.h"
#import "SLOutletsServiceArea.h"
#import "SLChildrenAreaList.h"

#import "SLOutletsListCell.h"
#import "SLOutletsTableHeadView.h"
#import "SLServiceItemCoverView.h"
#import "SLServiceAreaCoverView.h"
#import "SLMerchantHeadView.h"

#import "SLOutletDetialController.h"

#import "SLAccountTool.h"
#import "SLHttpTool.h"
#import "SLOutletsTool.h"
#import "UIBarButtonItem+SL.h"

#import "MJExtension.h"
#import "MJRefresh.h"
#import "UIViewController+REXSideMenu.h"


@interface SLOutletsViewController () <CLLocationManagerDelegate, SLOutletsTableHeadViewDelegate, SLServiceItemCoverViewDelegate, SLServiceAreaCoverViewDelegate, MJRefreshBaseViewDelegate, SLMerchantHeadViewDelegate>

/** 位置管理者 */
@property (nonatomic, strong) CLLocationManager *locMgr;

@property (nonatomic, strong) CLLocation *location;

@property (nonatomic, strong) NSMutableArray *outletsArray;
@property (nonatomic, strong) NSMutableArray *serviceItemArray;
@property (nonatomic, strong) NSMutableArray *serviceAreaArray;

@property (nonatomic, weak) SLServiceAreaCoverView *serviceAreaCoverView;
@property (nonatomic, weak) SLServiceItemCoverView *serviceItemCoverView;

@property (nonatomic, copy) NSString *serviceType;
@property (nonatomic, strong) NSNumber *outletsArea;

@property (nonatomic, strong) SLOutletsParameters *parameters;

@property (nonatomic, weak) MJRefreshHeaderView *header;
@property (nonatomic, weak) MJRefreshFooterView *footer;

@property (nonatomic, assign) long currentPage;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) SLMerchantHeadView *headView;

@end

@implementation SLOutletsViewController

- (NSMutableArray *)outletsArray
{
    if (_outletsArray == nil) {
        _outletsArray = [NSMutableArray array];
    }
    return _outletsArray;
}
- (NSMutableArray *)serviceItemArray
{
    if (_serviceItemArray == nil) {
        _serviceItemArray = [NSMutableArray array];
    }
    return _serviceItemArray;
}
-(NSMutableArray *)serviceAreaArray
{
    if (_serviceAreaArray == nil) {
        _serviceAreaArray = [NSMutableArray array];
    }
    return _serviceAreaArray;
}
- (SLOutletsParameters *)parameters
{
    if (_parameters == nil) {
        _parameters = [SLOutletsParameters parameters];
        _parameters.search = @"";
        _parameters.plateId = @3;
        _parameters.pageSize = @20;
    }
    return _parameters;
}
- (CLLocationManager *)locMgr
{
    if (![CLLocationManager locationServicesEnabled]) return nil;
    
    if (_locMgr == nil) {
        _locMgr = [[CLLocationManager alloc] init];
        _locMgr.delegate = self;
    }
    return _locMgr;
}
- (UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(-100, 0, 10, 10)];
    }
    return _scrollView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setNavBar];
}

#pragma mark ----- setNavBar设置导航栏
- (void)setNavBar
{
    // 设置左上角的barButton
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"iconMorePress" highlightImage:@"iconMore" target:self action:@selector(presentLeftMenuViewController:)];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self loadFilterData];
    
    [self setTableHeadFootView];
    
    [self addSubviews];
    
    // 集成刷新控件
    [self setupRefreshView];
    
    // 开始定位
    [self.locMgr startUpdatingLocation];
}

- (void)addSubviews
{
    SLServiceItemCoverView *serviceItemView = [[SLServiceItemCoverView alloc] initWithFrame:CGRectMake(0, 40, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 40)];
    serviceItemView.delegate = self;
    self.serviceItemCoverView = serviceItemView;
    serviceItemView.hidden = YES;
    [self.view insertSubview:serviceItemView aboveSubview:self.tableView];
    
    SLServiceAreaCoverView *serviceAreaView = [[SLServiceAreaCoverView alloc] initWithFrame:CGRectMake(0, 40, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 40)];
    serviceAreaView.delegate = self;
    self.serviceAreaCoverView = serviceAreaView;
    serviceAreaView.hidden = YES;
    [self.view insertSubview:serviceAreaView aboveSubview:self.tableView];
}

- (void)setTableHeadFootView
{
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenW, 0.5)];
    footView.backgroundColor = [UIColor lightGrayColor];
    self.tableView.tableFooterView = footView;
    
    SLMerchantHeadView *headView = [[SLMerchantHeadView alloc] init];
    headView.delegate = self;
    self.headView = headView;
    [headView setLeftButtonTitle:@"服务项目" rightButtonTitle:@"服务区域"];
    self.tableView.tableHeaderView = headView;
}

- (void)loadFilterData
{
    // 获取网点服务类型列表数据
    NSString *url = [SLHttpUrl stringByAppendingString:@"/material/listOutletsServiceType"];
    [SLHttpTool postWithUrlstr:url parameters:nil success:^(id responseObject) {
        
        NSArray *dictArray = [responseObject[@"info"] lastObject];
        
        NSArray *serviceItemArray = [SLOutletsServiceItem objectArrayWithKeyValuesArray:dictArray];
        
        [self.serviceItemArray addObjectsFromArray:serviceItemArray];
        self.serviceItemCoverView.serviceItemArray = serviceItemArray;
        
    } failure:^(NSError *error) {
        
    }];
    
    // 获取网点分区二级列表接口
    NSString *url1 = [SLHttpUrl stringByAppendingString:@"/material/listOutletsAreaInfo"];
    [SLHttpTool postWithUrlstr:url1 parameters:nil success:^(id responseObject) {
        NSArray *dictArray = [responseObject[@"info"] lastObject];
        
        NSMutableArray *serviceAreaArray = [NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            SLOutletsServiceArea *serviceArea = [SLOutletsServiceArea objectWithKeyValues:dict];
            
            [serviceAreaArray addObject:serviceArea];
        }
        
        [self.serviceAreaArray addObjectsFromArray:serviceAreaArray];
        self.serviceAreaCoverView.serviceAreaArray = serviceAreaArray;
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark ----- 刷新数据的方法
/**
 *  集成刷新控件
 */
- (void)setupRefreshView
{
    // 1.下拉刷新
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    header.scrollView = self.tableView;
    header.delegate = self;
    self.header = header;
    
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
    
    [SLOutletsTool outletsListWithParameters:self.parameters success:^(NSArray *outletsArray) {
        
        if (outletsArray.count > 0) {
            [self.outletsArray addObjectsFromArray:outletsArray];
            
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

#pragma mark ----- loadNewData向服务器获取最新的数据
- (void)loadNewData
{
    self.currentPage = 1;
    
    self.parameters.curPage = [NSNumber numberWithLong:self.currentPage];
    self.parameters.serviceType = self.serviceType;
    self.parameters.outletsArea = self.outletsArea;
    if (self.location) {
        self.parameters.latitude = [NSNumber numberWithDouble:self.location.coordinate.latitude];
        self.parameters.longitude = [NSNumber numberWithDouble:self.location.coordinate.longitude];
    }
    
    [SLOutletsTool outletsListWithParameters:self.parameters success:^(NSArray *outletsArray) {
        [self.outletsArray removeAllObjects];
        
        if (outletsArray.count > 0) {
            [self.outletsArray addObjectsFromArray:outletsArray];
        } else {
            [MBProgressHUD showError:@"没有相关数据"];
        }
        
        
        [self.tableView reloadData];
        
        // 让刷新控件停止显示刷新状态
        [self.header endRefreshing];
    } failure:^(NSError *error) {
        // 让刷新控件停止显示刷新状态
        [self.header endRefreshing];
        
    }];
}

- (void)dealloc
{
    // 释放内存
    [self.header free];
    [self.footer free];
}

#pragma mark ------ CLLocationManager的代理方法
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    
    self.location = [locations firstObject];
    
    // 加载网络数据
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

#pragma mark ----- Tableview datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.outletsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SLOutletsListCell *cell = [SLOutletsListCell cellWithTableView:tableView];
    
    SLOutletsInfo *outlets = self.outletsArray[indexPath.row];
    SLOutletsListFrame *frame = [[SLOutletsListFrame alloc] init];
    frame.outletsInfo = outlets;
    
    cell.outletsListFrame = frame;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SLOutletsInfo *outletsInfo = self.outletsArray[indexPath.row];
    SLOutletDetialController *vc = [[SLOutletDetialController alloc] init];
    vc.materialId = outletsInfo.materialId;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark ----- SLMerchantHeadView的代理方法
- (void)merchantHeadView:(SLMerchantHeadView *)merchantHeadView didClickLeftButton:(SLRotateButton *)leftButton
{
    if (self.serviceItemCoverView.hidden == YES) {
        self.serviceItemCoverView.hidden = NO;
        self.serviceItemCoverView.alpha = 0;
        self.tableView.scrollEnabled = NO;
        self.tabBarController.tabBar.userInteractionEnabled = NO;
        [UIView animateWithDuration:0.5 animations:^{
            self.serviceAreaCoverView.alpha = 0;
            self.serviceItemCoverView.alpha = 1;
        } completion:^(BOOL finished) {
            self.serviceAreaCoverView.hidden = YES;
        }];
    } else {
        [UIView animateWithDuration:0.5 animations:^{
            self.serviceItemCoverView.alpha = 0;
        } completion:^(BOOL finished) {
            self.serviceItemCoverView.hidden = YES;
            self.tableView.scrollEnabled = YES;
            self.tabBarController.tabBar.userInteractionEnabled = YES;
        }];
    }
}
- (void)merchantHeadView:(SLMerchantHeadView *)merchantHeadView didClickRightButton:(SLRotateButton *)rightButton
{
    if (self.serviceAreaCoverView.hidden == YES) {
        self.serviceAreaCoverView.hidden = NO;
        self.serviceAreaCoverView.alpha = 0;
        self.tableView.scrollEnabled = NO;
        self.tabBarController.tabBar.userInteractionEnabled = NO;
        [UIView animateWithDuration:0.5 animations:^{
            self.serviceItemCoverView.alpha = 0;
            self.serviceAreaCoverView.alpha = 1;
        } completion:^(BOOL finished) {
            self.serviceItemCoverView.hidden = YES;
        }];
    } else {
        [UIView animateWithDuration:0.5 animations:^{
            self.serviceAreaCoverView.alpha = 0;
        } completion:^(BOOL finished) {
            self.serviceAreaCoverView.hidden = YES;
            self.tableView.scrollEnabled = YES;
            self.tabBarController.tabBar.userInteractionEnabled = YES;
        }];
    }
}

#pragma mark ----- cover的代理方法
- (void)serviceItemCoverView:(SLServiceItemCoverView *)serviceItemCoverView didSelectedServiceItem:(SLOutletsServiceItem *)serviceItem
{
    [self.headView setLeftButtonStatusNormal];
    if (serviceItem == nil) {
        self.serviceType = @"";
        [self.headView setLeftButtonWithTitle:@"所有项目"];
    } else {
        self.serviceType = [NSString stringWithFormat:@"%@", serviceItem.dataValue];
        [self.headView setLeftButtonWithTitle:serviceItem.dataText];
    }
    
    serviceItemCoverView.hidden = YES;
    self.tableView.scrollEnabled = YES;
    self.tabBarController.tabBar.userInteractionEnabled = YES;
    
    [self.locMgr startUpdatingLocation];
}
- (void)serviceItemCoverViewDidTouchCoverView:(SLServiceItemCoverView *)serviceItemCoverView
{
    if (serviceItemCoverView.hidden == NO) {
        [UIView animateWithDuration:0.5 animations:^{
            serviceItemCoverView.alpha = 0;
            [self.headView setLeftButtonStatusNormal];
        } completion:^(BOOL finished) {
            serviceItemCoverView.hidden = YES;
            self.tableView.scrollEnabled = YES;
            self.tabBarController.tabBar.userInteractionEnabled = YES;
        }];
    }
}

- (void)serviceAreaCoverView:(SLServiceAreaCoverView *)serviceAreaCoverView didSelectedChildrenArea:(SLChildrenAreaList *)childrenArea
{
    [self.headView setRightButtonStatusNormal];
    if (childrenArea == nil) {
        self.outletsArea = nil;
        [self.headView setRightButtonWithTitle:@"所有区域"];
    } else {
        self.outletsArea = childrenArea.areaId;
        [self.headView setRightButtonWithTitle:childrenArea.areaName];
    }
    
    serviceAreaCoverView.hidden = YES;
    self.tableView.scrollEnabled = YES;
    self.tabBarController.tabBar.userInteractionEnabled = YES;
    
    [self.locMgr startUpdatingLocation];
}
- (void)serviceAreaCoverViewDidTouchCoverView:(SLServiceAreaCoverView *)serviceAreaCoverView
{
    if (serviceAreaCoverView.hidden == NO) {
        [UIView animateWithDuration:0.5 animations:^{
            [self.headView setRightButtonStatusNormal];
            serviceAreaCoverView.alpha = 0;
        } completion:^(BOOL finished) {
            serviceAreaCoverView.hidden = YES;
            self.tableView.scrollEnabled = YES;
            self.tabBarController.tabBar.userInteractionEnabled = YES;
        }];
    }
}

@end
