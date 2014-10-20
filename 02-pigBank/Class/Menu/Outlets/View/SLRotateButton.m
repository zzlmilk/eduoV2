//
//  SLRotateButton.m
//  02-pigBank
//
//  Created by 陆承东 on 14-10-16.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLRotateButton.h"

#import "UIImage+S_LINE.h"

#define SLRotateButtonImageW 20

@implementation SLRotateButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.font = [UIFont boldSystemFontOfSize:19];
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentRight;
        self.contentMode = UIViewContentModeCenter;
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
//    CGFloat imageY = 0;
//    CGFloat imageW = SLRotateButtonImageW;
//    CGFloat imageX = contentRect.size.width - imageW - 30;
//    CGFloat imageH = contentRect.size.height;
    CGFloat imageY = 0;
    CGFloat imageW = 20;
    CGFloat imageX = 110;
    CGFloat imageH = contentRect.size.height;
    return CGRectMake(imageX, imageY, imageW, imageH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
//    CGFloat titleY = 0;
//    CGFloat titleX = 30;
//    CGFloat titleW = contentRect.size.width - SLRotateButtonImageW - 30;
//    CGFloat titleH = contentRect.size.height;
    CGFloat titleY = 0;
    CGFloat titleX = 30;
    CGFloat titleW = 80;
    CGFloat titleH = contentRect.size.height;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

@end
