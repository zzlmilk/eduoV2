//
//  SLCollectedMerchantTool.h
//  02-pigBank
//
//  Created by 陆承东 on 14/12/23.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SLCollectedMerchantParameters.h"

@interface SLCollectedMerchantTool : NSObject

/**
 *  加载网点的数据
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)CollcetedMerchantWithParameters:(SLCollectedMerchantParameters *)parameters success:(void (^)(NSArray *collectedMerchantArray))success failure:(void (^)(NSError *error))failure;

@end
