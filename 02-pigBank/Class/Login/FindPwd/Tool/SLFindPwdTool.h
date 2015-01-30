//
//  SLFindPwdTool.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/20.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SLFindPwdParameters.h"
#import "SLResult.h"

@interface SLFindPwdTool : NSObject

/**
 *  找回密码的网络请求
 */
+ (void)findPwdWithParameters:(SLFindPwdParameters *)parameters success:(void (^)(SLResult *result))success failure:(void (^)(NSError *error))failure;

@end
