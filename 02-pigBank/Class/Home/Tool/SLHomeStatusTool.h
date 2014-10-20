//
//  SLHomeStatusTool.h
//  02-pigBank
//
//  Created by 陆承东 on 14-9-19.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SLHomeStatusParameters.h"
#import "SLHomeStatusResult.h"

@interface SLHomeStatusTool : NSObject 

/**
 *  加载首页的数据
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)homeStatusesWithParameters:(SLHomeStatusParameters *)parameters success:(void (^)(NSArray *homeStatusArray))success failure:(void (^)(NSError *error))failure;

@end