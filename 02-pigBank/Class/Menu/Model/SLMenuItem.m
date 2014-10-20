//
//  SLMenuItem.m
//  02-pigBank
//
//  Created by 陆承东 on 14-9-25.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLMenuItem.h"

@implementation SLMenuItem

+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title
{
    SLMenuItem *item = [self item];
    item.icon = icon;
    item.title = title;
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title
{
    return [self itemWithIcon:nil title:title];
}

+ (instancetype)item
{
    return [[self alloc] init];
}

@end
