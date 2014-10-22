//
//  SLMerchantTool.m
//  02-pigBank
//
//  Created by 陆承东 on 14-10-17.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLMerchantTool.h"

#import "SLVipMerchantDetail.h"
#import "SLVipMerchantUserInfo.h"

#import "SLHttpTool.h"

#import "MJExtension.h"

@implementation SLMerchantTool

+ (void)merchantWithParameters:(SLMerchantParameters *)parameters success:(void (^)(NSArray *merchantArray))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [SLHttpUrl stringByAppendingString:@"/merchant/listMerchantInfo"];
    
    [SLHttpTool postWithUrlstr:url parameters:parameters.keyValues success:^(id responseObject) {
        
        NSArray *dictArray = [responseObject[@"info"] lastObject];
        
        NSArray *merchantArray = [SLVipMerchantDetail objectArrayWithKeyValuesArray:dictArray];
        
        
        // 传递了block
        if (success) {
            success(merchantArray);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
