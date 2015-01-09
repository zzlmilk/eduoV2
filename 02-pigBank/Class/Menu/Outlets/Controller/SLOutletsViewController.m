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
        _parameters.latitude = [NSNumber numberWithDouble:self.location.coordinate.latitude];
        _parameters.longitude = [NSNumber numberWithDouble:self.location.coordinate.longitude];
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
        _scrollView = [[UIScrollView alloc] init];
    }
    return _scrollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SLMerchantHeadView *headView = [[SLMerchantHeadView alloc] init];
    headView.delegate = self;
    self.headView = headView;
    [headView setLeftButtonWithTitle:@"服务项目" imageName:@"xiaLa" highlightImageName:@"xiaLaJiaoHu"];
    [headView setRightButtonWithTitle:@"服务区域" imageName:@"xiaLa" highlightImageName:@"xiaLaJiaoHu"];
    self.tableView.tableHeaderView = headView;
    
    SLServiceItemCoverView *serviceItemView = [[SLServiceItemCoverView alloc] initWithFrame:CGRectMake(0, 40, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 40)];
    [self.view addSubview:serviceItemView];
    serviceItemView.delegate = self;
    self.serviceItemCoverView = serviceItemView;
    serviceItemView.hidden = YES;
    
    SLServiceAreaCoverView *serviceAreaView = [[SLServiceAreaCoverView alloc] initWithFrame:CGRectMake(0, 40, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 40)];
    [self.view addSubview:serviceAreaView];
    serviceAreaView.delegate = self;
    self.serviceAreaCoverView = serviceAreaView;
    serviceAreaView.hidden = YES;
    
    if (self.tag == 1) {
        // 设置左上角的barButton
        self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"iconMore" highlightImage:@"iconMorePress" target:self action:@selector(presentLeftMenuViewController:)];
    }
    
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
    
    // 集成刷新控件
    [self setupRefreshView];
    
    // 开始定位
    [self.locMgr startUpdatingLocation];
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
    
    [SLOutletsTool outletsListWithParameters:self.parameters success:^(NSArray *outletsArray) {
        
        [self.outletsArray addObjectsFromArray:outletsArray];
        
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
    
    self.parameters.curPage = [NSNumber numberWithLong:self.currentPage];
    self.parameters.serviceType = self.serviceType;
    self.parameters.outletsArea = self.outletsArea;
    
    [SLOutletsTool outletsListWithParameters:self.parameters success:^(NSArray *outletsArray) {
        self.outletsArray = nil;
        
        [self.outletsArray addObjectsFromArray:outletsArray];
        
        if (outletsArray.count > 19) {
            // 2.上拉刷新(上拉加载更多数据)
            MJRefreshFooterView *footer = [MJRefreshFooterView footer];
            footer.scrollView = self.tableView;
            footer.delegate = self;
            self.footer = footer;
        } else {
            self.footer.scrollView = self.scrollView;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 1;
//}

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
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark ----- SLMerchantHeadView的代理方法
- (void)merchantHeadView:(SLMerchantHeadView *)merchantHeadView didClickLeftButton:(SLRotateButton *)leftButton
{
    if (self.serviceItemCoverView.hidden == YES) {
        self.serviceItemCoverView.hidden = NO;
        self.serviceItemCoverView.alpha = 0;
        [UIView animateWithDuration:0.5 animations:^{
            self.serviceAreaCoverView.alpha = 0;
            self.serviceItemCoverView.alpha = 1;
        } completion:^(BOOL finished) {
            self.serviceAreaCoverView.hidden = YES;
            self.tableView.scrollEnabled = NO;
        }];
    } else {
        [UIView animateWithDuration:0.5 animations:^{
            self.serviceItemCoverView.alpha = 0;
        } completion:^(BOOL finished) {
            self.tableView.scrollEnabled = YES;
            self.serviceItemCoverView.hidden = YES;
        }];
    }
}
- (void)merchantHeadView:(SLMerchantHeadView *)merchantHeadView didClickRightButton:(SLRotateButton *)rightButton
{
    if (self.serviceAreaCoverView.hidden == YES) {
        self.serviceAreaCoverView.hidden = NO;
        self.serviceAreaCoverView.alpha = 0;
        [UIView animateWithDuration:0.5 animations:^{
            self.serviceItemCoverView.alpha = 0;
            self.serviceAreaCoverView.alpha = 1;
        } completion:^(BOOL finished) {
            self.serviceItemCoverView.hidden = YES;
            self.tableView.scrollEnabled = NO;
        }];
    } else {
        [UIView animateWithDuration:0.5 animations:^{
            self.serviceAreaCoverView.alpha = 0;
        } completion:^(BOOL finished) {
            self.serviceAreaCoverView.hidden = YES;
            self.tableView.scrollEnabled = YES;
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
    
    self.serviceItemCoverView.hidden = YES;
    self.tableView.scrollEnabled = YES;
    
    [self.locMgr startUpdatingLocation];
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
    
    self.serviceAreaCoverView.hidden = YES;
    self.tableView.scrollEnabled = YES;
    
    [self.locMgr startUpdatingLocation];
}

@end
