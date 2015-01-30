//
//  SLActivityDetail.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/21.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

/*
 VerifyStatus = 1;
 adId = 2;
 address = "\U4e0a\U6d77\U957f\U5b81\U533a\U8679\U6865\U8def333\U53f7111\U5ba4";
 collectFlag = 1;
 content = asd;
 endTime = 1422690578000;
 isSign = 100;
 latitude = "33.909011";
 longitude = "121.101099";
 materialId = 271;
 maxSign = 50;
 pictureSmallUrl = "http://xynh.eduoinfo.com/resources/data2.0/ds/201407/d7e793cea3d04c7aa79a6681cb04004b_1405910840798.pngsmall";
 pictureUrl = "http://xynh.eduoinfo.com/resources/data2.0/ds/201407/d7e793cea3d04c7aa79a6681cb04004b_1405910840798.png";
 praiseFlag = 1;
 scope = "50-100\U4eba";
 signCount = 2;
 signEndTime = 1422604247000;
 startTime = 1422665373000;
 status = 1;
 title = "\U6d3b\U52a8";
 */

#import <Foundation/Foundation.h>

@interface SLActivityDetail : NSObject

@property (nonatomic, copy) NSString *VerifyStatus;
@property (nonatomic, strong) NSNumber *adId;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *collectFlag;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, strong) NSNumber *endTime;
@property (nonatomic, strong) NSNumber *isSign;
@property (nonatomic, strong) NSNumber *latitude;
@property (nonatomic, strong) NSNumber *longitude;
@property (nonatomic, strong) NSNumber *materialId;
@property (nonatomic, strong) NSNumber *maxSign;
@property (nonatomic, copy) NSString *pictureSmallUrl;
@property (nonatomic, copy) NSString *pictureUrl;
@property (nonatomic, copy) NSString *praiseFlag;
@property (nonatomic, copy) NSString *scope;
@property (nonatomic, copy) NSString *signCount;
@property (nonatomic, strong) NSNumber *signEndTime;
@property (nonatomic, strong) NSNumber *startTime;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *startTimeStr;
@property (nonatomic, copy) NSString *endTimeStr;

@end
