//
//  SLClientTagListParameters.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/26.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

/*
 userId	Long
 search	String
 */

#import "SLBaseParameters.h"

@interface SLClientTagListParameters : SLBaseParameters

@property (nonatomic, strong) NSNumber *userId;
@property (nonatomic, copy) NSString *search;

@end
