//
//  SLVipDetail.m
//  02-pigBank
//
//  Created by 陆承东 on 14-9-29.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLVipDetail.h"

@implementation SLVipDetail

/**
 *  从文件中解析对象时调用
 */
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.userConsultant = [aDecoder decodeInt32ForKey:@"userConsultant"];
    }
    return self;
}

/**
 *  将对象写入文件时调用
 */
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeInt32:self.userConsultant forKey:@"userConsultant"];
}

@end
