//
//  SLMerchantStatus.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/7.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

/*
 address = "\U4e0a\U6d77\U5e02\U8087\U5609\U6d5c\U8def1077\U53f7";
 certificateUrl = "http://xynh.eduoinfo.com/resources/client/image/u=3254571351,1561753789&fm=21&gp=0.jpg";
 collectCounts = 5;
 commentCounts = 10;
 description = "<p></p>";
 distanceToMe = 0;
 fullName = "BEST BUY";
 gradeScore = "4.4";
 latitude = "31.200631";
 longitude = "121.446757";
 merchantId = 49;
 merchantUserInfo =     {
 dispName = "\U6c5f\U5c71";
 mobile = 13661540124;
 pictureSmallUrl = "http://xynh.eduoinfo.com/resources/client/image/u=216950229,4244876245&fm=23&gp=0.jpg";
 pictureUrl = "http://xynh.eduoinfo.com/resources/client/image/u=216950229,4244876245&fm=23&gp=0.jpg";
 telephone = 64289896;
 userId = 208;
 userType = 4;
 };
 praiseCounts = 3;
 shortName = "\U767e\U601d\U4e70";
 userId = 208;
 */

#import <Foundation/Foundation.h>

#import "SLMerchantUserInfo.h"

@interface SLMerchantStatus : NSObject

@property (nonatomic, copy) NSString *address;

@property (nonatomic, copy) NSString *certificateUrl;

@property (nonatomic, strong) NSNumber *collectCounts;

@property (nonatomic, strong) NSNumber *commentCounts;

@property (nonatomic, strong) NSNumber *distanceToMe;

@property (nonatomic, copy) NSString *fullName;

@property (nonatomic, strong) NSNumber *gradeScore;

@property (nonatomic, strong) NSNumber *latitude;

@property (nonatomic, strong) NSNumber *longitude;

@property (nonatomic, strong) NSNumber *merchantId;

@property (nonatomic, strong) NSNumber *praiseCounts;

@property (nonatomic, copy) NSString *shortName;

@property (nonatomic, strong) NSNumber *userId;

@property (nonatomic, strong) SLMerchantUserInfo *merchantUserInfo;

@end
