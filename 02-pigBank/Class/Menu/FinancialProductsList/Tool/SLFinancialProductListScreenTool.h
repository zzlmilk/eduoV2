//
//  SLFinancialProductListScreenTool.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/19.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SLFinancialProductListScreenParameters.h"

@interface SLFinancialProductListScreenTool : NSObject

/**
 *  加载Vip子页的数据
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)financialProductListScreenItemWithParameters:(SLFinancialProductListScreenParameters *)parameters success:(void (^)(NSArray *financialProductClassArray))success failure:(void (^)(NSError *error))failure;

@end
