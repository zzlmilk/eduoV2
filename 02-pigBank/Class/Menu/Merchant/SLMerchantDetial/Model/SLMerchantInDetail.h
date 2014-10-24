//
//  SLMerchantInDetail.h
//  02-pigBank
//
//  Created by 陆承东 on 14/10/24.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

/*
 address = "\U4e0a\U6d77\U5e02\U5e7f\U5143\U897f\U8def319\U53f7";
 
 certificateUrl = "http://xynh.eduoinfo.com/resources/client/image/73f8e2a8-201c-474a-8a13-c96a106e848c.jpg";
 
 collectCounts = 7;
 
 commentCounts = 24;
 
 description = "<p> </p>";
 
 distanceToMe = "1892.719644444036";
 
 fullName = "\U9526\U6c5f\U4e4b\U661f\Uff08\U5f90\U5bb6\U6c47\U5e97\Uff09";
 
 gradeScore = "2.62";
 
 latitude = "31.204134";
 
 longitude = "121.441974";
 
 merchantId = 66;
 
 merchantUserInfo =                             {  };
 
 praiseCounts = 6;
 
 shortName = "\U9526\U6c5f\U4e4b\U661f";
 
 userId = 238;
 */

#import <Foundation/Foundation.h>

#import "SLMerchantUserInfo.h"

@interface SLMerchantInDetail : NSObject

@property (nonatomic, copy) NSString *address;

@property (nonatomic, copy) NSString *certificateUrl;

@property (nonatomic, assign) long collectCounts;

@property (nonatomic, assign) long commentCounts;

@property (nonatomic, strong) NSNumber *distanceToMe;

@property (nonatomic, copy) NSString *fullName;

@property (nonatomic, strong) NSNumber *gradeScore;

@property (nonatomic, strong) NSNumber *latitude;

@property (nonatomic, strong) NSNumber *longitude;

@property (nonatomic, assign) long merchantId;

@property (nonatomic, strong) SLMerchantUserInfo *merchantUserInfo;

@property (nonatomic, assign) long praiseCounts;

@property (nonatomic, copy) NSString *shortName;

@property (nonatomic, assign) long userId;

@end
