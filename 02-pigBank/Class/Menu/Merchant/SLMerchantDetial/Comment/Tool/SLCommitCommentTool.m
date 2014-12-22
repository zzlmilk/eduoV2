//
//  SLCommitCommentTool.m
//  02-pigBank
//
//  Created by 陆承东 on 14/12/12.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLCommitCommentTool.h"

#import "SLHttpTool.h"

#import "MJExtension.h"

@implementation SLCommitCommentTool

+ (void)commitCommentWithParameters:(SLCommitCommentParameters *)parameters success:(void (^)(NSString *code))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [SLHttpUrl stringByAppendingString:@"/merchant/commentAndGradeForMerchant"];
    
    [SLHttpTool postWithUrlstr:url parameters:parameters.keyValues success:^(id responseObject) {
        NSString *code = responseObject[@"code"];
        
        // 传递了block
        if (success) {
            success(code);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
