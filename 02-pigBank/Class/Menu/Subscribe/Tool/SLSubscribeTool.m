//
//  SLSubscribeTool.m
//  02-pigBank
//
//  Created by 陆承东 on 15/1/23.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import "SLSubscribeTool.h"

#import "SLSubscribeList.h"
#import "SLSubscribeClass.h"

#import "SLHttpTool.h"
#import "MJExtension.h"

@implementation SLSubscribeTool

+ (void)subscribeListWithParameters:(SLSubscribeListParameters *)parameters success:(void (^)(SLResult *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [SLHttpUrl stringByAppendingString:@"/subscribe/subscribeList"];
    
    [SLHttpTool postWithUrlstr:url parameters:parameters.keyValues success:^(id responseObject) {
        
        SLLog(@"%@", responseObject);
        
        SLResult *result = [SLResult objectWithKeyValues:responseObject];
        
        if (success) {
            success(result);
        }
        
//        if ([result.code isEqualToString:@"0000"]) {
//            if (result.info.count > 0) {
//                NSArray *dictArray = [result.info lastObject];
//                NSArray *subscribeStatusList = [SLSubscribeList objectArrayWithKeyValuesArray:dictArray];
//                
//                // 传递了block
//                if (success) {
//                    success(subscribeStatusList);
//                }
//            } else {
//                if (success) {
//                    success(nil);
//                }
//            }
//        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)subscribeDetailWithParameters:(SLSubscribeDetailParameters *)parameters success:(void (^)(SLSubscribeDetail *subscribeDetail))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [SLHttpUrl stringByAppendingString:@"/subscribe/subscribeInfo"];
    
    [SLHttpTool postWithUrlstr:url parameters:parameters.keyValues success:^(id responseObject) {
        
        SLLog(@"%@", responseObject);
        
        SLResult *result = [SLResult objectWithKeyValues:responseObject];
        
        if ([result.code isEqualToString:@"0000"]) {
            if (result.info.count > 0) {
                NSDictionary *dict = [result.info lastObject];
                SLSubscribeDetail *subscribeDetail = [SLSubscribeDetail objectWithKeyValues:dict];
                NSDate *updateTime = [NSDate dateWithTimeIntervalSince1970: [subscribeDetail.updateTime longLongValue]/1000];
                NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                [dateFormat setDateFormat:@"yyyy/MM/dd"];
                subscribeDetail.updateTimeStr = [dateFormat stringFromDate:updateTime];
                
                // 传递了block
                if (success) {
                    success(subscribeDetail);
                }
            } else {
                if (success) {
                    success(nil);
                }
            }
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)subscribeClassWithParameters:(SLBaseParameters *)parameters success:(void (^)(NSArray *subscribeClassArray))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [SLHttpUrl stringByAppendingString:@"/subscribe/subscribeLibrary"];
    
    [SLHttpTool postWithUrlstr:url parameters:parameters.keyValues success:^(id responseObject) {
        
        SLLog(@"%@", responseObject);
        
        SLResult *result = [SLResult objectWithKeyValues:responseObject];
        
        if ([result.code isEqualToString:@"0000"]) {
            if (result.info.count > 0) {
                NSArray *dictArray = [result.info lastObject];
                
                NSArray *subscribeClassArray = [SLSubscribeClass objectArrayWithKeyValuesArray:dictArray];
                
                // 传递了block
                if (success) {
                    success(subscribeClassArray);
                }
            } else {
                if (success) {
                    success(nil);
                }
            }
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)subscribeSelectClassWithParameters:(SLSubscribeClassParameters *)parameters success:(void (^)(SLResult *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [SLHttpUrl stringByAppendingString:@"/subscribe/collectSubscribe"];
    
    [SLHttpTool postWithUrlstr:url parameters:parameters.keyValues success:^(id responseObject) {
        
        SLLog(@"%@", responseObject);
        
        SLResult *result = [SLResult objectWithKeyValues:responseObject];
        
        if ([result.code isEqualToString:@"0000"]) {
            if (result.info.count > 0) {
                
                // 传递了block
                if (success) {
                    success(result);
                }
            } else {
                if (success) {
                    success(result);
                }
            }
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
