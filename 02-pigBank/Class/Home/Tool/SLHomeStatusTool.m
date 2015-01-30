//
//  SLHomeStatusTool.m
//  02-pigBank
//
//  Created by 陆承东 on 14-9-19.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLHomeStatusTool.h"

#import "SLFinanceProduct.h"
#import "SLFinanceProductFrame.h"
#import "SLResult.h"

#import "SLLoginViewController.h"

#import "SLHttpTool.h"
#import "SLHomeStatusCacheTool.h"
#import "SLFinanceProductCacheTool.h"

#import "MJExtension.h"

@interface SLHomeStatusTool ()

@property (nonatomic, strong) NSMutableArray *financeProductFrames;

@end

@implementation SLHomeStatusTool



- (NSMutableArray *)financeProductFrames
{
    if (_financeProductFrames == nil) {
        _financeProductFrames = [NSMutableArray array];
    }
    return _financeProductFrames;
}

+ (void)homeStatusesWithParameters:(SLHomeStatusParameters *)parameters success:(void (^)(NSArray *homeStatusArray))success failure:(void (^)(NSError *error))failure
{
    // 1.先从缓存里面加载
//    NSArray *statusArray = [SLHomeStatusCacheTool statuesWithParameters:parameters];
//
//    if (statusArray.count > 0) {
//        // 传递了block
//        if (success) {
//            success(statusArray);
//        }
//    }
    
    NSString *url = [SLHttpUrl stringByAppendingString:@"/material/listIndexMaterialInfo"];
    
    [SLHttpTool postWithUrlstr:url parameters:parameters.keyValues success:^(id responseObject) {
        
        SLResult *result = [SLResult objectWithKeyValues:responseObject];
        
        NSArray *dictArray = [result.info lastObject];
            
        NSArray *statusArray = [SLHomeStatus objectArrayWithKeyValuesArray:dictArray];
        
        for (SLHomeStatus *homeStatus in statusArray) {
            
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:[homeStatus.verifyTime longLongValue]/1000];
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"dd"];
            NSString *dateStr = [dateFormat stringFromDate:date];
            homeStatus.verifyTimeData = dateStr;
        }
        
        NSArray *financeProductArray = [SLFinanceProduct objectArrayWithKeyValuesArray:dictArray];
        NSMutableArray *financeProductFrameArray = [NSMutableArray array];
        for (SLFinanceProduct *financeProduct in financeProductArray) {
            
            SLFinanceProductFrame *financeProductFrame = [[SLFinanceProductFrame alloc] init];
            
            financeProductFrame.financeProduct = financeProduct;
            [financeProductFrameArray addObject:financeProductFrame];
        }
        
        // 如果是刷新操作,即curPage = 1时,清表
        if ([parameters.curPage intValue] == 1) {
            [SLHomeStatusCacheTool clearStatuses];
            [SLFinanceProductCacheTool clearTable];
        }
        
        // 缓存
        [SLHomeStatusCacheTool addStatuses:statusArray];
        [SLFinanceProductCacheTool addFinanceProductFrames:financeProductFrameArray];
        
        // 传递了block
        if (success) {
            success(statusArray);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
