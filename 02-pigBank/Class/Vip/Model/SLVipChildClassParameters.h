//
//  SLVipChildClassParameters.h
//  02-pigBank
//
//  Created by 陆承东 on 14-10-14.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLHomeStatusParameters.h"

@interface SLVipChildClassParameters : SLHomeStatusParameters


/**
*   板块Id
*/
@property (nonatomic, strong) NSNumber *plateId;

/**
 *  板块子分类Id
 */
@property (nonatomic, strong) NSNumber *classId;

@property (nonatomic, copy) NSString *scale;

/**
 *   经度
 */
@property (nonatomic, strong) NSNumber *longitude;

/**
 *  纬度
 */
@property (nonatomic, strong) NSNumber *latitude;

@end
