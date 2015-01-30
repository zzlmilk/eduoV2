//
//  SLClientTool.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/21.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SLClientParameters.h"
#import "SLClientDetailParameters.h"
#import "SLModifyClientRemarkParameters.h"
#import "SLClientTagListParameters.h"
#import "SLAddNewTagParameters.h"
#import "SLSetTagParameters.h"
#import "SLDeleteTagParameters.h"
#import "SLClientInfo.h"
#import "SLClientDetail.h"
#import "SLResult.h"

@interface SLClientTool : NSObject

+ (void)clientInfoWithParameters:(SLClientParameters *)parameters success:(void (^)(SLClientInfo *clientInfo))success failure:(void (^)(NSError *error))failure;

+ (void)clientDetailWithParameters:(SLClientDetailParameters *)parameters success:(void (^)(SLClientDetail *clientDetail))success failure:(void (^)(NSError *error))failure;

+ (void)clientModifyClientRemarkWithParameters:(SLModifyClientRemarkParameters *)parameters success:(void (^)(SLResult *result))success failure:(void (^)(NSError *error))failure;

+ (void)clientTagListWithParameters:(SLClientTagListParameters *)parameters success:(void (^)(NSArray *userTagArray))success failure:(void (^)(NSError *error))failure;

+ (void)clientAddNewTagWithParameters:(SLAddNewTagParameters *)parameters success:(void (^)(SLResult *result))success failure:(void (^)(NSError *error))failure;

+ (void)clientSetTagWithParameters:(SLSetTagParameters *)parameters success:(void (^)(SLResult *result))success failure:(void (^)(NSError *error))failure;

+ (void)clientDeleteTagWithParameters:(SLDeleteTagParameters *)parameters success:(void (^)(SLResult *result))success failure:(void (^)(NSError *error))failure;

@end
