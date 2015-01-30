//
//  SLManageHeadView.m
//  02-pigBank
//
//  Created by 陆承东 on 15/1/28.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import "SLManageHeadView.h"

@interface SLManageHeadView ()

@property (nonatomic, strong) UIButton *selectedButton;

@end

@implementation SLManageHeadView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat buttonWidth = frame.size.width / 4 - 0.5;
        CGFloat buttonHeight = frame.size.height;
        
        for (int i = 0; i < 4; i++) {
            CGFloat buttonX = (buttonWidth + 0.5) * i;
            CGFloat buttonY = 0;
            CGFloat buttonW = buttonWidth;
            CGFloat buttonH = buttonHeight;
            CGRect buttonF = CGRectMake(buttonX, buttonY, buttonW, buttonH);
            UIButton *button = [[UIButton alloc] initWithFrame:buttonF];
            button.tag = i;
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [button setTitleColor:SLBlack forState:UIControlStateNormal];
            [button setTitleColor:SLRed forState:UIControlStateSelected];
            button.titleLabel.font = SLFont14;
            if (i == 0) {
                button.selected = YES;
                self.selectedButton = button;
            }
            if (i == 0) {
                [button setTitle:@"已查看人" forState:UIControlStateNormal];
            } else if (i == 1) {
                [button setTitle:@"已赞" forState:UIControlStateNormal];
            } else if (i == 2) {
                [button setTitle:@"已收藏" forState:UIControlStateNormal];
            } else if (i == 3) {
                [button setTitle:@"未查看人" forState:UIControlStateNormal];
            }
            [self addSubview:button];
            
            if (i > 0) {
                CGFloat separatorViewX = buttonW * i;
                CGFloat separatorViewY = middleMargin;
                CGFloat separatorViewW = 0.5;
                CGFloat separatorViewH = buttonH - largeMargin;
                CGRect separatorF = CGRectMake(separatorViewX, separatorViewY, separatorViewW, separatorViewH);
                UIView *separatorView = [[UIView alloc] initWithFrame:separatorF];
                separatorView.backgroundColor = SLLightGray;
                [self addSubview:separatorView];
            }
        }
        
        UIView *bottomSeparator = [[UIView alloc] initWithFrame:CGRectMake(0, buttonHeight - 0.5, frame.size.width, 0.5)];
        bottomSeparator.backgroundColor = SLLightGray;
        [self addSubview: bottomSeparator];
    }
    return self;
}

#pragma mark ----- 左右按钮的点击事件
- (void)buttonClick:(UIButton *)button
{
    if (button.tag == 0) {
        if ([self.delegate respondsToSelector:@selector(manageHeadView:didClickedFirstButton:)]) {
            [self.delegate manageHeadView:self didClickedFirstButton:button];
        }
    } else if (button.tag == 1) {
        if ([self.delegate respondsToSelector:@selector(manageHeadView:didClickedSecondButton:)]) {
            [self.delegate manageHeadView:self didClickedSecondButton:button];
        }
    } else if (button.tag == 2) {
        if ([self.delegate respondsToSelector:@selector(manageHeadView:didClickedThirdButton:)]) {
            [self.delegate manageHeadView:self didClickedThirdButton:button];
        }
    } else if (button.tag == 3) {
        if ([self.delegate respondsToSelector:@selector(manageHeadView:didClickedforthButton:)]) {
            [self.delegate manageHeadView:self didClickedforthButton:button];
        }
    }
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
}

@end
