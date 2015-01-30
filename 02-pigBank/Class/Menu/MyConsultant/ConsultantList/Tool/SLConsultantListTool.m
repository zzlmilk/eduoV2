//
//  SLConsultantListTool.m
//  02-pigBank
//
//  Created by 陆承东 on 15/1/12.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import "SLConsultantListTool.h"

#import "SLConsultant.h"
#import "SLResult.h"

#import "SLHttpTool.h"

#import "MJExtension.h"
#import "MBProgressHUD+MJ.h"

@implementation SLConsultantListTool

+ (void)consultantListWithParameters:(SLConsultantListParameters *)parameters success:(void (^)(NSArray *consultantList))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [SLHttpUrl stringByAppendingString:@"/user/listConsultant"];

    [SLHttpTool postWithUrlstr:url parameters:parameters.keyValues success:^(id responseObject) {
        
        SLLog(@"%@", responseObject);

        SLResult *result = [SLResult objectWithKeyValues:responseObject];
        if ([result.code isEqualToString:@"0000"]) {
            if (result.info.count > 0) {
                NSArray *dictArray = [result.info lastObject];
                NSArray *consultantList;
                for (int i = 0; i < dictArray.count; i++) {
                    consultantList = [SLConsultant objectArrayWithKeyValuesArray:dictArray];
                    
                    // 传递了block
                    if (success) {
                        success(consultantList);
                    }
                }
            } else {
                [MBProgressHUD showError:@"没有相关数据"];
            }
        } else {
            [MBProgressHUD showError:@"没有相关数据"];
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
