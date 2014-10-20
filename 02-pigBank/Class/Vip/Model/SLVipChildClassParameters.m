//
//  SLVipChildClassParameters.m
//  02-pigBank
//
//  Created by 陆承东 on 14-10-14.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLVipChildClassParameters.h"

@implementation SLVipChildClassParameters

- (NSString *)scale
{
    if (_scale == nil) {
        _scale = @"1";
    }
    return _scale;
}

@end
