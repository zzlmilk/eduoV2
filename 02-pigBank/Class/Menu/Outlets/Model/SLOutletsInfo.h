//
//  SLOutletsInfo.h
//  02-pigBank
//
//  Created by 陆承东 on 14-10-16.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

/*
 collectCounts = 1;
 content = "<p></p>";
 materialId = 208;
 materialUser =                 {};
 outletsDetail =                 {};
 plateId = 3;
 praiseCounts = 0;
 publishModel = 1;
 recommendFlag = 0;
 searchKey = "\U6613\U6735\U94f6\U884c";
 status = 1;
 templetType = 6;
 title = "\U6613\U6735\U94f6\U884c\U6d59\U6c5f\U7701\U57ce\U5173\U50a8\U84c4\U6240";
 verifyStatus = 1;
 verifyTime = 1407319006860;
 */

#import <Foundation/Foundation.h>

#import "SLOutletsDetail.h"
#import "SLMaterialUser.h"

@interface SLOutletsInfo : NSObject

/** collectCounts */
@property (nonatomic, strong) NSNumber *collectCounts;
/** content */
@property (nonatomic, copy) NSString *content;
/** materialId */
@property (nonatomic, strong) NSNumber *materialId;
@property (nonatomic, strong) SLMaterialUser *materialUser;
@property (nonatomic, strong) SLOutletsDetail *outletsDetail;
/** plateId */
@property (nonatomic, strong) NSNumber *plateId;
/** praiseCounts */
@property (nonatomic, strong) NSNumber *praiseCounts;
/** publishModel */
@property (nonatomic, strong) NSNumber *publishModel;
/** recommendFlag */
@property (nonatomic, strong) NSNumber *recommendFlag;
/** searchKey */
@property (nonatomic, copy) NSString *searchKey;
/** status */
@property (nonatomic, strong) NSNumber *status;
/** templetType */
@property (nonatomic, strong) NSNumber *templetType;
/** title */
@property (nonatomic, copy) NSString *title;
/** verifyStatus */
@property (nonatomic, strong) NSNumber *verifyStatus;
/** verifyTime */
@property (nonatomic, strong) NSNumber *verifyTime;

@end
