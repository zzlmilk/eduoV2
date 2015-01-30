//
//  SLLoginTool.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/20.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SLResult.h"

#import "SLMessageParameters.h"

@interface SLLoginTool : NSObject

#pragma mark ----- 获取注册类型
+ (void)catchRegistTypeWithParameters:(SLMessageParameters *)parameters success:(void (^)(SLResult *result))success failure:(void (^)(NSError *error))failure;

@end
