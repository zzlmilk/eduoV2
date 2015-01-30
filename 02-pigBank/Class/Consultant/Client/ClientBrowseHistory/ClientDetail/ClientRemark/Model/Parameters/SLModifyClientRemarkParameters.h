//
//  SLModifyClientRemarkParameters.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/24.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

/*
 userId	Long
 remarkName	String
 remark	String
 */

#import "SLBaseParameters.h"

@interface SLModifyClientRemarkParameters : SLBaseParameters

@property (nonatomic, strong) NSNumber *userId;
@property (nonatomic, copy) NSString *remarkName;
@property (nonatomic, copy) NSString *remark;

@end
