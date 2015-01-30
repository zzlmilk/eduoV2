//
//  SLFinancialProductTool.h
//  02-pigBank
//
//  Created by 陆承东 on 14-10-15.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SLFinancialProductParameters.h"
#import "SLResult.h"

@interface SLFinancialProductTool : NSObject

/**
 *  加载尊享理财页的数据
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)financialProductListWithParameters:(SLFinancialProductParameters *)parameters success:(void (^)(NSArray *financialProductStatusFrameArray))success failure:(void (^)(NSError *error))failure;

@end
