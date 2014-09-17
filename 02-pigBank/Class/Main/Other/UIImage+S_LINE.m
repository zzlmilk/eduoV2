//
//  UIImage+S_LINE.m
//  01-猪子聊天界面
//
//  Created by 孙书杰 on 14-8-15.
//  Copyright (c) 2014年 孙书杰. All rights reserved.
//

#import "UIImage+S_LINE.h"

@implementation UIImage (S_LINE)

// 拉伸一张图片
+ (UIImage *)resizableImageWithImageName:(NSString *)name
{
    UIImage *normal = [UIImage imageNamed:name];
    
    return [normal stretchableImageWithLeftCapWidth:normal.size.width * 0.5 topCapHeight:normal.size.height * 0.5];
    
//    CGFloat w = normal.size.width * 0.5;
//    CGFloat h = normal.size.height * 0.5;
//    
//    return [normal resizableImageWithCapInsets:UIEdgeInsetsMake(w, h, w, h)];
}

// 截图
+ (instancetype)captureWithView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 0.0);
    
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 结束上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}


// 切图
+ (instancetype)clipImageWithName:(NSString *)imageName borderWidth:(CGFloat)border borderColor:(UIColor *)BorderColor
{
    // 加载图片
    UIImage *oldImage = [UIImage imageNamed:imageName];
    
    // 创建上下文
    CGFloat imageW = oldImage.size.width + 2 * border;
    CGFloat imageH = oldImage.size.height + 2 * border;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(imageW, imageH), NO, 0.0);
    
    // 获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 画边框
    [BorderColor set];
    CGFloat bigradius = imageW * 0.5;
    CGFloat centerX = bigradius;
    CGFloat centerY = bigradius;
    CGContextAddArc(ctx, centerX, centerY, bigradius, 0, M_PI * 2, 0);
    CGContextFillPath(ctx);
    
    // 画切图圆
    [[UIColor redColor] set];
    CGFloat smallRadius = bigradius - border;
    CGContextAddArc(ctx, centerX, centerY, smallRadius, 0, M_PI * 2, 0);
    //    CGContextFillPath(ctx);
    CGContextClip(ctx);
    
    // 画图
    [oldImage drawInRect:CGRectMake(border, border, smallRadius * 2, smallRadius * 2)];
    
    // 取图
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 结束上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}


// 添加水印
+ (instancetype)waterImageWithBackGround:(NSString *)background andWater:(NSString *)water
{
    UIImage *bgImage = [UIImage imageNamed:background];
    
    // 1.创建一个基于位图的上下文
    UIGraphicsBeginImageContextWithOptions(bgImage.size, NO, 0.0);
    
    // 2.画背景
    [bgImage drawInRect:CGRectMake(0, 0, bgImage.size.width, bgImage.size.height)];
    
    // 3.画右下角水印
    UIImage *waterImage = [UIImage imageNamed:water];
    CGFloat margin = 10;
    CGFloat waterW = waterImage.size.width * 0.2;
    CGFloat waterH = waterImage.size.height * 0.2;
    CGFloat waterX = bgImage.size.width - margin - waterW;
    CGFloat waterY = bgImage.size.height - margin - waterH;
    [waterImage drawInRect:CGRectMake(waterX, waterY, waterW, waterH)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
