//
//  SLMyCommentTool.m
//  02-pigBank
//
//  Created by 陆承东 on 14/12/12.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLMyCommentTool.h"

#import "SLVipMerchantDetail.h"
#import "SLMyCommentStatus.h"
#import "SLMyCommentStatusFrame.h"

#import "SLHttpTool.h"

#import "MJExtension.h"

@implementation SLMyCommentTool

+ (void)myCommentsWithParameters:(SLMyCommentParameters *)parameters success:(void (^)(NSArray *myCommentStatusArray))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [SLHttpUrl stringByAppendingString:@"/merchant/listMyMerchantComment"];
    
    [SLHttpTool postWithUrlstr:url parameters:parameters.keyValues success:^(id responseObject) {
        
        NSString *code = responseObject[@"code"];
        
        NSMutableArray *myCommentStatusArray = [NSMutableArray array];
        
        if ([code isEqualToString:@"0000"]) {
            // 取出状态字典数组
            NSArray *dictArray = [responseObject[@"info"] lastObject];
            for (NSDictionary *dict in dictArray) {
                
                SLMyCommentStatus *myCommentStatus = [SLMyCommentStatus objectWithKeyValues:dict];
                SLMyCommentStatusFrame *myCommentStatusFrame = [[SLMyCommentStatusFrame alloc] init];
                myCommentStatusFrame.myCommentStatus = myCommentStatus;
                [myCommentStatusArray addObject:myCommentStatusFrame];
                
            }
        }
        
        // 传递了block
        if (success) {
            success(myCommentStatusArray);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
