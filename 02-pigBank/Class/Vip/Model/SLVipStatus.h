//
//  SLVipStatus.h
//  02-pigBank
//
//  Created by 陆承东 on 14-9-23.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

/*
 classId = 4;
 className = "\U5065\U5eb7";
 classSort = 5;
 dispName = "\U5065\U5eb7";
 firstMaterialInfo = {};
 insertTime = 1405050015000;
 insertUser = 1;
 pictureUrl = "http://xynh.eduoinfo.com/resources/data2.0/ds/class/jianKang@2x.png";
 plateId = 1;
 updateTime = 1414490053956;
 updateUser = 1;
 usedFlag = 1;
 */

#import <Foundation/Foundation.h>

#import "SLVipStatusFirstMaterialInfo.h"

#define SLVipStatusTitleFont [UIFont boldSystemFontOfSize:14]
#define SLVipStatusPraiseCountsFont [UIFont systemFontOfSize:12]

@interface SLVipStatus : NSObject

/** className */
@property (nonatomic, strong) NSNumber *classId;

/** className */
@property (nonatomic, copy) NSString *className;
@property (nonatomic, strong) NSNumber *classSort;
@property (nonatomic, copy) NSString *dispName;

/** firstMaterialInfo */
@property (nonatomic, strong) SLVipStatusFirstMaterialInfo *firstMaterialInfo;
@property (nonatomic, strong) NSNumber *insertTime;
@property (nonatomic, strong) NSNumber *insertUser;

/** pictureUrl */
@property (nonatomic, copy) NSString *pictureUrl;
@property (nonatomic, strong) NSNumber *plateId;
@property (nonatomic, strong) NSNumber *updateTime;
@property (nonatomic, strong) NSNumber *updateUser;
@property (nonatomic, strong) NSNumber *usedFlag;


@end
