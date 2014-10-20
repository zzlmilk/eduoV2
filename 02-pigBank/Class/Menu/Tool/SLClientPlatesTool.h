//
//  SLClientPlatesTool.h
//  02-pigBank
//
//  Created by 陆承东 on 14-9-26.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SLClientPlate.h"

#import "SLBaseParameters.h"

@interface SLClientPlatesTool : NSObject

/**
 *  加载理财顾问的数据
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)clientPlateWithParameters:(SLBaseParameters *)parameters success:(void (^)(NSArray *clientPlateArray))success failure:(void (^)(NSError *error))failure;

/**
 *  归档数据
 */
+ (void)saveClientPlates:(NSArray *)clientPlates;

/**
 *  读取数据,数组的第一个对象是"VIP特权",第二个对象是"尊享理财",第三个对象是"网点"
 */
+ (NSArray *)getClientPlates;

/**
 *  获取理财信息板块
 */
+ (SLClientPlate *)getFinancialProductClientPlate;

/**
 *  获取网点板块
 */
+ (SLClientPlate *)getOutletClientPlate;

@end
