//
//  SLSetTagParameters.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/26.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

/*
 userId	Long
 tagId	Long
 operateType	String
 */

#import "SLBaseParameters.h"

@interface SLSetTagParameters : SLBaseParameters

@property (nonatomic, copy) NSNumber *userId;
@property (nonatomic, copy) NSNumber *tagId;
@property (nonatomic, copy) NSNumber *operateType;

@end
