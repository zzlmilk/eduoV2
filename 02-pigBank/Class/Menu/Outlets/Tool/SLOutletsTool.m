//
//  SLOutletsTool.m
//  02-pigBank
//
//  Created by 陆承东 on 14-10-16.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLOutletsTool.h"

#import "SLOutletsInfo.h"

#import "SLHttpTool.h"

#import "MJExtension.h"

@implementation SLOutletsTool

+ (void)outletsListWithParameters:(SLOutletsParameters *)parameters success:(void (^)(NSArray *outletsArray))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [SLHttpUrl stringByAppendingString:@"/material/listOutletsMaterialInfo"];
    
    [SLHttpTool postWithUrlstr:url parameters:parameters.keyValues success:^(id responseObject) {
        
        NSArray *dictArray = [responseObject[@"info"] lastObject];

        NSArray *outletsArray = [SLOutletsInfo objectArrayWithKeyValuesArray:dictArray];
        
        
        // 传递了block
        if (success) {
            success(outletsArray);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
