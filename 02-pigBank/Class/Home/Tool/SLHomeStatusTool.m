//
//  SLHomeStatusTool.m
//  02-pigBank
//
//  Created by 陆承东 on 14-9-19.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLHomeStatusTool.h"

#import "MJExtension.h"
#import "SLHttpTool.h"
#import "SLAccountTool.h"
#import "SLHomeStatusCacheTool.h"


@implementation SLHomeStatusTool

+ (void)homeStatusesWithParameters:(SLHomeStatusParameters *)parameters success:(void (^)(NSArray *homeStatusArray))success failure:(void (^)(NSError *error))failure
{
    // 1.先从缓存里面加载
    NSArray *statusArray = [SLHomeStatusCacheTool statuesWithParameters:parameters];
    
//    if (statusArray.count) { // 有缓存
        // 传递了block
        if (success) {
            success(statusArray);
        }
//    } else {
    
        [SLHttpTool postWithUrlstr:@"http://117.79.93.100:8013/data2.0/ds/material/listIndexMaterialInfo" parameters:parameters.keyValues success:^(id responseObject) {
        
            NSArray *dictArray = [responseObject[@"info"] lastObject];

            NSArray *statusArray = [SLHomeStatus objectArrayWithKeyValuesArray:dictArray];
            
            // 如果是刷新操作,即curPage = 1时,清表
            if ([parameters.curPage intValue] == 1) {
                [SLHomeStatusCacheTool clearStatuses];
            }
            
            // 缓存
            [SLHomeStatusCacheTool addStatuses:statusArray];
        
            // 传递了block
            if (success) {
                success(statusArray);
            }
        } failure:^(NSError *error) {
            if (failure) {
                failure(error);
            }
        }];
//    }
}
@end
