//
//  SLAccountInfo.h
//  02-pigBank
//
//  Created by 陆承东 on 14-9-26.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

/*
 dispName = "\U5c0f\U5e05\U54e5";
 insertTime = 1405499521674;
 mobile = 18121253011;
 pictureSmallUrl = "http://xynh.eduoinfo.com/resources/data2.0/ds/201410/7bb4f59f660b4dca8115ae05a911554c_1413358861247.pngsmall";
 pictureUrl = "http://xynh.eduoinfo.com/resources/data2.0/ds/201410/7bb4f59f660b4dca8115ae05a911554c_1413358861247.png";
 status = 2;
 updateTime = 1420956723126;
 userId = 147;
 userType = 3;
 vipDetail = { };
 */

#import <Foundation/Foundation.h>

#import "SLVipDetail.h"

@interface SLAccountInfo : NSObject

@property (nonatomic, copy) NSString *dispName;
@property (nonatomic, strong) NSNumber *insertTime;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *pictureSmallUrl;
@property (nonatomic, copy) NSString *pictureUrl;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, strong) NSNumber *updateTime;
@property (nonatomic, strong) NSNumber *userId;
@property (nonatomic, copy) NSString *userType;
@property (nonatomic, strong) SLVipDetail *vipDetail ;

@end
