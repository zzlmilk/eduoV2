//
//  SLManagerTool.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/28.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SLManageParameters.h"
#import "SLResult.h"

@interface SLManagerTool : NSObject

+ (void)managerCustomerListForMaterialWithParameters:(SLManageParameters *)parameters success:(void (^)(SLResult *result))success failure:(void (^)(NSError *error))failure;

@end
