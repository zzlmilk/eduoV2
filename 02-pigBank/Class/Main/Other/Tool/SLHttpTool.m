//
//  SLHttpTool.m
//  02-pigBank
//
//  Created by 陆承东 on 14-10-10.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLHttpTool.h"

#import "AFNetworking.h"

@interface SLHttpTool()

@property (nonatomic, strong) AFHTTPRequestOperationManager *mgr;

@end

@implementation SLHttpTool

- (AFHTTPRequestOperationManager *)mgr
{
    if (_mgr == nil) {
        _mgr = [AFHTTPRequestOperationManager manager];
    }
    return _mgr;
}

+ (void)postWithUrlstr:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 1.创建请求管理者对象
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.发送请求
    [mgr POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)postWithUrlstr:(NSString *)url parameters:(NSDictionary *)parameters formDataArray:(NSArray *)formDataArray success:(void (^)(id responceObject))success failure:(void (^)(NSError *error))failure
{
    // 1.创建请求管理者对象
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"text/json",@"text/javascript",@"binary/octet-stream", nil];
    
    // 2.发送请求
    [mgr POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> totalFormData) {
        for (SLFormData *formData in formDataArray) {
            [totalFormData appendPartWithFileData:formData.data name:formData.name fileName:formData.filename mimeType:formData.mimeType];
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            SLLog(@"%@", responseObject);
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            SLLog(@"%@", error);
            failure(error);
        }
    }];
}

+ (void)getWithUrlstr:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 1.创建请求管理者对象
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.发送请求
    [mgr GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end

/**
 *  用来封装文件数据的模型
 */
@implementation SLFormData

@end