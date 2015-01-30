//
//  SLAccount.h
//  02-pigBank
//
//  Created by 陆承东 on 14-9-16.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SLAccountInfo.h"

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

@interface SLAccount : NSObject

@property (nonatomic, copy) NSString *code;
@property (nonatomic, strong) SLAccountInfo *accountInfo;
@property (nonatomic, copy) NSString *msg;
@property (nonatomic, strong) NSNumber *time;
@property (nonatomic, copy) NSString *token;
@property (nonatomic, strong) NSNumber *uid;
@property (nonatomic, strong) NSDate *expireTime;

//+ (instancetype)accountWithDict:(NSDictionary *)dict;
//- (instancetype)initWithDict:(NSDictionary *)dict;

@end
