//
//  SLClientInfo.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/21.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

/*
 dispName = "\U5218\U6625\U6d9b";
 insertTime = 1405492285041;
 materialUserList = ();
 mobile = 18692129402;
 pictureSmallUrl = "http://xynh.eduoinfo.com/resources/data2.0/ds/201408/cea00411249947779b1489863dd2fae1_1407121177613.png";
 pictureUrl = "http://xynh.eduoinfo.com/resources/data2.0/ds/201408/cea00411249947779b1489863dd2fae1_1407121177613.png";
 status = 2;
 updateTime = 1407121177899;
 userId = 143;
 userType = 3;
 vipDetail =             {
 levelSign = 1;
 levelSignText = "\U94bb\U77f3\U4f1a\U5458";
 userConsultant = 195;
 userId = 143;
 vipNumber = 718088705;
 };
 */

#import <Foundation/Foundation.h>

#import "SLVipDetail.h"

@interface SLClientInfo : NSObject

@property (nonatomic, copy) NSString *dispName;
@property (nonatomic, strong) NSNumber *insertTime;
@property (nonatomic, strong) NSArray *materialUserList;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *pictureSmallUrl;
@property (nonatomic, copy) NSString *pictureUrl;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, strong) NSNumber *updateTime;
@property (nonatomic, strong) NSNumber *userId;
@property (nonatomic, copy) NSString *userType;
@property (nonatomic, strong) SLVipDetail *vipDetail;

@end
