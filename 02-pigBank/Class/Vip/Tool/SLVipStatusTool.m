//
//  SLVipStatusTool.m
//  02-pigBank
//
//  Created by 陆承东 on 14-10-14.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLVipStatusTool.h"

#import "MJExtension.h"

#import "SLHttpTool.h"
#import "SLVipStatusCacheTool.h"

#import "SLVipStatusFrame.h"
#import "SLVipStatus.h"

@interface SLVipStatusTool()

@property (nonatomic, strong) NSMutableArray *vipStatusFrames;

@end

@implementation SLVipStatusTool

- (NSMutableArray *)vipStatusFrames
{
    if (_vipStatusFrames == nil) {
        _vipStatusFrames = [NSMutableArray array];
    }
    return _vipStatusFrames;
}

+ (void)vipStatusesWithParameters:(SLVipParameters *)parameters success:(void (^)(NSArray *vipStatusFrameArray))success failure:(void (^)(NSError *error))failure
{
    // 1.先从缓存里面加载
    NSArray *statusFrameArray = [SLVipStatusCacheTool statuesWithParameters:parameters];
    
    // 传递了block
    if (success) {
        success(statusFrameArray);
    }
    
    NSString *url = [SLHttpUrl stringByAppendingString:@"/plate/listPlateClass"];
    
    [SLHttpTool postWithUrlstr:url parameters:parameters.keyValues success:^(id responseObject) {
        
        // 取出状态字典数组
        NSArray *dictArray = [responseObject[@"info"] lastObject];
        NSMutableArray *vipStatusFrameArray = [NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            
            SLVipStatus *vipStatus = [SLVipStatus objectWithKeyValues:dict];
            SLVipStatusFrame *vipStatusFrame = [[SLVipStatusFrame alloc] init];
            vipStatusFrame.vipStatus = vipStatus;
            [vipStatusFrameArray addObject:vipStatusFrame];
            
        }
        
        [SLVipStatusCacheTool clearStatuses];
        
        [SLVipStatusCacheTool addStatuses:vipStatusFrameArray];

        
        // 传递了block
        if (success) {
            success(vipStatusFrameArray);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
