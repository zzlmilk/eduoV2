//
//  SLClientDetail.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/24.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

/*
 dispName = "\U521a\U521a\U597d";
 email = "admin@w";
 insertTime = 1405331170519;
 mobile = 18221361630;
 pictureSmallUrl = "http://xynh.eduoinfo.com/resources/data2.0_testcase/ds/201407/d7e793cea3d04c7aa79a6681cb04004b_1405910840798.png";
 pictureUrl = "http://xynh.eduoinfo.com/resources/data2.0_testcase/ds/201407/d7e793cea3d04c7aa79a6681cb04004b_1405910840798.png";
 qqCode = "";
 status = 2;
 telephone = 58649215;
 updateTime = 1407392824622;
 userId = 137;
 userRemark = {};
 userTags = ( { }, { }, { } );
 userType = 3;
 vipDetail = {};
 */

#import <Foundation/Foundation.h>

#import "SLUserRemark.h"
#import "SLVipDetail.h"

@interface SLClientDetail : NSObject

@property (nonatomic, copy) NSString *dispName;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, strong) NSNumber *insertTime;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *pictureSmallUrl;
@property (nonatomic, copy) NSString *pictureUrl;
@property (nonatomic, copy) NSString *qqCode;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *telephone;
@property (nonatomic, strong) NSNumber *updateTime;
@property (nonatomic, strong) NSNumber *userId;
@property (nonatomic, strong) SLUserRemark *userRemark;
@property (nonatomic, strong) NSArray *userTags;
@property (nonatomic, copy) NSString *userType;
@property (nonatomic, strong) SLVipDetail *vipDetail;

@end
