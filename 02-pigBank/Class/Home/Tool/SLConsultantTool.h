//
//  SLConsultantTool.h
//  02-pigBank
//
//  Created by 陆承东 on 14-9-29.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SLConsultant.h"

#import "SLConsultantParameters.h"

@interface SLConsultantTool : NSObject

/**
 *  加载理财顾问的数据
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)consultantWithParameters:(SLBaseParameters *)parameters success:(void (^)(SLConsultant *consultant))success failure:(void (^)(NSError *error))failure;

+ (void)saveConsultantAccount:(SLConsultant *)consultant;
+ (SLConsultant *)getConsultantAccount;

@end
