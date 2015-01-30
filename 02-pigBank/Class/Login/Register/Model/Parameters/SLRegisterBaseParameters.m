//
//  SLRegisterBaseParameters.m
//  02-pigBank
//
//  Created by 陆承东 on 15/1/20.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import "SLRegisterBaseParameters.h"

@implementation SLRegisterBaseParameters

- (id)init
{
    if (self = [super init]) {
        self.appCode = @"VIP_IOS";
    }
    return self;
}

+ (instancetype)parameters
{
    return [[self alloc] init];
}

@end
