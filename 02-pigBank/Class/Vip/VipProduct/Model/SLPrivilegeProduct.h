//
//  SLPrivilageProduct.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/9.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SLMaterialUser.h"
#import "SLPrivilegeDetail.h"

/*
 classId = 1;
 collectCounts = 13;
 content = "<p></p>";
 extPictureUrl = "http://xynh.eduoinfo.com/resources/client/image/7937905f-e5d7-48ed-ab3e-36f42d6153f7.jpg";
 materialId = 253;
 materialUser = {};
 plateId = 1;
 praiseCounts = 12;
 privilegeDetail = {};
 publishModel = 1;
 recommendFlag = 0;
 searchKey = "";
 status = 1;
 templetType = 2;
 title = "\U6613\U6735\U94f6\U884c\U5e26\U60a8\U5c0a\U4eab\U6743\U91d1\U57ce\U4e94\U6298\U949c\U60e0";
 verifyStatus = 1;
 verifyTime = 1407836918143;
 */

@interface SLPrivilegeProduct : NSObject

@property (nonatomic, strong) NSNumber *classId;
@property (nonatomic, strong) NSNumber *collectCounts;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *extPictureUrl;
@property (nonatomic, strong) NSNumber *materialId;
@property (nonatomic, strong) SLMaterialUser *materialUser;
@property (nonatomic, strong) NSNumber *plateId;
@property (nonatomic, strong) NSNumber *praiseCounts;
@property (nonatomic, strong) SLPrivilegeDetail *privilegeDetail;
@property (nonatomic, strong) NSNumber *publishModel;
@property (nonatomic, strong) NSNumber *recommendFlag;
@property (nonatomic, copy) NSString *searchKey;
@property (nonatomic, strong) NSNumber *status;
@property (nonatomic, strong) NSNumber *templetType;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSNumber *verifyStatus;
@property (nonatomic, strong) NSNumber *verifyTime;

@end
