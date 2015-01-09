//
//  SLMerchantDetail.h
//  02-pigBank
//
//  Created by 陆承东 on 14/10/22.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

/*
 address = "\U4e0a\U6d77\U5e02\U8087\U5609\U6d5c\U8def1077\U53f7";
 certificateUrl = "http://xynh.eduoinfo.com/resources/client/image/u=3254571351,1561753789&fm=21&gp=0.jpg";
 collectCounts = 5;
 commentCounts = 10;
 description = "<p></p>";
 distanceToMe = "1984.390439397559";
 fullName = "BEST BUY";
 gradeScore = "4.4";
 latitude = "31.200631";
 longitude = "121.446757";
 merchantId = 49;
 merchantPhotoList = ();
 merchantUser =             {};
 merchantUserInfo =             {};
 myCommentList =             ();
 othersCommentList =             ();
 praiseCounts = 3;
 shortName = "\U767e\U601d\U4e70";
 userId = 208;
 */

#import <Foundation/Foundation.h>

#import "SLMerchantUserInfo.h"
#import "SLMerchantUser.h"

@interface SLMerchantDetail : NSObject

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
@property (nonatomic, strong) NSArray *materialInfoList;
@property (nonatomic, strong) NSNumber *merchantId;
@property (nonatomic, strong) NSArray *merchantPhotoList;
@property (nonatomic, strong) SLMerchantUser *merchantUser;
@property (nonatomic, strong) SLMerchantUserInfo *merchantUserInfo;
@property (nonatomic, strong) NSArray *myCommentList;
@property (nonatomic, strong) NSArray *othersCommentList;
@property (nonatomic, strong) NSNumber *praiseCounts;
@property (nonatomic, copy) NSString *shortName;
@property (nonatomic, strong) NSNumber *userId;


@end
