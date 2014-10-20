//
//  SLOutletsInfo.h
//  02-pigBank
//
//  Created by 陆承东 on 14-10-16.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SLOutletsDetail.h"

/*
 outletsDetail = {};
 */

@interface SLOutletsInfo : NSObject

@property (nonatomic, strong) SLOutletsDetail *outletsDetail;

/** content */
@property (nonatomic, copy) NSString *content;

/** searchKey */
//@property (nonatomic, copy) NSString *searchKey;

/** title */
@property (nonatomic, copy) NSString *title;

/** collectCounts */
@property (nonatomic, assign) long collectCounts;

/** materialId */
@property (nonatomic, assign) long materialId;

/** plateId */
//@property (nonatomic, assign) long plateId;

/** praiseCounts */
@property (nonatomic, assign) long praiseCounts;

/** publishModel */
//@property (nonatomic, assign) long publishModel;

/** recommendFlag */
//@property (nonatomic, assign) long recommendFlag;

/** status */
//@property (nonatomic, assign) long status;

/** templetType */
//@property (nonatomic, assign) long templetType;

/** verifyStatus */
//@property (nonatomic, assign) long verifyStatus;

/** verifyTime */
//@property (nonatomic, assign) long long verifyTime;

@end
