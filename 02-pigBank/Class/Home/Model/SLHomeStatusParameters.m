//
//  SLHomeStatusParameters.m
//  02-pigBank
//
//  Created by 陆承东 on 14-10-11.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLHomeStatusParameters.h"

@implementation SLHomeStatusParameters

- (NSNumber *)pageSize
{
    return _pageSize ? _pageSize : @20;
}

- (NSNumber *)curPage
{
    return _curPage ? _curPage : @1;
}

- (NSString *)search
{
    return _search ? _search : @"";
}

@end
