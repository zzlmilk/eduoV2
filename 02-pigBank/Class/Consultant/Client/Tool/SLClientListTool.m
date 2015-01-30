//
//  SLClientListTool.m
//  02-pigBank
//
//  Created by 陆承东 on 15/1/19.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import "SLClientListTool.h"

#import "SLResult.h"
#import "SLClient.h"
#import "SLClientGroup.h"
#import "SLClientTag.h"

#import "SLHttpTool.h"

#import "MJExtension.h"

@implementation SLClientListTool

+ (void)clientListInAllWithParameters:(SLClientListParameters *)parameters success:(void (^)(NSArray *clientListInAllArray))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [SLHttpUrl stringByAppendingString:@"/user/listCustomerWithRemark"];
    
    [SLHttpTool postWithUrlstr:url parameters:parameters.keyValues success:^(id responseObject) {
        
        SLLog(@"%@", responseObject);
        
        SLResult *result = [SLResult objectWithKeyValues:responseObject];
        NSArray *dictArray = [result.info firstObject];
        NSArray *clientListInAllArray = [SLClient objectArrayWithKeyValuesArray:dictArray];
        
        // 传递了block
        if (success) {
            success(clientListInAllArray);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)clientListInGroupWithParameters:(SLClientListParameters *)parameters success:(void (^)(NSArray *clientListInGroupArray))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [SLHttpUrl stringByAppendingString:@"/user/listCustomerVIPForGroupWithRemark"];
    
    [SLHttpTool postWithUrlstr:url parameters:parameters.keyValues success:^(id responseObject) {
        
        SLLog(@"%@", responseObject);
        
        SLResult *result = [SLResult objectWithKeyValues:responseObject];
        NSArray *dictArray = [result.info firstObject];
        NSArray *clientListInGroupArray = [SLClientGroup objectArrayWithKeyValuesArray:dictArray];
        for (int i = 0; i < clientListInGroupArray.count; i++) {
            SLClientGroup *clientGroup = clientListInGroupArray[i];
            if (clientGroup.userList.count != 0) {
                NSArray *userList = [SLClient objectArrayWithKeyValuesArray:clientGroup.userList];
                clientGroup.userList = userList;
            }
        }
        
        // 传递了block
        if (success) {
            success(clientListInGroupArray);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)clientListInTagWithParameters:(SLClientListParameters *)parameters success:(void (^)(NSArray *clientListInTagArray))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [SLHttpUrl stringByAppendingString:@"/user/listCustomerVIPForTagWithRemark"];
    
    [SLHttpTool postWithUrlstr:url parameters:parameters.keyValues success:^(id responseObject) {
        
        SLResult *result = [SLResult objectWithKeyValues:responseObject];
        NSArray *dictArray = [result.info firstObject];
        NSArray *clientListInTagArray = [SLClientTag objectArrayWithKeyValuesArray:dictArray];
        for (int i = 0; i < clientListInTagArray.count; i++) {
            SLClientTag *clientTag = clientListInTagArray[i];
            if (clientTag.userList.count != 0) {
                NSArray *userList = [SLClient objectArrayWithKeyValuesArray:clientTag.userList];
                clientTag.userList = userList;
            }
        }
        
        // 传递了block
        if (success) {
            success(clientListInTagArray);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
