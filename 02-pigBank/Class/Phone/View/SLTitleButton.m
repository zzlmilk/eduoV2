//
//  SLTitleButton.m
//  02-pigBank
//
//  Created by 陆承东 on 14-9-16.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLTitleButton.h"
#import "UIImage+S_LINE.h"

#define imageViewWidth 20

@implementation SLTitleButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        // 设置image的内容模式
        self.imageView.contentMode = UIViewContentModeCenter;
        // 高亮时自动调整图片:还有adjustsImageWhenDisable(Disable时自动调整图片)
        self.adjustsImageWhenHighlighted = NO;
        // 设置文字居中
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        // 设置文字颜色
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        // 设置高亮时的背景颜色
        [self setBackgroundImage:[UIImage resizableImageWithImageName:@"navigationbar_button_background_pushed"] forState:UIControlStateHighlighted];
        
    }
    return self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageY = 0;
    CGFloat imageW = imageViewWidth;
    CGFloat imageX = self.frame.size.width - imageW;
    CGFloat imageH = self.frame.size.height;
    return CGRectMake(imageX, imageY, imageW, imageH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleX = 0;
    CGFloat titleY = 0;
    CGFloat titleW = self.frame.size.width - imageViewWidth;
    CGFloat titleH = self.frame.size.height;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
