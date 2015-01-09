//
//  NSString+S_LINE.h
//  01-猪子聊天界面
//
//  Created by 孙书杰 on 14-8-16.
//  Copyright (c) 2014年 孙书杰. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@interface NSString (S_LINE)

// 计算字符串的rect
-(CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

- (NSString *)myMD5;

/**
 *  32位MD5加密
 *
 *  @return 32位MD5加密结果
 */
- (NSString *)MD5;

/**
 *  SHA1加密
 *
 *  @return SHA1加密结果
 */
- (NSString *)SHA1;

@end
