//
//  SLFinancialProductListScreenTool.m
//  02-pigBank
//
//  Created by 陆承东 on 15/1/19.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import "SLFinancialProductListScreenTool.h"

#import "SLResult.h"
#import "SLFinancialProductClass.h"

#import "MJExtension.h"
#import "SLHttpTool.h"

@implementation SLFinancialProductListScreenTool

+ (void)financialProductListScreenItemWithParameters:(SLFinancialProductListScreenParameters *)parameters success:(void (^)(NSArray *financialProductClassArray))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [SLHttpUrl stringByAppendingString:@"/plate/listPlateClass"];
    
    [SLHttpTool postWithUrlstr:url parameters:parameters.keyValues success:^(id responseObject) {
        
        SLResult *result = [SLResult objectWithKeyValues:responseObject];
        
        NSArray *dictArray = [result.info firstObject];
        NSArray *financialProductClassArrayFirst = [SLFinancialProductClass objectArrayWithKeyValuesArray:dictArray];
        NSMutableArray *temp = [NSMutableArray array];
        SLFinancialProductClass *all = [[SLFinancialProductClass alloc] init];
        all.className = @"全部";
        all.classId = @0;
        [temp addObject:all];
        [temp addObjectsFromArray:financialProductClassArrayFirst];
        NSArray *financialProductClassArray = [NSArray arrayWithArray:temp];
        
        // 传递了block
        if (success) {
            success(financialProductClassArray);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
