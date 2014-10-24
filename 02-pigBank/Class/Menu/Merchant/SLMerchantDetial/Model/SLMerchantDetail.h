//
//  SLMerchantDetail.h
//  02-pigBank
//
//  Created by 陆承东 on 14/10/22.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

/*
 商户详细信息
 {
 
 ①
 
 address = "\U4e0a\U6d77\U5e02\U65b0\U534e\U8def25\U53f7";
 
 certificateUrl = "http://xynh.eduoinfo.com/resources/client/image/Lighthouse.jpg";
 
 collectCounts = 5;
 
 commentCounts = 15;
 
 description = "<p> </p>";
 
 distanceToMe = "1798.120067523301";
 
 fullName = "\U6fb3\U9645\U9910\U5385";
 
 gradeScore = "3.73";
 
 latitude = "31.208078";
 
 longitude = "121.437686";
 
 merchantId = 42;
 
 merchantPhotoList = ();
 
 merchantUserInfo = {};
 
 myCommentList = ( );
 
 othersCommentList = ( );
 
 praiseCounts = 6;
 
 shortName = "\U6fb3\U9645\U9910\U5385";
 
 userId = 162;
 
 }
 */

#import <Foundation/Foundation.h>

#import "SLMerchantUserInfo.h"

@interface SLMerchantDetail : NSObject

@property (nonatomic, strong) SLMerchantUserInfo *merchantUserInfo;

@property (nonatomic, copy) NSString *address;

@property (nonatomic, copy) NSString *certificateUrl;

@property (nonatomic, assign) long collectCounts;

@property (nonatomic, assign) long commentCounts;

@property (nonatomic, copy) NSString *Description;

@property (nonatomic, strong) NSNumber *distanceToMe;

@property (nonatomic, copy) NSString *fullName;

@property (nonatomic, strong) NSNumber *gradeScore;

@property (nonatomic, strong) NSNumber *latitude;

@property (nonatomic, strong) NSNumber *longitude;

@property (nonatomic, strong) NSArray *materialInfoList;

@property (nonatomic, assign) long merchantId;

@property (nonatomic, strong) NSArray *merchantPhotoList;

@property (nonatomic, strong) NSArray *myCommentList;

@property (nonatomic, strong) NSArray *othersCommentList;

@property (nonatomic, assign) long praiseCounts;

@property (nonatomic, copy) NSString *shortName;

@property (nonatomic, assign) long userId;

@end
