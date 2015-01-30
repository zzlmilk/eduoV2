//
//  SLClientTool.m
//  02-pigBank
//
//  Created by 陆承东 on 15/1/21.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import "SLClientTool.h"

#import "SLMaterial.h"
#import "SLUserTag.h"

#import "SLHttpTool.h"
#import "MJExtension.h"

@implementation SLClientTool

+ (void)clientInfoWithParameters:(SLClientParameters *)parameters success:(void (^)(SLClientInfo *clientInfo))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [SLHttpUrl stringByAppendingString:@"/user/catchCustomerVIPWithOperateHistory"];
    
    [SLHttpTool postWithUrlstr:url parameters:parameters.keyValues success:^(id responseObject) {
        
        SLResult *result = [SLResult objectWithKeyValues:responseObject];
        
        if (result.info.count > 0) {
            SLClientInfo *clientInfo = [SLClientInfo objectWithKeyValues:[result.info lastObject]];
            NSArray *materialUserList = [SLMaterial objectArrayWithKeyValuesArray:clientInfo.materialUserList];
            for (SLMaterial *material in materialUserList) {
                NSDate *lastReadTimeDate = [NSDate dateWithTimeIntervalSince1970: [material.lastReadTime longLongValue]/1000];
                NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                [dateFormat setDateFormat:@"yyyy/MM/dd"];
                material.lastReadTimeStr = [dateFormat stringFromDate:lastReadTimeDate];
            }
            clientInfo.materialUserList = materialUserList;
            if (success) {
                success(clientInfo);
            }
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)clientDetailWithParameters:(SLClientDetailParameters *)parameters success:(void (^)(SLClientDetail *clientDetail))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [SLHttpUrl stringByAppendingString:@"/user/catchUserInfoWithRemarkAndTags"];
    
    [SLHttpTool postWithUrlstr:url parameters:parameters.keyValues success:^(id responseObject) {
        
        SLLog(@"%@", responseObject);
        
        SLResult *result = [SLResult objectWithKeyValues:responseObject];
        
        if (result.info.count > 0) {
            SLClientDetail *clientDetail = [SLClientDetail objectWithKeyValues:[result.info lastObject]];
            if (clientDetail.userTags.count > 0) {
                NSArray *userTagArray = [SLUserTag objectArrayWithKeyValuesArray:clientDetail.userTags];
                clientDetail.userTags = userTagArray;
            }
            
            if (success) {
                success(clientDetail);
            }
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)clientModifyClientRemarkWithParameters:(SLModifyClientRemarkParameters *)parameters success:(void (^)(SLResult *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [SLHttpUrl stringByAppendingString:@"/user/changeRemark"];
    
    [SLHttpTool postWithUrlstr:url parameters:parameters.keyValues success:^(id responseObject) {
        
        SLLog(@"%@", responseObject);
        
        SLResult *result = [SLResult objectWithKeyValues:responseObject];
        
        if (success) {
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)clientTagListWithParameters:(SLClientTagListParameters *)parameters success:(void (^)(NSArray *userTagArray))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [SLHttpUrl stringByAppendingString:@"/user/listUserTag"];
    
    [SLHttpTool postWithUrlstr:url parameters:parameters.keyValues success:^(id responseObject) {
        
        SLLog(@"%@", responseObject);
        
        SLResult *result = [SLResult objectWithKeyValues:responseObject];
        
        if (result.info.count > 0) {
            NSArray *dictArray = [result.info lastObject];
            
            NSArray *userTagArray = [SLUserTag objectArrayWithKeyValuesArray:dictArray];
            
            if (success) {
                success(userTagArray);
            }
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)clientAddNewTagWithParameters:(SLAddNewTagParameters *)parameters success:(void (^)(SLResult *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [SLHttpUrl stringByAppendingString:@"/user/addUserTag"];
    
    [SLHttpTool postWithUrlstr:url parameters:parameters.keyValues success:^(id responseObject) {
        
        SLResult *result = [SLResult objectWithKeyValues:responseObject];
        
        if (success) {
                success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)clientSetTagWithParameters:(SLSetTagParameters *)parameters success:(void (^)(SLResult *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [SLHttpUrl stringByAppendingString:@"/user/removeOrSetUserTag"];
    
    [SLHttpTool postWithUrlstr:url parameters:parameters.keyValues success:^(id responseObject) {
        
        SLLog(@"%@", responseObject);
        
        SLResult *result = [SLResult objectWithKeyValues:responseObject];
        
        if (success) {
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)clientDeleteTagWithParameters:(SLDeleteTagParameters *)parameters success:(void (^)(SLResult *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [SLHttpUrl stringByAppendingString:@"/user/deleteTagByTagId"];
    
    [SLHttpTool postWithUrlstr:url parameters:parameters.keyValues success:^(id responseObject) {
        
        SLLog(@"%@", responseObject);
        
        SLResult *result = [SLResult objectWithKeyValues:responseObject];
        
        if (success) {
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
