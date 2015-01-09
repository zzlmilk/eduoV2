//
//  SLVipMerchantDetail.h
//  02-pigBank
//
//  Created by 陆承东 on 14-9-23.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

/*
 address = "\U4e0a\U6d77\U5e02\U65b0\U534e\U8def25\U53f7";
 certificateUrl = "http://xynh.eduoinfo.com/resources/client/image/Lighthouse.jpg";
 collectCounts = 5;
 commentCounts = 14;
 description = "<p></p>";
 distanceToMe = "1802.642228581841";
 fullName = "\U6fb3\U9645\U9910\U5385";
 gradeScore = "3.64";
 latitude = "31.208078";
 longitude = "121.437686";
 merchantId = 42;
 merchantUserInfo = {};
 praiseCounts = 6;
 shortName = "\U6fb3\U9645\U9910\U5385";
 userId = 162;
 */

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

/** distanceToMe */
@property (nonatomic, copy) NSString *distanceToMe;

/** praiseCounts */
@property (nonatomic, strong) NSNumber *praiseCounts;

/** latitude */
@property (nonatomic, strong) NSNumber *latitude;

/** longitude */
@property (nonatomic, strong) NSNumber *longitude;

/** merchantId */
@property (nonatomic, strong) NSNumber *merchantId;

@end
