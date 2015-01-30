//
//  SLSubscribeTool.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/23.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SLResult.h"
#import "SLSubscribeDetail.h"
#import "SLSubscribeListParameters.h"
#import "SLSubscribeDetailParameters.h"
#import "SLSubscribeClassParameters.h"

@interface SLSubscribeTool : NSObject

+ (void)subscribeListWithParameters:(SLSubscribeListParameters *)parameters success:(void (^)(SLResult *result))success failure:(void (^)(NSError *error))failure;

+ (void)subscribeDetailWithParameters:(SLSubscribeDetailParameters *)parameters success:(void (^)(SLSubscribeDetail *subscribeDetail))success failure:(void (^)(NSError *error))failure;

+ (void)subscribeClassWithParameters:(SLBaseParameters *)parameters success:(void (^)(NSArray *subscribeClassArray))success failure:(void (^)(NSError *error))failure;

+ (void)subscribeSelectClassWithParameters:(SLSubscribeClassParameters *)parameters success:(void (^)(SLResult *result))success failure:(void (^)(NSError *error))failure;

@end
