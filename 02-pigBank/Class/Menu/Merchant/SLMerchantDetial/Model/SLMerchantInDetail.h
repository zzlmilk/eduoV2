//
//  SLMerchantInDetail.h
//  02-pigBank
//
//  Created by 陆承东 on 14/10/24.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

/*
 address = "\U4e0a\U6d77\U5e02\U957f\U4e50\U8def336\U53f7";
 certificateUrl = "http://xynh.eduoinfo.com/resources/client/image/b6678c53-f9fc-4e52-8d59-8ec607b841a7.jpg";
 collectCounts = 1;
 commentCounts = 1;
 description = "<p></p>";
 distanceToMe = 0;
 fullName = "\U6717\U8fc8\U4fdd\U9f84\U7403\U9986";
 gradeScore = 5;
 latitude = "31.227844";
 longitude = "121.469314";
 merchantId = 72;
 merchantUserInfo = {};
 praiseCounts = 0;
 shortName = "\U6717\U8fc8\U4fdd\U9f84\U7403\U9986";
 userId = 244;
 */

#import <Foundation/Foundation.h>

#import "SLMerchantUserInfo.h"

@interface SLMerchantInDetail : NSObject

@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *certificateUrl;
@property (nonatomic, strong) NSNumber *collectCounts;
@property (nonatomic, strong) NSNumber *commentCounts;
@property (nonatomic, copy) NSString *Description;
@property (nonatomic, strong) NSNumber *distanceToMe;
@property (nonatomic, copy) NSString *fullName;
@property (nonatomic, strong) NSNumber *gradeScore;
@property (nonatomic, strong) NSNumber *latitude;
@property (nonatomic, strong) NSNumber *longitude;
@property (nonatomic, strong) NSNumber *merchantId;
@property (nonatomic, strong) SLMerchantUserInfo *merchantUserInfo;
@property (nonatomic, strong) NSNumber *praiseCounts;
@property (nonatomic, copy) NSString *shortName;
@property (nonatomic, strong) NSNumber *userId;

@end
