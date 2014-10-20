//
//  SLFinancialProductFrameCacheTool.h
//  02-pigBank
//
//  Created by 陆承东 on 14-10-15.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SLFinancialStatusFrame.h"
#import "SLFinancialProductParameters.h"

@interface SLFinancialProductFrameCacheTool : NSObject

/**
 *  缓存一条数据
 *
 *  @param status 需要缓存的数据
 */
+ (void)addFinancialStatusFrame:(SLFinancialStatusFrame *)financialStatusFrame;

/**
 *  缓存N条数据
 *
 *  @param statusArray 需要缓存的数据
 */
+ (void)addFinancialProductFrames:(NSArray *)financialProductFramesArray;

/**
 *  根据请求参数获得数据
 *
 *  @param param 请求参数
 *
 *  @return 模型数组
 */
+ (NSArray *)statuesWithParameters:(SLFinancialProductParameters *)parameters;

/**
 *  清除表中所有数据
 */
+ (void)clearStatuses;

@end
