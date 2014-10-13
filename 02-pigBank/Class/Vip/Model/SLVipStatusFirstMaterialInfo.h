//
//  SLVipStatusFirstMaterialInfo.h
//  02-pigBank
//
//  Created by 陆承东 on 14-9-23.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SLVipPrivilegeDetail.h"

@interface SLVipStatusFirstMaterialInfo : NSObject

/** title */
@property (nonatomic, copy) NSString *title;

/** praiseCounts */
@property (nonatomic, assign) long praiseCounts;

/** vipPrivilegeDetail */
@property (nonatomic, strong) SLVipPrivilegeDetail *privilegeDetail;

/** materialId */
@property (nonatomic, assign) long materialId;

/** 数据模版类型 */
@property (nonatomic, assign) int templetType;

/** content 内容 */
@property (nonatomic, copy) NSString *content;

@end
