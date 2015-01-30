//
//  SLMaterialInfoInClient.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/21.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

/*
 classId = 2;
 collectCounts = 0;
 content = “<p> </p>";
 extPictureUrl = "http://xynh.eduoinfo.com/resources/client/image/201443175649611.jpg";
 materialId = 181;
 materialUser = {};
 plateId = 1;
 praiseCounts = 3;
 publishModel = 1;
 recommendFlag = 0;
 searchKey = "\U5e0c\U5c14\U987f\U9152\U5e97  \U4f18\U60e0";
 status = 1;
 templetType = 2;
 title = "\U6613\U6735\U94f6\U884c\U8d35\U5bbe\U5361\U5728\U5e0c\U5c14\U987f\U9152\U5e97\U6d88\U8d39\U4eab20%\U4f18\U60e0";
 verifyStatus = 1;
 verifyTime = 1407311037627;
 */

#import <Foundation/Foundation.h>

#import "SLMaterialUser.h"

@interface SLMaterialInfoInClient : NSObject

@property (nonatomic, strong) NSNumber *classId;
@property (nonatomic, strong) NSNumber *collectCounts;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *extPictureUrl;
@property (nonatomic, strong) NSNumber *materialId;
@property (nonatomic, strong) SLMaterialUser *materialUser;
@property (nonatomic, strong) NSNumber *plateId;
@property (nonatomic, strong) NSNumber *praiseCounts;
@property (nonatomic, copy) NSString *publishModel;
@property (nonatomic, copy) NSString *recommendFlag;
@property (nonatomic, copy) NSString *searchKey;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *templetType;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *verifyStatus;
@property (nonatomic, strong) NSNumber *verifyTime;

@end
