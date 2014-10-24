//
//  SLMerchantDetailItem.m
//  02-pigBank
//
//  Created by 陆承东 on 14/10/23.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLMerchantDetailItem.h"

@implementation SLMerchantDetailItem

+ (instancetype)itemWithMerchantDetail:(SLMerchantDetailFrame *)merchantDetailFrame andCellClass:(Class)cellClass
{
    SLMerchantDetailItem *item = [self item];
    item.merchantDetailFrame = merchantDetailFrame;
    item.cellClass = cellClass;
    return item;
}

+ (instancetype)item
{
    return [[self alloc] init];
}

@end
