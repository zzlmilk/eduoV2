//
//  SLFinancialProductTool.m
//  02-pigBank
//
//  Created by 陆承东 on 14-10-15.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLFinancialProductTool.h"

#import "MJExtension.h"

#import "SLHttpTool.h"

#import "SLFinanceProduct.h"
#import "SLFinancialStatusFrame.h"
#import "SLFinancialProductFrameCacheTool.h"

@implementation SLFinancialProductTool

+ (void)financialProductListWithParameters:(SLFinancialProductParameters *)parameters success:(void (^)(NSArray *financialProductStatusFrameArray))success failure:(void (^)(NSError *error))failure
{
    // 1.先从缓存里面加载
    NSArray *financialStatusFrameArray = [SLFinancialProductFrameCacheTool statuesWithParameters:parameters];
    
    // 传递了block
    if (success) {
        success(financialStatusFrameArray);
    }
    
    NSString *url = [SLHttpUrl stringByAppendingString:@"/material/listFPMaterialInfo"];
    
    [SLHttpTool postWithUrlstr:url parameters:parameters.keyValues success:^(id responseObject) {
        // 取出状态字典数组
        NSArray *dictArray = [responseObject[@"info"] lastObject];
        
        NSMutableArray *financialProductStatusFrameArray = [NSMutableArray array];
        
        for (NSDictionary *dict in dictArray) {
            SLFinanceProduct *financeProduct = [SLFinanceProduct objectWithKeyValues:dict];
            SLFinancialStatusFrame *financialStatusFrame = [[SLFinancialStatusFrame alloc] init];
            financialStatusFrame.financeProduct = financeProduct;
            [financialProductStatusFrameArray addObject:financialStatusFrame];
        }
        
        [SLFinancialProductFrameCacheTool addFinancialProductFrames:financialProductStatusFrameArray];
        
        if (success) {
            success(financialProductStatusFrameArray);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
