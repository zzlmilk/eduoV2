//
//  SLActivitySignParameters.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/22.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

/*
 materialId [必填]	Long
 name[必填]	String
 mobile[必填]	String
 */

#import "SLBaseParameters.h"

@interface SLActivitySignParameters : SLBaseParameters

@property (nonatomic, strong) NSNumber *materialId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *mobile;

@end
