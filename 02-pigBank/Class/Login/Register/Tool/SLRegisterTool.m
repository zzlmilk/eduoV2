//
//  SLRegisterTool.m
//  02-pigBank
//
//  Created by 陆承东 on 15/1/20.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import "SLRegisterTool.h"

#import "SLHttpTool.h"
#import "MJExtension.h"

@implementation SLRegisterTool

+ (void)registerBaseWithParameters:(SLRegisterBaseParameters *)parameters success:(void (^)(SLResult *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [SLHttpUrl stringByAppendingString:@"/user/registCheck"];
    
    [SLHttpTool postWithUrlstr:url parameters:parameters.keyValues success:^(id responseObject) {
        
        SLLog(@"%@", responseObject);
        
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


+ (void)registerWithParameters:(SLRegisterBaseParameters *)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [SLHttpUrl stringByAppendingString:@"/user/regist"];
    
    [SLHttpTool postWithUrlstr:url parameters:parameters.keyValues success:^(id responseObject) {
        
        // 传递了block
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
