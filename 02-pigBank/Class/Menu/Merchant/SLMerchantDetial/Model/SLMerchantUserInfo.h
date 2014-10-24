//
//  SLMerchantUserInfo.h
//  02-pigBank
//
//  Created by 陆承东 on 14/10/22.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

/*
 dispName = "\U5f20\U5c0f\U59d0";
 
 mobile = 1595235451;
 
 pictureSmallUrl = "http://xynh.eduoinfo.com/resources/client/image/86b2a788-63c5-45e0-ac2c-cbc4993a682c.jpg";
 
 pictureUrl = "http://xynh.eduoinfo.com/resources/client/image/86b2a788-63c5-45e0-ac2c-cbc4993a682c.jpg";
 
 telephone = 56623998;
 
 userId = 162;
 
 userType = 4;
 
 
 */

#import <Foundation/Foundation.h>

@interface SLMerchantUserInfo : NSObject

@property (nonatomic, copy) NSString *dispName;

@property (nonatomic, strong) NSNumber *mobile;

@property (nonatomic, copy) NSString *pictureSmallUrl;

@property (nonatomic, copy) NSString *pictureUrl;

@property (nonatomic, strong) NSNumber *telephone;

@property (nonatomic, assign) long userId;

@property (nonatomic, strong) NSNumber *userType;

@end
