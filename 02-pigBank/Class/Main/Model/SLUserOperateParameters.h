//
//  SLUserOperateParameters.h
//  02-pigBank
//
//  Created by 陆承东 on 14-10-16.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

/*
 materialId	Long
 operateType	String
 operateValue	String
 operateTime	Long
 */

#import "SLBaseParameters.h"

@interface SLUserOperateParameters : SLBaseParameters

/** materialId */
@property (nonatomic, strong) NSNumber *materialId;

/** operateTime */
@property (nonatomic, strong) NSNumber *operateTime;

/** operateType */
@property (nonatomic, copy) NSString *operateType;

/** operateValue */
@property (nonatomic, copy) NSString *operateValue;

@end
