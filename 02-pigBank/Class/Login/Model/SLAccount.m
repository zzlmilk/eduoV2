//
//  SLAccount.m
//  02-pigBank
//
//  Created by 陆承东 on 14-9-16.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLAccount.h"

@implementation SLAccount

/**
 *  从文件中解析对象时调用
 */
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.code = [aDecoder decodeInt64ForKey:@"code"];
        self.accountInfo = [aDecoder decodeObjectForKey:@"accountInfo"];
        self.msg = [aDecoder decodeObjectForKey:@"msg"];
        self.time = [aDecoder decodeInt64ForKey:@"time"];
        self.token = [aDecoder decodeObjectForKey:@"token"];
        self.uid = [aDecoder decodeObjectForKey:@"uid"];
        self.expireTime = [aDecoder decodeObjectForKey:@"expireTime"];
    }
    return self;
}

/**
 *  将对象写入文件时调用
 */
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeInt64:self.code forKey:@"code"];
    [aCoder encodeObject:self.accountInfo forKey:@"accountInfo"];
    [aCoder encodeObject:self.msg forKey:@"msg"];
    [aCoder encodeInt64:self.time forKey:@"time"];
    [aCoder encodeObject:self.token forKey:@"token"];
    [aCoder encodeObject:self.uid forKey:@"uid"];
    [aCoder encodeObject:self.expireTime forKey:@"expireTime"];
}

@end
