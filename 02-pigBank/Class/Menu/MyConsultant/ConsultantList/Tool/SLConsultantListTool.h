//
//  SLConsultantListTool.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/12.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SLConsultantListParameters.h"
#import "SLResult.h"

@interface SLConsultantListTool : NSObject

/**
 *  加载我的理财顾问的数据
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)consultantListWithParameters:(SLConsultantListParameters *)parameters success:(void (^)(NSArray *consultantList))success failure:(void (^)(NSError *error))failure;

@end
