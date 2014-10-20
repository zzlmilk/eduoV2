//
//  SLOutletsTool.h
//  02-pigBank
//
//  Created by 陆承东 on 14-10-16.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SLOutletsParameters.h"

@interface SLOutletsTool : NSObject

/**
 *  加载网点的数据
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)outletsListWithParameters:(SLOutletsParameters *)parameters success:(void (^)(NSArray *outletsArray))success failure:(void (^)(NSError *error))failure;

@end
