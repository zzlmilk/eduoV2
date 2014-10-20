//
//  SLMerchantParameters.h
//  02-pigBank
//
//  Created by 陆承东 on 14-10-17.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

/*
 scopeId	Long	商户业务范围（行业）ID
 areaId	Long	商户分区ID
 longitude	Double
 latitude	Double
 */

#import "SLHomeStatusParameters.h"

@interface SLMerchantParameters : SLHomeStatusParameters

/** scopeId */
@property (nonatomic, strong) NSNumber *scopeId;

/** areaId */
@property (nonatomic, strong) NSNumber *areaId;

/** longitude */
@property (nonatomic, strong) NSNumber *longitude;

/** latitude */
@property (nonatomic, strong) NSNumber *latitude;

@end
