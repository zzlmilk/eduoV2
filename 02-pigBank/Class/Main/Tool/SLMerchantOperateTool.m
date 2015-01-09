//
//  SLMerchantOperateTool.m
//  02-pigBank
//
//  Created by 陆承东 on 15/1/9.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import "SLMerchantOperateTool.h"

#import "SLResult.h"

#import "SLHttpTool.h"

#import "MJExtension.h"

@implementation SLMerchantOperateTool

+ (void)userOperateWithParameters:(SLUserOperateParameters *)parameters success:(void (^)(NSArray *vipStatusFrameArray))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [SLHttpUrl stringByAppendingString:@"/merchant/recordUserOperateLog"];
    
    [SLHttpTool postWithUrlstr:url parameters:parameters.keyValues success:^(id responseObject) {
        
        SLResult *result = [SLResult objectWithKeyValues:responseObject];
        
        SLLog(@"%@", result.msg);
        
        // 传递了block
        if (success) {
            success(nil);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
