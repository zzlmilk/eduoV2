//
//  SLVipStatusCacheTool.h
//  02-pigBank
//
//  Created by 陆承东 on 14-10-15.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SLVipStatusFrame.h"
#import "SLVipParameters.h"

@interface SLVipStatusCacheTool : NSObject

/**
 *  缓存一条数据
 *
 *  @param status 需要缓存的数据
 */
+ (void)addStatus:(SLVipStatusFrame *)statusFrame;

/**
 *  缓存N条数据
 *
 *  @param statusArray 需要缓存的数据
 */
+ (void)addStatuses:(NSArray *)statusFrameArray;

/**
 *  根据请求参数获得数据
 *
 *  @param param 请求参数
 *
 *  @return 模型数组
 */
+ (NSArray *)statuesWithParameters:(SLVipParameters *)parameters;

/**
 *  清除表中所有数据
 */
+ (void)clearStatuses;

@end
