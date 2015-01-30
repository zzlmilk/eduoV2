//
//  SLMyCommentTool.m
//  02-pigBank
//
//  Created by 陆承东 on 14/12/12.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLMyCommentTool.h"

#import "SLMyCommentStatus.h"
#import "SLMyCommentStatusFrame.h"

#import "SLHttpTool.h"

#import "MJExtension.h"

@implementation SLMyCommentTool

+ (void)myCommentsWithParameters:(SLMyCommentParameters *)parameters success:(void (^)(SLResult *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [SLHttpUrl stringByAppendingString:@"/merchant/listMyMerchantComment"];
    
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
