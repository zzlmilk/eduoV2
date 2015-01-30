//
//  SLCollectecMaterialTool.m
//  02-pigBank
//
//  Created by 陆承东 on 14/12/23.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLCollectecMaterialTool.h"

#import "SLHttpTool.h"

#import "MJExtension.h"

@implementation SLCollectecMaterialTool

+ (void)CollcetedMerchantWithParameters:(SLCollectedMaterialParameter *)parameters success:(void (^)(NSArray *collectedMaterialArray))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [SLHttpUrl stringByAppendingString:@"/material/listCollectMaterial"];
    
    [SLHttpTool postWithUrlstr:url parameters:parameters.keyValues success:^(id responseObject) {
        
        SLLog(@"%@plateId%@", responseObject, parameters.plateId);
        
        SLResult *result = [SLResult objectWithKeyValues:responseObject];
        
        NSArray *collectedMaterialArray = [responseObject[@"info"] lastObject];
        
        // 传递了block
        if (success) {
            success(collectedMaterialArray);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

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
