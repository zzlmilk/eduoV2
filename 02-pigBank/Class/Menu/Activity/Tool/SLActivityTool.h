//
//  SLActivityTool.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/20.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SLActivityListParameters.h"
#import "SLMaterialDetailParameters.h"
#import "SLActivitySignParameters.h"
#import "SLActivityDetail.h"
#import "SLResult.h"

@interface SLActivityTool : NSObject

/**
 *  加载活动素材列表的数据
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)activityListWithParameters:(SLActivityListParameters *)parameters success:(void (^)(NSArray *myActivityStatusList))success failure:(void (^)(NSError *error))failure;

+ (void)activityDetailWithParameters:(SLMaterialDetailParameters *)parameters success:(void (^)(SLActivityDetail *activityDetail))success failure:(void (^)(NSError *error))failure;

+ (void)activitySignWithParameters:(SLActivitySignParameters *)parameters success:(void (^)(SLResult *result))success failure:(void (^)(NSError *error))failure;

@end
