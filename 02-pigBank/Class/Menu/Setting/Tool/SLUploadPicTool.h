//
//  SLUploadPicTool.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/27.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SLBaseParameters.h"
#import "SLResult.h"

@interface SLUploadPicTool : NSObject

+ (void)uploadPicWithParameters:(SLBaseParameters *)parameters image:(UIImage *)image success:(void (^)(SLResult *result))success failure:(void (^)(NSError *error))failure;

@end
