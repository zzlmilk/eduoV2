//
//  SLMeterialDetialTool.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/9.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SLResult.h"
#import "SLMeterialDetialParameters.h"

@interface SLMeterialDetialTool : NSObject

/**
 *  加载素材详情数据
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)meterialDetialWithParameters:(SLMeterialDetialParameters *)parameters success:(void (^)(SLResult *result))success failure:(void (^)(NSError *error))failure;

@end
