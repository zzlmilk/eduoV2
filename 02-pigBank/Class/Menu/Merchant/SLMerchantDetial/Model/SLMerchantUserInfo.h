//
//  SLMerchantUserInfo.h
//  02-pigBank
//
//  Created by 陆承东 on 14/10/22.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

/*
 blogCode = "sh111_sinablog";
 blogType = 0;
 dispName = "\U5546\U6237111";
 email = "sh111@email.com";
 introduction = "\U6211\U662f\U5546\U6237111";
 mobile = 15200001111;
 pictureSmallUrl = "http://xynh.eduoinfo.com/resources/client/image/4f25555b-ed1a-403b-a497-23d5370bffda.jpg";
 pictureUrl = "http://xynh.eduoinfo.com/resources/client/image/4f25555b-ed1a-403b-a497-23d5370bffda.jpg";
 qqCode = 777700;
 telephone = "021-55556666";
 userId = 103;
 userType = 4;
 wechatCode = "sh888_weixin";
 */

#import <Foundation/Foundation.h>

@interface SLMerchantUserInfo : NSObject

@property (nonatomic, copy) NSString *blogCode;
@property (nonatomic, strong) NSNumber *blogType;
@property (nonatomic, copy) NSString *dispName;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *introduction;
@property (nonatomic, strong) NSNumber *mobile;
@property (nonatomic, copy) NSString *pictureSmallUrl;
@property (nonatomic, copy) NSString *pictureUrl;
@property (nonatomic, strong) NSNumber *qqCode;
@property (nonatomic, strong) NSNumber *telephone;
@property (nonatomic, strong) NSNumber *userId;
@property (nonatomic, strong) NSNumber *userType;
@property (nonatomic, copy) NSString *wechatCode;

@end
