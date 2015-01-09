//
//  SLMeterialDetialTool.m
//  02-pigBank
//
//  Created by 陆承东 on 15/1/9.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import "SLMeterialDetialTool.h"

#import "SLHttpTool.h"

#import "MJExtension.h"

@implementation SLMeterialDetialTool

+ (void)meterialDetialWithParameters:(SLMeterialDetialParameters *)parameters success:(void (^)(SLResult *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [SLHttpUrl stringByAppendingString:@"/material/catchMaterialInfoById"];
    
    [SLHttpTool postWithUrlstr:url parameters:parameters.keyValues success:^(id responseObject) {
        
        
        SLResult *result = [SLResult objectWithKeyValues:responseObject];
        
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
