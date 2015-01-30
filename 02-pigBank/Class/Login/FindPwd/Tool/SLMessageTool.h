//
//  SLMessageTool.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/20.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SLResult.h"

#import "SLMessageParameters.h"

@interface SLMessageTool : NSObject

/**
 *  加载首页的数据
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)messageWithParameters:(SLMessageParameters *)parameters success:(void (^)(SLResult *result))success failure:(void (^)(NSError *error))failure;

@end
