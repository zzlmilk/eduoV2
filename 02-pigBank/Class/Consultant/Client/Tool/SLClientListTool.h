//
//  SLClientListTool.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/19.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SLClientListParameters.h"

@interface SLClientListTool : NSObject

/**
 *  加载全部客户的数据
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)clientListInAllWithParameters:(SLClientListParameters *)parameters success:(void (^)(NSArray *clientListInAllArray))success failure:(void (^)(NSError *error))failure;

/**
 *  按组加载客户的数据
 */
+ (void)clientListInGroupWithParameters:(SLClientListParameters *)parameters success:(void (^)(NSArray *clientListInGroupArray))success failure:(void (^)(NSError *error))failure;

/**
 *  按标签加载客户的数据
 */
+ (void)clientListInTagWithParameters:(SLClientListParameters *)parameters success:(void (^)(NSArray *clientListInTagArray))success failure:(void (^)(NSError *error))failure;

@end
