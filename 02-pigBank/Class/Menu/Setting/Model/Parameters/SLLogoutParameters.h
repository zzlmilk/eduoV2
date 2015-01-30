//
//  SLLogoutParameters.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/27.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

/*
 appCode	String
 clientInfo	String
 deviceInfo	String
 */

#import "SLBaseParameters.h"

@interface SLLogoutParameters : SLBaseParameters

@property (nonatomic, copy) NSString *appCode;
@property (nonatomic, copy) NSString *clientInfo;
@property (nonatomic, copy) NSString *deviceInfo;

@end
