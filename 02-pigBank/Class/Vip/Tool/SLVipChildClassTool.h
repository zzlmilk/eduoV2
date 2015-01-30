//
//  SLVipChildClassTool.h
//  02-pigBank
//
//  Created by 陆承东 on 14-10-14.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SLVipChildClassParameters.h"
#import "SLResult.h"

@interface SLVipChildClassTool : NSObject

/**
 *  加载Vip子页的数据
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)vipChildStatusesWithParameters:(SLVipChildClassParameters *)parameters success:(void (^)(NSArray *vipChildStatusFrameArray))success failure:(void (^)(NSError *error))failure;

@end
