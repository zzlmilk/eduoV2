//
//  SLLogoutTool.m
//  02-pigBank
//
//  Created by 陆承东 on 15/1/27.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import "SLLogoutTool.h"

#import "SLHttpTool.h"
#import "MJExtension.h"

@implementation SLLogoutTool

+ (void)logoutWithWithParameters:(SLLogoutParameters *)parameters success:(void (^)(SLResult *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [SLHttpUrl stringByAppendingString:@"/user/logout"];
    
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
