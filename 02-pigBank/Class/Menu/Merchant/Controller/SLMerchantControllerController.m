//
//  SLMerchantControllerController.m
//  02-pigBank
//
//  Created by 陆承东 on 14-10-17.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

#import "SLMerchantControllerController.h"

#import "SLMerchantParameters.h"
#import "SLOutletsServiceArea.h"
#import "SLChildrenScope.h"
#import "SLMerchantStatusFrame.h"

#import "SLMerchantHeadView.h"
#import "SLMerchantTypeCoverView.h"
#import "SLMerchantAreaCoverView.h"
#import "SLMerchantCell.h"

#import "SLMerchantDetailController.h"

#import "SLMerchantTool.h"
#import "SLHttpTool.h"

#import "MJExtension.h"
#import "MJRefresh.h"

@interface SLMerchantControllerController ()<CLLocationManagerDelegate, SLMerchantHeadViewDelegate, SLMerchantTypeCoverViewDelegate, SLMerchantAreaCoverViewDelegate, MJRefreshBaseViewDelegate>

/** 位置管理者 */
@property (nonatomic, strong) CLLocationManager *locMgr;

@property (nonatomic, strong) CLLocation *location;

@property (nonatomic, strong) NSMutableArray *childrenAreaArray;
@property (nonatomic, strong) NSMutableArray *childrenScopeArray;
@property (nonatomic, strong) NSMutableArray *merchantArray;

@property (nonatomic, strong) SLMerchantHeadView *headView;

@property (nonatomic, strong) SLMerchantTypeCoverView *typeCover;
@property (nonatomic, strong) SLMerchantAreaCoverView *areaCover;

@property (nonatomic, strong) SLMerchantParameters *parameters;

@property (nonatomic, weak) MJRefreshHeaderView *header;
@property (nonatomic, weak) MJRefreshFooterView *footer;

@property (nonatomic, assign) long currentPage;

/** scopeId */
@property (nonatomic, strong) NSNumber *scopeId;

/** areaId */
@property (nonatomic, strong) NSNumber *areaId;

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation SLMerchantControllerController

-(NSMutableArray *)childrenAreaArray
{
    if (_childrenAreaArray == nil) {
        _childrenAreaArray = [NSMutableArray array];
    }
    return _childrenAreaArray;
}
-(NSMutableArray *)childrenScopeArray
{
    if (_childrenScopeArray == nil) {
        _childrenScopeArray = [NSMutableArray array];
    }
    return _childrenScopeArray;
}
- (NSMutableArray *)merchantArray
{
    if (_merchantArray == nil) {
        _merchantArray = [NSMutableArray array];
    }
    return _merchantArray;
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
- (SLMerchantParameters *)parameters
{
    if (_parameters == nil) {
        _parameters = [SLMerchantParameters parameters];
        _parameters.pageSize = @20;
        _parameters.search = @"";
        _parameters.latitude = [NSNumber numberWithDouble:self.location.coordinate.latitude];
        _parameters.longitude = [NSNumber numberWithDouble:self.location.coordinate.longitude];
    }
    return _parameters;
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
    
//    [self.tableView setSeparatorColor:[UIColor clearColor]];
    
    SLMerchantHeadView *headView = [[SLMerchantHeadView alloc] init];
    headView.delegate = self;
    self.headView = headView;
    [headView setLeftButtonWithTitle:@"所有类型" imageName:@"xiaLa" highlightImageName:@"xiaLaJiaoHu"];
    [headView setRightButtonWithTitle:@"所有区域" imageName:@"xiaLa" highlightImageName:@"xiaLaJiaoHu"];
    self.tableView.tableHeaderView = headView;
    
    SLMerchantTypeCoverView *typeCover = [[SLMerchantTypeCoverView alloc] initWithFrame:CGRectMake(0, 40, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    typeCover.delegate = self;
    self.typeCover = typeCover;
        typeCover.hidden = YES;
    [self.view addSubview:typeCover];
    
    SLMerchantAreaCoverView *areaCover = [[SLMerchantAreaCoverView alloc] initWithFrame:CGRectMake(0, 40, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    areaCover.delegate = self;
    self.areaCover = areaCover;
    areaCover.hidden = YES;
    [self.view addSubview:areaCover];
    
    // 获取商户业务范围（行业类型）二级列表接口
    NSString *serviceTypeUrl = [SLHttpUrl stringByAppendingString:@"/merchant/listMerchantBusinessScope"];
    
    [SLHttpTool postWithUrlstr:serviceTypeUrl parameters:nil success:^(id responseObject) {
        
        NSArray *dictArray = [responseObject[@"info"] lastObject];
        
        NSMutableArray *childrenScopeArray = [NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            SLChildrenScope *childrenScope = [SLChildrenScope objectWithKeyValues:dict];
            
            [childrenScopeArray addObject:childrenScope];
        }
        self.childrenScopeArray = nil;
        [self.childrenScopeArray addObjectsFromArray:childrenScopeArray];
        self.typeCover.merchantChildScopeArray = childrenScopeArray;
        
    } failure:^(NSError *error) {
        
    }];
    
    // 获取商户服务区域数据
    NSString *url = [SLHttpUrl stringByAppendingString:@"/merchant/listMerchantAreaInfo"];
    
    [SLHttpTool postWithUrlstr:url parameters:nil success:^(id responseObject) {
        
        NSArray *dictArray = [responseObject[@"info"] lastObject];
        
        NSMutableArray *merchantAreaArray = [NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            SLChildrenArea *childrenArea = [SLChildrenArea objectWithKeyValues:dict];
            
            [merchantAreaArray addObject:childrenArea];
        }
        self.childrenAreaArray = nil;
        [self.childrenAreaArray addObjectsFromArray:merchantAreaArray];
        self.areaCover.merchantChildAreaArray = merchantAreaArray;
        
    } failure:^(NSError *error) {
        
    }];
    
    // 集成刷新控件
    [self setupRefreshView];
    
    self.tableView.rowHeight = 70;
    
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
    
    [SLMerchantTool merchantWithParameters:self.parameters success:^(NSArray *merchantArray) {
        
        [self.merchantArray addObjectsFromArray:merchantArray];
        
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
    
    self.parameters.areaId = self.areaId;
    self.parameters.scopeId = self.scopeId;
    self.parameters.curPage = [NSNumber numberWithLong:self.currentPage];
    
    [SLMerchantTool merchantWithParameters:self.parameters success:^(NSArray *merchantArray) {
        self.merchantArray = nil;
        
        [self.merchantArray addObjectsFromArray:merchantArray];
        
        if (merchantArray.count > 19) {
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
    [super viewWillAppear:animated];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.merchantArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SLMerchantCell *cell = [SLMerchantCell cellWithTableView:tableView];
    
    SLVipMerchantDetail *merchantDetail = self.merchantArray[indexPath.row];
    SLMerchantStatusFrame *merchantStatusFrame = [[SLMerchantStatusFrame alloc] init];
    merchantStatusFrame.merchantDetial = merchantDetail;
    cell.merchantStatusFrame = merchantStatusFrame;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SLVipMerchantDetail *merchantDetial = self.merchantArray[indexPath.row];
    SLMerchantDetailController *mdvc = [[SLMerchantDetailController alloc] initWithStyle:UITableViewStyleGrouped];
    mdvc.vipMerchantDetail = merchantDetial;
    mdvc.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.navigationController pushViewController:mdvc animated:YES];
}

#pragma mark ----- SLMerchantHeadView的代理方法
- (void)merchantHeadView:(SLMerchantHeadView *)merchantHeadView didClickLeftButton:(SLRotateButton *)leftButton
{
    if (self.typeCover.hidden == YES) {
        self.typeCover.hidden = NO;
        self.typeCover.alpha = 0;
        [UIView animateWithDuration:0.5 animations:^{
            self.areaCover.alpha = 0;
            self.typeCover.alpha = 1;
        } completion:^(BOOL finished) {
            self.areaCover.hidden = YES;
            self.tableView.scrollEnabled = NO;
        }];
    } else {
        [UIView animateWithDuration:0.5 animations:^{
            self.typeCover.alpha = 0;
        } completion:^(BOOL finished) {
            self.typeCover.hidden = YES;
            self.tableView.scrollEnabled = YES;
        }];
    }
}
- (void)merchantHeadView:(SLMerchantHeadView *)merchantHeadView didClickRightButton:(SLRotateButton *)rightButton
{
    if (self.areaCover.hidden == YES) {
        self.areaCover.hidden = NO;
        self.areaCover.alpha = 0;
        [UIView animateWithDuration:0.5 animations:^{
            self.typeCover.alpha = 0;
            self.areaCover.alpha = 1;
        } completion:^(BOOL finished) {
            self.typeCover.hidden = YES;
            self.tableView.scrollEnabled = NO;
        }];
    } else {
        [UIView animateWithDuration:0.5 animations:^{
            self.areaCover.alpha = 0;
        } completion:^(BOOL finished) {
            self.areaCover.hidden = YES;
            self.tableView.scrollEnabled = YES;
        }];
    }
}

#pragma mark ----- MerchantTypeCoverView代理方法
- (void)merchantTypeCoverView:(SLMerchantTypeCoverView *)merchantTypeCoverView didSelectedChildrenScope:(SLChildrenScope *)childrenScope
{
    self.scopeId = childrenScope.scopeId;
    
    self.tableView.scrollEnabled = YES;
    self.typeCover.hidden = YES;
    [self.headView setLeftButtonStatusNormal];
    if (childrenScope == nil) {
        [self.headView setLeftButtonWithTitle:@"全部类型"];
    } else {
        [self.headView setLeftButtonWithTitle:childrenScope.scopeName];
    }
    
    [self.locMgr startUpdatingLocation];
}

#pragma mark ----- MerchantAreaCoverView代理方法
- (void)merchantAreaCoverView:(SLMerchantAreaCoverView *)merchantAreaCoverView didSelectedChildrenArea:(SLChildrenArea *)childrenArea
{
    self.areaId = childrenArea.areaId;
    
    self.tableView.scrollEnabled = YES;
    self.areaCover.hidden = YES;
    [self.headView setRightButtonStatusNormal];
    if (childrenArea == nil) {
        [self.headView setRightButtonWithTitle:@"全部区域"];
    } else {
        [self.headView setRightButtonWithTitle:childrenArea.areaName];
    }
    
    [self.locMgr startUpdatingLocation];
}
@end
