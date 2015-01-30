//
//  SLActivityTool.m
//  02-pigBank
//
//  Created by 陆承东 on 15/1/20.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import "SLActivityTool.h"

#import "SLActivityList.h"

#import "SLHttpTool.h"
#import "MJExtension.h"

@implementation SLActivityTool

+ (void)activityListWithParameters:(SLActivityListParameters *)parameters success:(void (^)(NSArray *myActivityStatusList))success failure:(void (^)(NSError *error))failure
{
    NSString *url;
    if (parameters.flag == NO) {
        url = [SLHttpUrl stringByAppendingString:@"/material/listActivityMaterialInfo"];
    } else if (parameters.flag == YES) {
        url = [SLHttpUrl stringByAppendingString:@"/material/listActivityMaterialInfoByUser"];
    }
    
    [SLHttpTool postWithUrlstr:url parameters:parameters.keyValues success:^(id responseObject) {
        
        SLLog(@"%@", responseObject);
        
        SLResult *result = [SLResult objectWithKeyValues:responseObject];
        
        if ([result.code isEqualToString:@"0000"]) {
            if (result.info.count > 0) {
                NSArray *myActivityStatusList = [SLActivityList objectArrayWithKeyValuesArray:[result.info lastObject]];
                
                for (SLActivityList *activityList in myActivityStatusList) {
                    NSDate *date = [NSDate dateWithTimeIntervalSince1970: [activityList.startTime longLongValue]/1000];
                    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                    [dateFormat setDateFormat:@"yyyy/MM/dd hh:mm"];
                    activityList.activityTime = [dateFormat stringFromDate:date];
                    
                    NSDate *now = [NSDate date];
                    NSTimeInterval nowTimeInterval = [now timeIntervalSince1970];
                    long long endTime = ([activityList.endTime longLongValue] / 1000 - nowTimeInterval) / 60 / 60 / 24;
                    if (endTime <= 0) {
                        activityList.status = @"已结束";
                    } else {
                        long long sign = ([activityList.startTime longLongValue] / 1000 - nowTimeInterval) / 60 / 60 / 24;
                        if (sign <= 0) {
                            activityList.status = @"进行中";
                        } else {
                            activityList.status = @"报名中";
                        }
                    }
                }
                
                // 传递了block
                if (success) {
                    success(myActivityStatusList);
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

+ (void)activityDetailWithParameters:(SLMaterialDetailParameters *)parameters success:(void (^)(SLActivityDetail *activityDetail))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [SLHttpUrl stringByAppendingString:@"/material/activityMaterialInfoById"];
    
    [SLHttpTool postWithUrlstr:url parameters:parameters.keyValues success:^(id responseObject) {
        
        SLLog(@"%@", responseObject);
        
        SLResult *result = [SLResult objectWithKeyValues:responseObject];
        if (result.info.count > 0) {
            SLActivityDetail *activityDetail = [SLActivityDetail objectWithKeyValues:[result.info lastObject]];
            
            NSDate *startDate = [NSDate dateWithTimeIntervalSince1970: [activityDetail.startTime longLongValue]/1000];
            NSDate *endDate = [NSDate dateWithTimeIntervalSince1970: [activityDetail.endTime longLongValue]/1000];
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"yyyy/MM/dd hh:mm"];
            activityDetail.startTimeStr = [dateFormat stringFromDate:startDate];
            activityDetail.endTimeStr = [dateFormat stringFromDate:endDate];
            
            // 传递了block
            if (success) {
                success(activityDetail);
            }
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)activitySignWithParameters:(SLActivitySignParameters *)parameters success:(void (^)(SLResult *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [SLHttpUrl stringByAppendingString:@"/material/signActivity"];
    
    [SLHttpTool postWithUrlstr:url parameters:parameters.keyValues success:^(id responseObject) {
        
        SLResult *result = [SLResult objectWithKeyValues:responseObject];
        
        // 传递了block
        if (success) {
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
