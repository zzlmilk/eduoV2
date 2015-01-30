//
//  SLRightImageButton.m
//  02-pigBank
//
//  Created by 陆承东 on 15/1/24.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import "SLRightImageButton.h"

@implementation SLRightImageButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.font = SLFont14;
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        self.titleLabel.contentMode = UIViewContentModeCenter;
        self.titleLabel.numberOfLines = 0;
        self.imageView.contentMode = UIViewContentModeCenter;
        self.contentMode = UIViewContentModeCenter;
    }
    return self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageY = 0;
    CGFloat imageW = 60;
    CGFloat imageX = contentRect.size.width - imageW;
    CGFloat imageH = contentRect.size.height;
    return CGRectMake(imageX, imageY, imageW, imageH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleY = 0;
    CGFloat titleX = middleMargin;
    CGFloat titleW = contentRect.size.width - 60;
    CGFloat titleH = contentRect.size.height;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

@end
