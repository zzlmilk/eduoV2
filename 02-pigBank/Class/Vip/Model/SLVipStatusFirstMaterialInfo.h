//
//  SLVipStatusFirstMaterialInfo.h
//  02-pigBank
//
//  Created by 陆承东 on 14-9-23.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

/*
 classId = 4;
 collectCounts = 4;
 content = "<p></p>";
 materialId = 207;
 plateId = 1;
 praiseCounts = 6;
 privilegeDetail =                     {};
 publishModel = 1;
 recommendFlag = 0;
 searchKey = "\U4fdd\U9f84\U7403\U9986";
 status = 1;
 templetType = 2;
 title = "\U7f24\U7eb7\U590f\U4e50\U6c47 \U90ce\U8fc8\U4fdd\U9f84\U7403\U9986\U95e8\U7968\U4eab\U7279\U4ef7";
 verifyStatus = 1;
 verifyTime = 1407317776703;
 */

#import <Foundation/Foundation.h>

#import "SLPrivilegeDetail.h"

@interface SLVipStatusFirstMaterialInfo : NSObject

@property (nonatomic, strong) NSNumber *classId;
@property (nonatomic, strong) NSNumber *collectCounts;
/** content 内容 */
@property (nonatomic, copy) NSString *content;
/** materialId */
@property (nonatomic, strong) NSNumber *materialId;
@property (nonatomic, strong) NSNumber *plateId;                         
/** praiseCounts */
@property (nonatomic, strong) NSNumber *praiseCounts;
/** vipPrivilegeDetail */
@property (nonatomic, strong) SLPrivilegeDetail *privilegeDetail;
@property (nonatomic, strong) NSNumber *publishModel;
@property (nonatomic, strong) NSNumber *recommendFlag;
@property (nonatomic, copy) NSString *searchKey;
@property (nonatomic, strong) NSNumber *status;
/** 数据模版类型 */
@property (nonatomic, strong) NSNumber *templetType;
/** title */
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSNumber *verifyStatus;
@property (nonatomic, strong) NSNumber *verifyTime;

@end
