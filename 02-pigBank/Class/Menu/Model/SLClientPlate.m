//
//  SLClientPlate.m
//  02-pigBank
//
//  Created by 陆承东 on 14-9-25.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLClientPlate.h"

@implementation SLClientPlate

/**
 *  从文件中解析对象时调用
 */
- (id)initWithCoder:(NSCoder *)aDecoder
{
    
    if (self = [super init]) {
        self.dispName = [aDecoder decodeObjectForKey:@"dispName"];
        self.newsCount = [aDecoder decodeIntegerForKey:@"newsCount"];
        self.pictureUrl = [aDecoder decodeObjectForKey:@"pictureUrl"];
        self.plateId = [aDecoder decodeIntegerForKey:@"plateId"];
        self.plateName = [aDecoder decodeObjectForKey:@"plateName"];
        self.plateSort = [aDecoder decodeIntegerForKey:@"plateSort"];
        self.plateType = [aDecoder decodeIntegerForKey:@"plateType"];
    }
    return self;
}

/**
 *  将对象写入文件时调用
 */
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.dispName forKey:@"dispName"];
    [aCoder encodeInteger:self.newsCount forKey:@"newsCount"];
    [aCoder encodeObject:self.pictureUrl forKey:@"pictureUrl"];
    [aCoder encodeInteger:self.plateId forKey:@"plateId"];
    [aCoder encodeObject:self.plateName forKey:@"plateName"];
    [aCoder encodeInteger:self.plateSort forKey:@"plateSort"];
    [aCoder encodeInteger:self.plateType forKey:@"plateType"];
}
#warning 接下来编写存储数据的tool
@end
