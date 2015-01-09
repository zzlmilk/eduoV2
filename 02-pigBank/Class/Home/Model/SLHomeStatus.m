//
//  SLHomeStatus.m
//  02-pigBank
//
//  Created by 陆承东 on 14-9-17.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLHomeStatus.h"

#import "MJExtension.h"

@implementation SLHomeStatus


/**
 *  从文件中解析对象时调用
 */
//- (id)initWithCoder:(NSCoder *)aDecoder
//{
//    if (self = [super init]) {
//        self.extPictureUrl = [aDecoder decodeObjectForKey:@"extPictureUrl"];
//        self.title = [aDecoder decodeObjectForKey:@"title"];
//        self.praiseCounts = [aDecoder decodeInt32ForKey:@"praiseCounts"];
//        self.templetType = [aDecoder decodeIntegerForKey:@"templetType"];
//        self.materialId = [aDecoder decodeInt32ForKey:@"materialId"];
//        self.verifyTime = [aDecoder decodeInt64ForKey:@"verifyTime"];
//        self.plateId = [aDecoder decodeInt32ForKey:@"plateId"];
//    }
//    return self;
//}
//
///**
// *  将对象写入文件时调用
// */
//- (void)encodeWithCoder:(NSCoder *)aCoder
//{
//    [aCoder encodeObject:self.extPictureUrl forKey:@"extPictureUrl"];
//    [aCoder encodeObject:self.title forKey:@"title"];
//    [aCoder encodeInt32:self.praiseCounts forKey:@"praiseCounts"];
//    [aCoder encodeInteger:self.templetType forKey:@"templetType"];
//    [aCoder encodeInt32:self.materialId forKey:@"materialId"];
//    [aCoder encodeInt64:self.verifyTime forKey:@"verifyTime"];
//    [aCoder encodeInt32:self.plateId forKey:@"plateId"];
//}

MJCodingImplementation
@end
