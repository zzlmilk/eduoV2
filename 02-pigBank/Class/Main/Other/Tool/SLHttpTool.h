//
//  SLHttpTool.h
//  02-pigBank
//
//  Created by 陆承东 on 14-10-10.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLHttpTool : NSObject
/**
 * 发送一个POST请求
 * 
 * url        请求路径
 * parameters 请求参数
 * success    请求成功后的回调
 * failure    请求失败后的回调
 */
+ (void)postWithUrlstr:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

/**
 * 发送一个POST请求,上传文件数据
 *
 * url        请求路径
 * parameters 请求参数
 * success    请求成功后的回调
 * failure    请求失败后的回调
 */
+ (void)postWithUrlstr:(NSString *)url parameters:(NSDictionary *)parameters formDataArray:(NSArray *)formDataArray success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

/**
 * 发送一个GET请求
 *
 * url        请求路径
 * parameters 请求参数
 * success    请求成功后的回调
 * failure    请求失败后的回调
 */
+ (void)getWithUrlstr:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

@end

/**
 *  用来封装文件数据的模型
 */
@interface SLFormData : NSObject
/**
 *  文件数据
 */
@property (nonatomic, strong) NSData *data;

/**
 *  参数名
 */
@property (nonatomic, copy) NSString *name;

/**
 *  文件名
 */
@property (nonatomic, copy) NSString *filename;

/**
 *  文件类型
 */
@property (nonatomic, copy) NSString *mimeType;
@end