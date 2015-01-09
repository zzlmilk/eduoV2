//
//  SLMerchantOperateTool.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/9.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SLUserOperateParameters.h"

@interface SLMerchantOperateTool : NSObject

/**
 *  加载用户操作的数据
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)userOperateWithParameters:(SLUserOperateParameters *)parameters success:(void (^)(NSArray *vipStatusFrameArray))success failure:(void (^)(NSError *error))failure;

@end
