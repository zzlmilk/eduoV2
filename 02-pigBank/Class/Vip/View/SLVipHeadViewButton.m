//
//  SLVipHeadViewButton.m
//  02-pigBank
//
//  Created by 陆承东 on 14-9-21.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLVipHeadViewButton.h"
#define imageWH 43
#define margin 10

@implementation SLVipHeadViewButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return self;
}


- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageX = 0;
    CGFloat imageY = margin;
    CGFloat imageW = self.frame.size.width;
    CGFloat imageH = imageWH;
    return CGRectMake(imageX, imageY, imageW, imageH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleX = 0;
    CGFloat titleY = imageWH + margin;
    CGFloat titleW = self.frame.size.width;
    CGFloat titleH = self.frame.size.height - imageWH - margin;
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
