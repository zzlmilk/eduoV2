//
//  SLLogoutTool.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/27.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SLLogoutParameters.h"
#import "SLResult.h"

@interface SLLogoutTool : NSObject

+ (void)logoutWithWithParameters:(SLLogoutParameters *)parameters success:(void (^)(SLResult *result))success failure:(void (^)(NSError *error))failure;

@end
