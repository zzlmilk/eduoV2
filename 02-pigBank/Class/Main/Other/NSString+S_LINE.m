//
//  NSString+S_LINE.m
//  01-猪子聊天界面
//
//  Created by 孙书杰 on 14-8-16.
//  Copyright (c) 2014年 孙书杰. All rights reserved.
//

#import "NSString+S_LINE.h"
#import <CommonCrypto/CommonDigest.h>

static NSString *token = @"fashfkdashfjkldashfjkdashfjkdahsfjdasjkvcxnm%^&%^$&^uireqwyi1237281643";

@implementation NSString (S_LINE)


// 计算字符串的rect
-(CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:[[NSMutableParagraphStyle alloc]init]};
        CGRect sizeFrame = [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
        CGFloat width = sizeFrame.size.width;
        CGFloat height = sizeFrame.size.height;
        return CGSizeMake(width, height);
    } else {
        CGSize size = [self sizeWithFont:font constrainedToSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
        return size;
    }
}

- (NSString *)myMD5
{
    NSString *str = [NSString stringWithFormat:@"%@%@", self, token];
    
    return [str MD5];
}

#pragma mark 使用MD5加密字符串
- (NSString *)MD5
{
    const char *cStr = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(cStr, strlen(cStr), digest);
    
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    
    return result;
}

#pragma mark 使用SHA1加密字符串
- (NSString *)SHA1
{
    const char *cStr = [self UTF8String];
    NSData *data = [NSData dataWithBytes:cStr length:self.length];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, data.length, digest);
    
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    
    return result;
}

@end
