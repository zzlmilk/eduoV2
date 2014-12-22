//
//  SLMyCommentTool.h
//  02-pigBank
//
//  Created by 陆承东 on 14/12/12.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SLMyCommentParameters.h"

@interface SLMyCommentTool : NSObject

/**
 *  加载网点的数据
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)myCommentsWithParameters:(SLMyCommentParameters *)parameters success:(void (^)(NSArray *myCommentStatusArray))success failure:(void (^)(NSError *error))failure;

@end
