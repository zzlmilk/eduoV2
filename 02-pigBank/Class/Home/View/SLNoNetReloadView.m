//
//  SLNoNetReloadView.m
//  SLNoNetReloadView
//
//  Created by 陆承东 on 15/1/30.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import "SLNoNetReloadView.h"

@implementation SLNoNetReloadView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 添加所有子控件
        [self addSubViews];
    }
    return self;
}

- (void)addSubViews
{
    CGFloat hintLabelW = self.frame.size.width;
    CGFloat hintLabelH = 50;
    CGFloat hintLabelX = 0;
    CGFloat hintLabelY = self.center.y - hintLabelH;
    CGRect hintLabelF = CGRectMake(hintLabelX, hintLabelY, hintLabelW, hintLabelH);
    UILabel *hintLabel = [[UILabel alloc] initWithFrame:hintLabelF];
    hintLabel.textAlignment = NSTextAlignmentCenter;
    hintLabel.text = @"网络不给力哦,请稍后重试";
    hintLabel.font = [UIFont systemFontOfSize:14];
    hintLabel.textColor = [UIColor colorWithRed:156/255.0 green:156/255.0 blue:156/255.0 alpha:1.0];
    [self addSubview:hintLabel];
    
    CGFloat reloadButtonW = 70;
    CGFloat reloadButtonH = 30;
    CGRect reloadButtonB = CGRectMake(0, 0, reloadButtonW, reloadButtonH);
    UIButton *reloadButton = [[UIButton alloc] init];
    reloadButton.bounds = reloadButtonB;
    reloadButton.center = self.center;
    CGRect reloadButtonF = reloadButton.frame;
    reloadButtonF.origin.y = self.frame.size.height * 0.5;
    reloadButton.frame = reloadButtonF;
    [reloadButton setTitle:@"刷新看看" forState:UIControlStateNormal];
    [reloadButton setTitleColor:[UIColor colorWithRed:156/255.0 green:156/255.0 blue:156/255.0 alpha:1.0] forState:UIControlStateNormal];
    reloadButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [reloadButton setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0]];
    [reloadButton addTarget:self action:@selector(reloadButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:reloadButton];
}

#pragma mark ----- reloadButton点击事件
- (void)reloadButtonClick:(UIButton *)reloadButton
{
    if ([self.delegate respondsToSelector:@selector(noNetReloadView:didClickedReloadButton:)]) {
        [self.delegate noNetReloadView:self didClickedReloadButton:reloadButton];
    }
}

@end
