//
//  SLHomeStatus.h
//  02-pigBank
//
//  Created by 陆承东 on 14-9-17.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

/*
 classId = 6;
 collectCounts = 10;
 content = "<p></p>";
 extPictureUrl = "http://xynh.eduoinfo.com/resources/client/image/d1c956b3-df94-4377-9305-dc96de5e6662.jpg";
 financialProductsDetail =                 {};
 materialId = 264;
 materialUser =                 {};
 plateId = 2;
 praiseCounts = 12;
 publishModel = 1;
 recommendFlag = 0;
 searchKey = "\U94f6\U884c\U7406\U8d22";
 status = 1;
 templetType = 3;
 title = "\U6613\U6735\U94f6\U884c\U201c\U6613\U6735\U521b\U5bcc\U201d(B \U6b3e 2014 \U5e74\U7b2c 4 \U671f)";
 verifyStatus = 1;
 verifyTime = 1408091890273;
 */

#import <Foundation/Foundation.h>

#import "SLFinancialProductsDetail.h"
#import "SLMaterialUser.h"

@interface SLHomeStatus : NSObject <NSCoding>

@property (nonatomic, strong) NSNumber *classId;
@property (nonatomic, strong) NSNumber *collectCounts;
@property (nonatomic, copy) NSString *content;
/** 图片 */
@property (nonatomic, copy) NSString *extPictureUrl;
@property (nonatomic, strong) NSNumber *materialId;
@property (nonatomic, strong) SLMaterialUser *materialUser;
/** plateId */
@property (nonatomic, strong) NSNumber *plateId;
/** 喜欢的人数 */
@property (nonatomic, strong) NSNumber *praiseCounts;
@property (nonatomic, strong) NSNumber *publishModel;
@property (nonatomic, strong) NSNumber *recommendFlag;
@property (nonatomic, copy) NSString *searchKey;
@property (nonatomic, strong) NSNumber *status;
/** 数据模版类型 */
@property (nonatomic, strong) NSNumber *templetType;
/** 标题 */
@property (nonatomic, copy) NSString *title;
/** materialId */
@property (nonatomic, strong) NSNumber *verifyStatus;
/** verifyTime */
@property (nonatomic, strong) NSNumber *verifyTime;

@end
