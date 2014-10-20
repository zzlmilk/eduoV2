//
//  SLOutletsParameters.h
//  02-pigBank
//
//  Created by 陆承东 on 14-10-16.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLHomeStatusParameters.h"

@interface SLOutletsParameters : SLHomeStatusParameters

/*
 plateId	Long
 outletsArea	Long
 serviceType	String
 longitude	Double
 latitude	Double
 */

/** plateId */
@property (nonatomic, strong) NSNumber *plateId;

/** outletsArea */
@property (nonatomic, strong) NSNumber *outletsArea;

/** serviceType */
@property (nonatomic, copy) NSString *serviceType;

/** longitude */
@property (nonatomic, strong) NSNumber *longitude;

/** latitude */
@property (nonatomic, strong) NSNumber *latitude;

@end
