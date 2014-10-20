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

#import "SLAccountTool.h"
#import "SLHttpTool.h"
#import "SLOutletsTool.h"

#import "MJExtension.h"


@interface SLOutletsViewController () <CLLocationManagerDelegate, SLOutletsTableHeadViewDelegate, SLServiceItemCoverViewDelegate, SLServiceAreaCoverViewDelegate>

/** 位置管理者 */
@property (nonatomic, strong) CLLocationManager *locMgr;

@property (nonatomic, strong) CLLocation *location;

@property (nonatomic, strong) NSMutableArray *outletsArray;
@property (nonatomic, strong) NSMutableArray *serviceItemArray;
@property (nonatomic, strong) NSMutableArray *serviceAreaArray;

@property (nonatomic, weak) SLServiceAreaCoverView *serviceAreaCoverView;
@property (nonatomic, weak) SLServiceItemCoverView *serviceItemCoverView;

@property (nonatomic, weak) UIView *coverView;
@property (nonatomic, weak) UITableView *serviceItemView;

@property (nonatomic, copy) NSString *serviceType;
@property (nonatomic, strong) NSNumber *outletsArea;

@property (nonatomic, strong) SLOutletsParameters *parameters;

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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SLOutletsTableHeadView *headView = [[SLOutletsTableHeadView alloc] init];
    headView.delegate = self;
    headView.frame = CGRectMake(0, -40, [UIScreen mainScreen].bounds.size.width, 40);
    [self.view addSubview:headView];
    self.tableView.contentInset = UIEdgeInsetsMake(40, 0, 0, 0);
    
    SLServiceItemCoverView *serviceItemView = [[SLServiceItemCoverView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 40)];
    [self.view addSubview:serviceItemView];
    serviceItemView.delegate = self;
    self.serviceItemCoverView = serviceItemView;
    serviceItemView.hidden = YES;
    
    SLServiceAreaCoverView *serviceAreaView = [[SLServiceAreaCoverView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 40)];
    [self.view addSubview:serviceAreaView];
    serviceAreaView.delegate = self;
    self.serviceAreaCoverView = serviceAreaView;
    serviceAreaView.hidden = YES;
    
    UIView *coverView = [[UIView alloc] init];
    CGFloat coverViewX = 0;
    CGFloat coverViewY = 0;
    CGFloat coverViewW = [UIScreen mainScreen].bounds.size.width;
    CGFloat coverViewH = [UIScreen mainScreen].bounds.size.height - coverViewY - 64 - 40;
    coverView.frame = CGRectMake(coverViewX, coverViewY, coverViewW, coverViewH);
    coverView.backgroundColor = [UIColor redColor];
//    coverView.alpha = 0.5;
    coverView.hidden = YES;
    [self.view addSubview:coverView];
    self.coverView = coverView;
    
    UITableView *tableView = [[UITableView alloc] init];
    [self.view addSubview:tableView];
    tableView.tag = 10;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 150);
    tableView.hidden = YES;
    self.serviceItemView = tableView;
    
    // 获取网点服务类型列表数据
    NSString *url = [SLHttpUrl stringByAppendingString:@"/material/listOutletsServiceType"];
    [SLHttpTool postWithUrlstr:url parameters:nil success:^(id responseObject) {
        NSArray *dictArray = [responseObject[@"info"] lastObject];
        
        NSArray *serviceItemArray = [SLOutletsServiceItem objectArrayWithKeyValuesArray:dictArray];

        [self.serviceItemArray addObjectsFromArray:serviceItemArray];
        self.serviceItemCoverView.serviceItemArray = serviceItemArray;
        
        [self.serviceItemView reloadData];
        
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
            
            [self.serviceItemView reloadData];
        
        } failure:^(NSError *error) {
        
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    // 开始定位
    [self.locMgr startUpdatingLocation];
}

#pragma mark ------ CLLocationManager的代理方法
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    
    self.location = [locations firstObject];
    
    // 加载网络数据
    [self setupInternetData];
    
    [self.locMgr stopUpdatingLocation];
}

- (void)setupInternetData
{
    self.parameters.pageSize = @20;
    self.parameters.curPage = @1;
    self.parameters.search = @"";
    self.parameters.latitude = [NSNumber numberWithDouble:self.location.coordinate.latitude];
    self.parameters.longitude = [NSNumber numberWithDouble:self.location.coordinate.longitude];
    self.parameters.plateId = @3;
    self.parameters.serviceType = self.serviceType;
    self.parameters.outletsArea = self.outletsArea;
    
    [SLOutletsTool outletsListWithParameters:self.parameters success:^(NSArray *outletsArray) {
        [self.outletsArray addObjectsFromArray:outletsArray];
        
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView.tag == 10) {
        return (self.serviceItemArray.count + 1);
        
        
        self.serviceItemView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.serviceItemView.rowHeight * (self.serviceItemArray.count + 1));
    }
    return self.outletsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 10) {
        static NSString *ID = @"cell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        
        if (indexPath.row == 0) {
            cell.textLabel.text = @"所有项目";
        } else {
            SLOutletsServiceItem *serviceItem = self.serviceItemArray[(indexPath.row - 1)];
            cell.textLabel.text = serviceItem.dataText;
        }
        
        return cell;
    }
    
    SLOutletsListCell *cell = [SLOutletsListCell cellWithTableView:tableView];
    
    SLOutletsInfo *outlets = self.outletsArray[indexPath.row];
    SLOutletsListFrame *frame = [[SLOutletsListFrame alloc] init];
    frame.outletsInfo = outlets;
    
    cell.outletsListFrame = frame;
    
    return cell;
}

#pragma mark ----- tableHeadView的代理方法
- (void)outletsTableHeadView:(SLOutletsTableHeadView *)vipChildTableHeadView didClickServiceAreaButton:(UIButton *)serviceAreaButton
{
    if (self.serviceAreaCoverView.hidden == YES) {
        self.serviceAreaCoverView.hidden = NO;
        self.serviceItemCoverView.hidden = YES;
        self.tableView.scrollEnabled = NO;
    } else {
        self.serviceAreaCoverView.hidden = YES;
        self.tableView.scrollEnabled = YES;
    }
}

- (void)outletsTableHeadView:(SLOutletsTableHeadView *)vipChildTableHeadView didClickServiceItemButton:(UIButton *)serviceItemButton
{
//    UIView *coverView = [[UIView alloc] init];
//    CGFloat coverViewX = 0;
//    CGFloat coverViewY = 40;
//    CGFloat coverViewW = [UIScreen mainScreen].bounds.size.width;
//    CGFloat coverViewH = [UIScreen mainScreen].bounds.size.height - coverViewY;
//    coverView.frame = CGRectMake(coverViewX, coverViewY, coverViewW, coverViewH);
//    coverView.backgroundColor = [UIColor blackColor];
////    coverView.alpha = 0.5;
//    [self.view addSubview:coverView];
//
//    UITableView *tableView = [[UITableView alloc] init];
//    [coverView addSubview:tableView];
//    tableView.tag = 10;
//    tableView.delegate = self;
//    tableView.dataSource = self;
//    tableView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 150);
    
//    UITableView *serviceItemTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
//    self.serviceItemCoverView.hidden = NO;
//    self.tableView.userInteractionEnabled = NO;
    if (self.serviceItemCoverView.hidden == YES) {
        self.serviceItemCoverView.hidden = NO;
        self.serviceAreaCoverView.hidden = YES;
        self.tableView.scrollEnabled = NO;
    } else {
        self.serviceItemCoverView.hidden = YES;
        self.tableView.scrollEnabled = YES;
    }
}

#pragma mark ----- cover的代理方法
- (void)serviceItemCoverView:(SLServiceItemCoverView *)serviceItemCoverView didSelectedServiceItem:(SLOutletsServiceItem *)serviceItem
{
    self.parameters.serviceType = [NSString stringWithFormat:@"%@", serviceItem.dataValue];
    
    self.serviceItemView.hidden = YES;
    
    [self setupInternetData];
}

- (void)serviceAreaCoverView:(SLServiceAreaCoverView *)serviceAreaCoverView didSelectedChildrenArea:(SLChildrenAreaList *)childrenArea
{
    self.parameters.outletsArea = childrenArea.areaId;
    
    self.serviceAreaCoverView.hidden = YES;
    
    [self setupInternetData];
}

@end
