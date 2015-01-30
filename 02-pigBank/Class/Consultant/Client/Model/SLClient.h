//
//  SLClient.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/19.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

/*
 {
 dispName = "\U5218\U6625\U6d9b";
 insertTime = 1405492285041;
 mobile = 18692129402;
 pictureSmallUrl = "http://xynh.eduoinfo.com/resources/data2.0/ds/201408/cea00411249947779b1489863dd2fae1_1407121177613.png";
 pictureUrl = "http://xynh.eduoinfo.com/resources/data2.0/ds/201408/cea00411249947779b1489863dd2fae1_1407121177613.png";
 status = 2;
 updateTime = 1407121177899;
 userId = 143;
 userRemark = { };
 userType = 3;
 vipDetail = { };
 },
 */

#import <Foundation/Foundation.h>

#import "SLUserRemark.h"
#import "SLVipDetail.h"
#import "SLMaterialUser.h"

@interface SLClient : NSObject

@property (nonatomic, copy) NSString *dispName;
@property (nonatomic, strong) NSNumber *insertTime;
@property (nonatomic, strong) SLMaterialUser *materialUser;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *pictureSmallUrl;
@property (nonatomic, copy) NSString *pictureUrl;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, strong) NSNumber *updateTime;
@property (nonatomic, strong) NSNumber *userId;
@property (nonatomic, strong) SLUserRemark *userRemark;
@property (nonatomic, copy) NSString *userType;
@property (nonatomic, strong) SLVipDetail *vipDetail;

@end
