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

#import "SLMerchantTool.h"
#import "SLHttpTool.h"

#import "MJExtension.h"

@interface SLMerchantControllerController ()<CLLocationManagerDelegate>

/** 位置管理者 */
@property (nonatomic, strong) CLLocationManager *locMgr;

@property (nonatomic, strong) CLLocation *location;

@property (nonatomic, strong) NSMutableArray *serviceAreaArray;
@property (nonatomic, strong) NSMutableArray *serviceTypeArray;

@end

@implementation SLMerchantControllerController

-(NSMutableArray *)serviceAreaArray
{
    if (_serviceAreaArray == nil) {
        _serviceAreaArray = [NSMutableArray array];
    }
    return _serviceAreaArray;
}
-(NSMutableArray *)serviceTypeArray
{
    if (_serviceTypeArray == nil) {
        _serviceTypeArray = [NSMutableArray array];
    }
    return _serviceTypeArray;
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
    
    // 获取商户业务范围（行业类型）二级列表接口
    NSString *serviceTypeUrl = [SLHttpUrl stringByAppendingString:@"/merchant/listMerchantBusinessScope"];
    
    [SLHttpTool postWithUrlstr:serviceTypeUrl parameters:nil success:^(id responseObject) {
        
        NSArray *dictArray = [responseObject[@"info"] lastObject];
        
        NSMutableArray *serviceTypeArray = [NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            SLChildrenScope *childrenScope = [SLChildrenScope objectWithKeyValues:dict];
            
            [serviceTypeArray addObject:childrenScope];
        }
        
        [self.serviceTypeArray addObjectsFromArray:serviceTypeArray];
        
    } failure:^(NSError *error) {
        
    }];
    
    // 获取商户服务区域数据
    NSString *url = [SLHttpUrl stringByAppendingString:@"/merchant/listMerchantAreaInfo"];
    
    [SLHttpTool postWithUrlstr:url parameters:nil success:^(id responseObject) {
        
        NSArray *dictArray = [responseObject[@"info"] lastObject];
        
        NSMutableArray *serviceAreaArray = [NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            SLOutletsServiceArea *serviceArea = [SLOutletsServiceArea objectWithKeyValues:dict];
            
            [serviceAreaArray addObject:serviceArea];
        }
        
        [self.serviceAreaArray addObjectsFromArray:serviceAreaArray];
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 加载网络数据
    [self setupInternetData];
    
    // 开始定位
//    [self.locMgr startUpdatingLocation];
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
    SLMerchantParameters *parameters = [SLMerchantParameters parameters];
    
    parameters.pageSize = @20;
    parameters.curPage = @1;
    parameters.search = @"";
    parameters.latitude = [NSNumber numberWithDouble:self.location.coordinate.latitude];
    parameters.longitude = [NSNumber numberWithDouble:self.location.coordinate.longitude];
    parameters.areaId = @1;
    parameters.scopeId = @1;
    
    [SLMerchantTool merchantWithParameters:parameters success:^(NSArray *merchantArray) {
        
    } failure:^(NSError *error) {
        
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

@end
