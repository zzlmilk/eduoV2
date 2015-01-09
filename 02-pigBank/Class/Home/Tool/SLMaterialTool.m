//
//  SLMaterialTool.m
//  02-pigBank
//
//  Created by 陆承东 on 14/10/27.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLMaterialTool.h"

#import "SLHttpTool.h"

#import "MJExtension.h"

@implementation SLMaterialTool

+ (void)materialWithParameters:(SLMaterialParameters *)parameters success:(void (^)(NSArray *materialObject))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [SLHttpUrl stringByAppendingString:@"/material/catchMaterialInfoById"];
    
    [SLHttpTool postWithUrlstr:url parameters:parameters.keyValues success:^(id responseObject) {
        
        NSDictionary *dict = [responseObject[@"info"] lastObject];
        SLVipStatusFirstMaterialInfo *firstMaterialInfo = [SLVipStatusFirstMaterialInfo objectWithKeyValues:dict];
        SLVipStatus *vipStatus = [[SLVipStatus alloc] init];
        vipStatus.firstMaterialInfo = firstMaterialInfo;
        NSArray *materialObject = [NSArray arrayWithObject:vipStatus];
        
        if (success) {
            success(materialObject);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
