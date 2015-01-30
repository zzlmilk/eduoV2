//
//  SLUploadPicTool.m
//  02-pigBank
//
//  Created by 陆承东 on 15/1/27.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import "SLUploadPicTool.h"

#import "SLHttpTool.h"
#import "MJExtension.h"

@implementation SLUploadPicTool

+ (void)uploadPicWithParameters:(SLBaseParameters *)parameters image:(UIImage *)image success:(void (^)(SLResult *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [SLHttpUrl stringByAppendingString:@"/user/uploadAndChangeUserPhoto"];
    
    NSMutableArray *formDataArray = [NSMutableArray array];
    SLFormData *formData = [[SLFormData alloc] init];
    formData.data = UIImageJPEGRepresentation(image, 0.000001);
    formData.name = @"photo";
    formData.mimeType = @"image/jpeg";
    formData.filename = @"jpeg";
    [formDataArray addObject:formData];
    
    [SLHttpTool postWithUrlstr:url parameters:parameters.keyValues formDataArray:formDataArray success:^(id responseObject) {
        
        SLLog(@"%@", responseObject);
        
        SLResult *result = [SLResult objectWithKeyValues:responseObject];
        
        if (success) {
            success(result);
        }
        
    } failure:^(NSError *error) {
        
        SLLog(@"%@", error);
        
        if (failure) {
            failure(error);
        }
    }];
}

@end
