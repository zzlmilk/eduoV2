//
//  SLHomeStatusSearchTool.m
//  02-pigBank
//
//  Created by 陆承东 on 15/1/14.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import "SLHomeStatusSearchTool.h"

#import "SLResult.h"

#import "SLHttpTool.h"

#import "MJExtension.h"

@interface SLHomeStatusSearchTool ()

@property (nonatomic, strong) NSMutableArray *financeProductFrames;

@end

@implementation SLHomeStatusSearchTool



- (NSMutableArray *)financeProductFrames
{
    if (_financeProductFrames == nil) {
        _financeProductFrames = [NSMutableArray array];
    }
    return _financeProductFrames;
}

+ (void)homeStatusesWithParameters:(SLHomeStatusParameters *)parameters success:(void (^)(NSArray *homeStatusArray))success failure:(void (^)(NSError *error))failure
{
    
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
