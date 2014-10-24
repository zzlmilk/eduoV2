//
//  SLMerchantDetailPatameters.h
//  02-pigBank
//
//  Created by 陆承东 on 14/10/22.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

/*
 merchantId	Long	商户ID
 longitude	Double	用户坐标-经度,为空数据距离为0
 latitude	Double	用户坐标-纬度,为空数据距离为0
 */

#import "SLBaseParameters.h"

@interface SLMerchantDetailPatameters : SLBaseParameters

/** merchantId */
@property (nonatomic, strong) NSNumber *merchantId;

/** longitude */
@property (nonatomic, strong) NSNumber *longitude;

/** latitude */
@property (nonatomic, strong) NSNumber *latitude;

@end
