//
//  UIImage+S_LINE.h
//  01-猪子聊天界面
//
//  Created by 孙书杰 on 14-8-15.
//  Copyright (c) 2014年 孙书杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (S_LINE)

// 拉伸一张图片
+ (UIImage *)resizableImageWithImageName:(NSString *)name;

// 截图
+ (instancetype)captureWithView:(UIView *)view;

// 切图
+ (instancetype)clipImageWithName:(NSString *)imageName borderWidth:(CGFloat)border borderColor:(UIColor *)BorderColor;

// 添加水印
+ (instancetype)waterImageWithBackGround:(NSString *)background andWater:(NSString *)water;

@end
