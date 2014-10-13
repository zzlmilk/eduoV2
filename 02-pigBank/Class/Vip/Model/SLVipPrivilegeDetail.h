//
//  SLVipPrivilegeDetail.h
//  02-pigBank
//
//  Created by 陆承东 on 14-9-23.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SLVipMerchantDetail.h"

@interface SLVipPrivilegeDetail : NSObject

/** pictureUrl 首页展示图片地址 */
@property (nonatomic, copy) NSString *pictureUrl;

/** vipMerchantDetail */
@property (nonatomic, strong) SLVipMerchantDetail *merchantDetail;

/** saleDescript 促销描述 */
@property (nonatomic, copy) NSString *saleDescript;





@end
