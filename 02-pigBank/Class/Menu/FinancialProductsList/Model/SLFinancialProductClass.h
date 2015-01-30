//
//  SLFinancialProductClass.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/19.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SLFirstMaterialInfo.h"

/*
 {
 classId = 5;
 className = "\U7406\U8d22\U4e00";
 classSort = 1;
 dispName = "\U7406\U8d22\U4e00";
 firstMaterialInfo = { };
 insertTime = 1405050068000;
 insertUser = 1;
 pictureUrl = "http://xynh.eduoinfo.com/resources/data2.0/ds/xing.png";
 plateId = 2;
 updateTime = 1407725978689;
 updateUser = 1;
 usedFlag = 1;
 },
 */

@interface SLFinancialProductClass : NSObject

@property (nonatomic, strong) NSNumber *classId;
@property (nonatomic, copy) NSString *className;
@property (nonatomic, strong) NSNumber *classSort;
@property (nonatomic, copy) NSString *dispName;
@property (nonatomic, strong) SLFirstMaterialInfo *firstMaterialInfo;
@property (nonatomic, strong) NSNumber *insertTime;
@property (nonatomic, strong) NSNumber *insertUser;
@property (nonatomic, copy) NSString *pictureUrl;
@property (nonatomic, strong) NSNumber *plateId;
@property (nonatomic, strong) NSNumber *updateTime;
@property (nonatomic, strong) NSNumber *updateUser;
@property (nonatomic, copy) NSString *usedFlag;

@end
