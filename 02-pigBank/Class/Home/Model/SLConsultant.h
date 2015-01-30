//
//  SLConsultant.h
//  02-pigBank
//
//  Created by 陆承东 on 14-9-29.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

/*
 blogCode = "lc888_qqblog";
 blogType = 1;
 consultantDetail =                 {
 inventionCode = 123123;
 userId = 102;
 };
 dispName = "\U7406\U8d22888";
 email = "lc888@email.com";
 insertTime = 1405048788000;
 introduction = "\U6211\U662f\U7406\U8d22888";
 mobile = 13189898888;
 pictureSmallUrl = "http://xynh.eduoinfo.com/resources/client/image/7c7b08f9-3347-44c6-92d9-a65bd693e398.jpg";
 pictureUrl = "http://xynh.eduoinfo.com/resources/client/image/7c7b08f9-3347-44c6-92d9-a65bd693e398.jpg";
 qqCode = 888899;
 status = 2;
 telephone = "021-67675655";
 updateTime = 1407997276930;
 userId = 102;
 userType = 2;
 wechatCode = "lc888_weixin";
 */

#import <Foundation/Foundation.h>

#import "SLConsultantDetail.h"

@interface SLConsultant : NSObject

@property (nonatomic, copy) NSString *blogCode;
@property (nonatomic, copy) NSString *blogType;
//@property (nonatomic, strong) SLConsultantDetail *consultantDetail;
@property (nonatomic, copy) NSString *dispName;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, strong) NSNumber *insertTime;
@property (nonatomic, copy) NSString *introduction;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *pictureSmallUrl;
@property (nonatomic, copy) NSString *pictureUrl;
@property (nonatomic, copy) NSString *qqCode;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *telephone;
@property (nonatomic, strong) NSNumber *updateTime;
@property (nonatomic, strong) NSNumber *userId;
@property (nonatomic, copy) NSString *userType;
@property (nonatomic, copy) NSString *wechatCode;

@end
