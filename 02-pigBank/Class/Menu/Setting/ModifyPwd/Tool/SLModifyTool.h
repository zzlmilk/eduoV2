//
//  SLModifyTool.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/23.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SLModifyPwdParameters.h"
#import "SLChangeMobileParameters.h"
#import "SLResult.h"

@interface SLModifyTool : NSObject

+ (void)modifyPasswordWithParameters:(SLModifyPwdParameters *)parameters success:(void (^)(SLResult *result))success failure:(void (^)(NSError *error))failure;

+ (void)changeMobileWithParameters:(SLChangeMobileParameters *)parameters success:(void (^)(SLResult *result))success failure:(void (^)(NSError *error))failure;

@end
