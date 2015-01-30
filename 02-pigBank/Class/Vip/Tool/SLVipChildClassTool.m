//
//  SLVipChildClassTool.m
//  02-pigBank
//
//  Created by 陆承东 on 14-10-14.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLVipChildClassTool.h"

#import "MJExtension.h"

#import "SLHttpTool.h"

#import "SLVipStatus.h"
#import "SLVipStatusFrame.h"
#import "SLVipStatusFirstMaterialInfo.h"

@implementation SLVipChildClassTool

+ (void)vipChildStatusesWithParameters:(SLVipChildClassParameters *)parameters success:(void (^)(NSArray *vipChildStatusFrameArray))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [SLHttpUrl stringByAppendingString:@"/material/listPrivilageMaterialInfo"];
    
    [SLHttpTool postWithUrlstr:url parameters:parameters.keyValues success:^(id responseObject) {
        
        SLResult *result = [SLResult objectWithKeyValues:responseObject];
        
        if ([result.code isEqualToString:@"0000"]) {
            if (result.info.count > 0) {
                // 取出状态字典数组
                NSArray *dictArray = [result.info lastObject];
                
                NSMutableArray *vipStatusFrameArray = [NSMutableArray array];
                for (NSDictionary *dict in dictArray) {
                    SLVipStatusFirstMaterialInfo *vipStatusFirstMaterialInfo = [SLVipStatusFirstMaterialInfo objectWithKeyValues:dict];
                    SLVipStatusFrame *vipStatusFrame = [[SLVipStatusFrame alloc] init];
                    SLVipStatus *vipStatus = [[SLVipStatus alloc] init];
                    vipStatus.firstMaterialInfo = vipStatusFirstMaterialInfo;
                    vipStatusFrame.vipStatus = vipStatus;
                    [vipStatusFrameArray addObject:vipStatusFrame];
                    
                    // 传递了block
                    if (success) {
                        success(vipStatusFrameArray);
                    }
                }
            } else {
                [MBProgressHUD showError:result.msg];
            }
        } else {
            [MBProgressHUD showError:result.msg];
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
