//
//  SLAddNewTagParameters.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/26.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

/*
 userId	Long
 tagName	String
 */

#import "SLBaseParameters.h"

@interface SLAddNewTagParameters : SLBaseParameters

@property (nonatomic, copy) NSString *tagName;
@property (nonatomic, strong) NSNumber *userId;

@end
