//
//  SLChangeCoordinateTool.m
//  02-pigBank
//
//  Created by 陆承东 on 15/1/30.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import "SLChangeCoordinateTool.h"

@implementation SLChangeCoordinateTool

+ (void)changeCoordinateWithParameters:(SLChangeCoordinateParameters *)parameters success:(void (^)(SLChangeCoordinateResult *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = @"http://restapi.amap.com/v3/assistant/coordinate/convert?";
    
    [SLHttpTool getWithUrlstr:url parameters:parameters.keyValues success:^(id responseObject) {
        
        SLChangeCoordinateResult *result = [SLChangeCoordinateResult objectWithKeyValues:responseObject];
        
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
