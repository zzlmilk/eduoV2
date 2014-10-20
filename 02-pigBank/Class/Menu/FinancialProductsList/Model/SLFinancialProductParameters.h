//
//  SLFinancialProductParameters.h
//  02-pigBank
//
//  Created by 陆承东 on 14-10-15.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLHomeStatusParameters.h"

@interface SLFinancialProductParameters : SLHomeStatusParameters

/**
 *  plateId
 */
@property (nonatomic, strong) NSNumber *plateId;

/**
 *  板块子分类id
 */
@property (nonatomic, strong) NSNumber *classId;

@property (nonatomic, copy) NSString *orderType;

@end
