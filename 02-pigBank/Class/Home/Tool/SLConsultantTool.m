//
//  SLConsultantTool.m
//  02-pigBank
//
//  Created by 陆承东 on 14-9-29.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLConsultantTool.h"

#import "MJExtension.h"

#import "SLHttpTool.h"

#define SLConsultantAccountFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"consultantAccount.data"]

@implementation SLConsultantTool

+ (void)consultantWithParameters:(SLConsultantParameters *)parameters success:(void (^)(SLConsultant *consultant))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [SLHttpUrl stringByAppendingString:@"/user/catchConsultantInfoById"];
    
    [SLHttpTool postWithUrlstr:url parameters:parameters.keyValues success:^(id responseObject) {
        NSDictionary *consultantDict = [responseObject[@"info"] lastObject];
        
        SLConsultant *consultant = [SLConsultant objectWithKeyValues:consultantDict];
        
        // 归档
        [SLConsultantTool saveConsultantAccount:consultant];
        
        if (success) {
            success(consultant);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)saveConsultantAccount:(SLConsultant *)consultant
{
    // 存储
    [NSKeyedArchiver archiveRootObject:consultant toFile:SLConsultantAccountFile];
}

+ (SLConsultant *)getConsultantAccount
{
    // 取出账号信息
    return [NSKeyedUnarchiver unarchiveObjectWithFile:SLConsultantAccountFile];
}

@end
