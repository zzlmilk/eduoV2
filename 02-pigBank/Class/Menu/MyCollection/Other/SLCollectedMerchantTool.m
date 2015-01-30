//
//  SLCollectedMerchantTool.m
//  02-pigBank
//
//  Created by 陆承东 on 14/12/23.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLCollectedMerchantTool.h"

#import "SLMerchantStatus.h"

#import "SLHttpTool.h"

#import "MJExtension.h"

@implementation SLCollectedMerchantTool

/**
 *  加载网点的数据
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)CollcetedMerchantWithParameters:(SLCollectedMerchantParameters *)parameters success:(void (^)(NSArray *collectedMerchantArray))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [SLHttpUrl stringByAppendingString:@"/merchant/listCollectMerchantInfo"];
    
    [SLHttpTool postWithUrlstr:url parameters:parameters.keyValues success:^(id responseObject) {
        
        NSArray *collectedMerchantArray = [responseObject[@"info"] lastObject];
        
//        NSMutableArray *merchantDetailArray = [NSMutableArray array];
//        for (int i = 0; i < collectedMerchantArray.count; i++) {
//            NSDictionary *dict = collectedMerchantArray[i];
//            SLLog(@"%@", dict);
//            SLMerchantStatus *merchantDetail = [SLMerchantStatus objectWithKeyValues:dict];
//            [merchantDetailArray addObject:merchantDetail];
//        }
//
//        NSArray *collectedMerchantArray = (NSArray *)merchantDetailArray;
        
        
        // 传递了block
        if (success) {
            success(collectedMerchantArray);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
