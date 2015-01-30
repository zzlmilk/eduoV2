//
//  SLChangeCoordinateTool.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/30.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SLChangeCoordinateParameters.h"
#import "SLChangeCoordinateResult.h"

@interface SLChangeCoordinateTool : NSObject

+ (void)changeCoordinateWithParameters:(SLChangeCoordinateParameters *)parameters success:(void (^)(SLChangeCoordinateResult *result))success failure:(void (^)(NSError *error))failure;

@end
