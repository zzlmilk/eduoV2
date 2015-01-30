//
//  SLRegisterTool.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/20.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SLRegisterBaseParameters.h"

@interface SLRegisterTool : NSObject

/**
 *  注册的网络请求
 */
+ (void)registerBaseWithParameters:(SLRegisterBaseParameters *)parameters success:(void (^)(SLResult *result))success failure:(void (^)(NSError *error))failure;

/**
 *  注册的网络请求
 */
+ (void)registerWithParameters:(SLRegisterBaseParameters *)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

@end
