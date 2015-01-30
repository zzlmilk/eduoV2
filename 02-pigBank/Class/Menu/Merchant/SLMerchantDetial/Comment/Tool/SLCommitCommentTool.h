//
//  SLCommitCommentTool.h
//  02-pigBank
//
//  Created by 陆承东 on 14/12/12.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SLCommitCommentParameters.h"
#import "SLResult.h"

@interface SLCommitCommentTool : NSObject

/**
 *  加载商户详细的数据
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)commitCommentWithParameters:(SLCommitCommentParameters *)parameters success:(void (^)(SLResult *result))success failure:(void (^)(NSError *error))failure;

@end
