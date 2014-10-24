//
//  SLMerchantDetailGroup.m
//  02-pigBank
//
//  Created by 陆承东 on 14/10/23.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLMerchantDetailGroup.h"

@implementation SLMerchantDetailGroup

- (id)init
{
    if (self = [super init]) {
    }
    return self;
}

- (NSMutableArray *)merchantDetailItems
{
    if (_merchantDetailItems == nil) {
        _merchantDetailItems = [NSMutableArray array];
    }
    return _merchantDetailItems;
}

@end
