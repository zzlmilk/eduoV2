//
//  SLConsultant.m
//  02-pigBank
//
//  Created by 陆承东 on 14-9-29.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLConsultant.h"

@implementation SLConsultant

/**
 *  从文件中解析对象时调用
 */
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.dispName = [aDecoder decodeObjectForKey:@"dispName"];
        self.email = [aDecoder decodeObjectForKey:@"email"];
        self.mobile = [aDecoder decodeObjectForKey:@"mobile"];
        self.pictureSmallUrl = [aDecoder decodeObjectForKey:@"pictureSmallUrl"];
        self.pictureUrl = [aDecoder decodeObjectForKey:@"pictureUrl"];
    }
    return self;
}

/**
 *  将对象写入文件时调用
 */
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.dispName forKey:@"dispName"];
    [aCoder encodeObject:self.email forKey:@"email"];
    [aCoder encodeObject:self.mobile forKey:@"mobile"];
    [aCoder encodeObject:self.pictureSmallUrl forKey:@"pictureSmallUrl"];
    [aCoder encodeObject:self.pictureUrl forKey:@"pictureUrl"];
}

@end
