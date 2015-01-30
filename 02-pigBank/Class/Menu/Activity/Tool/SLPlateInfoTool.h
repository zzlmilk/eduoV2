//
//  SLPlateInfoTool.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/22.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SLClassesListParameters.h"
#import "SLPlateInfoListParameters.h"
#import "SLResult.h"

@interface SLPlateInfoTool : NSObject

+ (void)classesListInPlateWithParameters:(SLClassesListParameters *)parameters success:(void (^)(NSArray *classesArray))success failure:(void (^)(NSError *error))failure;

+ (void)plateInfoListWithParameters:(SLPlateInfoListParameters *)parameters success:(void (^)(NSArray *plateInfoListArray))success failure:(void (^)(NSError *error))failure;

+ (void)saveInternerPlateList:(NSArray *)plateList;
+ (NSArray *)getInternetPlateList;
+ (void)savePlateInfoList:(NSArray *)plateInfoList;
+ (NSArray *)getPlateInfoList;

@end
