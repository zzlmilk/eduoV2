//
//  SLFinanceProductCacheTool.h
//  02-pigBank
//
//  Created by 陆承东 on 14-10-13.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SLFinanceProductFrame.h"
#import "SLFinanceProductParameters.h"

@interface SLFinanceProductCacheTool : NSObject

/**
 *  缓存一条数据
 *
 *  @param status 需要缓存的数据
 */
+ (void)addFinanceProductFrame:(SLFinanceProductFrame *)financeProductFrame;

/**
 *  缓存N条数据
 *
 *  @param statusArray 需要缓存的数据
 */
+ (void)addFinanceProductFrames:(NSArray *)financeProductFrames;

/**
 *  根据请求参数获得数据
 *
 *  @param param 请求参数
 *
 *  @return 模型数组
 */
+ (SLFinanceProductFrame *)statuesWithParameters:(SLFinanceProductParameters *)parameters;

/**
 *  清除表中所有数据
 */
+ (void)clearTable;

@end
