//
//  SLCollectMaterialTool.m
//  02-pigBank
//
//  Created by 陆承东 on 15/1/26.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import "SLCollectMaterialTool.h"

#import "SLHttpTool.h"
#import "MJExtension.h"

@implementation SLCollectMaterialTool

+ (void)collcetedMaterialWithParameters:(SLCollectedMaterialParameter *)parameters urlStr:(NSString *)urlStr success:(void (^)(SLResult *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [SLHttpUrl stringByAppendingString:urlStr];
    
    [SLHttpTool postWithUrlstr:url parameters:parameters.keyValues success:^(id responseObject) {
        
        SLLog(@"%@plateId%@", responseObject, parameters.plateId);
        
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
