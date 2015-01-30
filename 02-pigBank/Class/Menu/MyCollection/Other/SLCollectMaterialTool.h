//
//  SLCollectMaterialTool.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/26.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SLResult.h"
#import "SLCollectedMaterialParameter.h"

@interface SLCollectMaterialTool : NSObject

+ (void)collcetedMaterialWithParameters:(SLCollectedMaterialParameter *)parameters urlStr:(NSString *)urlStr success:(void (^)(SLResult *result))success failure:(void (^)(NSError *error))failure;

@end
