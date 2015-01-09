//
//  SLUserOperateTool.m
//  02-pigBank
//
//  Created by 陆承东 on 14-10-16.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLUserOperateTool.h"

#import "SLHttpTool.h"

#import "MJExtension.h"

@implementation SLUserOperateTool

+ (void)userOperateWithParameters:(SLUserOperateParameters *)parameters success:(void (^)(NSArray *vipStatusFrameArray))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [SLHttpUrl stringByAppendingString:@"/material/recordUserOperateLog"];
    
    [SLHttpTool postWithUrlstr:url parameters:parameters.keyValues success:^(id responseObject) {
        
        NSString *code = responseObject[@"code"];
        NSString *msg = responseObject[@"msg"];
        
        // 取出状态字典数组
//        NSArray *dictArray = [responseObject[@"info"] lastObject];
//        NSMutableArray *vipStatusFrameArray = [NSMutableArray array];
//        for (NSDictionary *dict in dictArray) {
//            
//            SLVipStatus *vipStatus = [SLVipStatus objectWithKeyValues:dict];
//            SLVipStatusFrame *vipStatusFrame = [[SLVipStatusFrame alloc] init];
//            vipStatusFrame.vipStatus = vipStatus;
//            [vipStatusFrameArray addObject:vipStatusFrame];
//            
//        }
        
        
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
