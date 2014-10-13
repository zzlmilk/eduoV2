//
//  SLAccountInfo.m
//  02-pigBank
//
//  Created by 陆承东 on 14-9-26.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLAccountInfo.h"

@implementation SLAccountInfo

/**
 *  从文件中解析对象时调用
 */
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.dispName = [aDecoder decodeObjectForKey:@"dispName"];
        self.mobile = [aDecoder decodeObjectForKey:@"mobile"];
        self.vipDetail = [aDecoder decodeObjectForKey:@"vipDetail"];
    }
    return self;
}

/**
 *  将对象写入文件时调用
 */
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.dispName forKey:@"dispName"];
    [aCoder encodeObject:self.mobile forKey:@"mobile"];
    [aCoder encodeObject:self.vipDetail forKey:@"vipDetail"];
}

@end
