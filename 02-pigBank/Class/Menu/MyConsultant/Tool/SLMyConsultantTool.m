//
//  SLMyConsultantTool.m
//  02-pigBank
//
//  Created by 陆承东 on 15/1/10.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import "SLMyConsultantTool.h"

#import "SLResult.h"

#import "SLHttpTool.h"

#import "MJExtension.h"

@implementation SLMyConsultantTool

+ (void)myConsultantWithParameters:(SLMyConsultantParameters *)parameters success:(void (^)(SLConsultant *consultant))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [SLHttpUrl stringByAppendingString:@"/user/catchMyConsultant"];
    
    [SLHttpTool postWithUrlstr:url parameters:parameters.keyValues success:^(id responseObject) {
        
        SLResult *result = [SLResult objectWithKeyValues:responseObject];
        SLConsultant *consultant = [SLConsultant objectWithKeyValues:[result.info lastObject]];
        
        // 传递了block
        if (success) {
            success(consultant);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
//    NSString *url1 = [SLHttpUrl stringByAppendingString:@"/user/listConsultant"];
//    
//    SLConsultantListParameters *newParameters = [SLConsultantListParameters parameters];
//    newParameters.pageSize = @20;
//    newParameters.curPage = @1;
//    
//    [SLHttpTool postWithUrlstr:url1 parameters:newParameters.keyValues success:^(id responseObject) {
//        
//        SLResult *result = [SLResult objectWithKeyValues:responseObject];
//        NSArray *dictArray = [result.info lastObject];
//        for (int i = 0; i < dictArray.count; i++) {
//            NSArray *consultantList = [SLConsultant objectArrayWithKeyValuesArray:dictArray];
//        }
//        
//        // 传递了block
//        if (success) {
//            success(nil);
//        }
//    } failure:^(NSError *error) {
//        if (failure) {
//            failure(error);
//        }
//    }];
}

@end
