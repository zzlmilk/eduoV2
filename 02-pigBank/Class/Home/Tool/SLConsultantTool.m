//
//  SLConsultantTool.m
//  02-pigBank
//
//  Created by 陆承东 on 14-9-29.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLConsultantTool.h"

#import "SLResult.h"

#import "SLHttpTool.h"
#import "MJExtension.h"
#import "MBProgressHUD+MJ.h"

#define SLConsultantAccountFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"consultantAccount.data"]

@implementation SLConsultantTool

+ (void)consultantWithParameters:(SLBaseParameters *)parameters success:(void (^)(SLConsultant *consultant))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [SLHttpUrl stringByAppendingString:@"/user/catchMyConsultant"];
    
    [SLHttpTool postWithUrlstr:url parameters:parameters.keyValues success:^(id responseObject) {
        
        SLLog(@"%@", responseObject);
        
        SLResult *result = [SLResult objectWithKeyValues:responseObject];
        
        if ([result.code isEqualToString:@"0000"]) {
            if (result.info.count > 0) {
                NSDictionary *consultantDict = [result.info lastObject];
                
                SLConsultant *consultant = [SLConsultant objectWithKeyValues:consultantDict];
                
                // 归档
                [SLConsultantTool saveConsultantAccount:consultant];
                
                if (success) {
                    success(consultant);
                }
            } else {
                [MBProgressHUD showError:@"未能成功获取理财顾问信息..."];
            }
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
