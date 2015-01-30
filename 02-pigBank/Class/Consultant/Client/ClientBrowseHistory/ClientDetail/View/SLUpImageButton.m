//
//  SLUpImageButton.m
//  02-pigBank
//
//  Created by 陆承东 on 15/1/24.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import "SLUpImageButton.h"

@implementation SLUpImageButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.font = SLFont12;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.contentMode = UIViewContentModeCenter;
        self.imageView.contentMode = UIViewContentModeCenter;
        self.contentMode = UIViewContentModeCenter;
    }
    return self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageY = 0;
    CGFloat imageW = contentRect.size.width;
    CGFloat imageX = 0;
    CGFloat imageH = contentRect.size.height * 0.6;
    return CGRectMake(imageX, imageY, imageW, imageH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleY = contentRect.size.height * 0.6;
    CGFloat titleX = 0;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height - titleY;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

- (void)setHighlighted:(BOOL)highlighted
{

}

@end
