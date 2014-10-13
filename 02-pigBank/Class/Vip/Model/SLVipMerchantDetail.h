//
//  SLVipMerchantDetail.h
//  02-pigBank
//
//  Created by 陆承东 on 14-9-23.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SLVipMerchantUserInfo.h"

@interface SLVipMerchantDetail : NSObject

/** address */
@property (nonatomic, copy) NSString *address;

/** merchantUserInfo 商户信息 */
@property (nonatomic, strong) SLVipMerchantUserInfo *merchantUserInfo;

/** gradeScore */
@property (nonatomic, copy) NSString *gradeScore;

/** fullName 商户名称 */
@property (nonatomic, copy) NSString *fullName;


@end
