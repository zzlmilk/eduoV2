//
//  SLSwitchButtonView.m
//  02-pigBank
//
//  Created by 陆承东 on 15/1/19.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import "SLSwitchButtonView.h"

#import "UIImage+S_LINE.h"

@interface SLSwitchButtonView ()

@property (nonatomic, weak) UIButton *leftButton;
@property (nonatomic, weak) UIButton *rightButton;



@end

@implementation SLSwitchButtonView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        /** 左侧按钮 */
        UIButton *leftButton = [[UIButton alloc] init];
        [self addSubview:leftButton];
        self.leftButton = leftButton;
        
        /** 右侧按钮 */
        UIButton *rightButton = [[UIButton alloc] init];
        [self addSubview:rightButton];
        self.rightButton = rightButton;
        
        [self setSubviewsData];
        
        [self leftButtonClick:self.leftButton];
    }
    return self;
}

- (void)setSubviewsData
{
    CGFloat viewW = [UIScreen mainScreen].bounds.size.width;
    
    CGFloat buttonW = 150;
    CGFloat buttonH = 30;
    CGFloat buttonY = smallMargin;
    CGFloat leftButtonX = viewW * 0.5 - buttonW;
    CGFloat rightButtonX = viewW * 0.5;
    self.leftButton.frame = CGRectMake(leftButtonX, buttonY, buttonW, buttonH);
    self.rightButton.frame = CGRectMake(rightButtonX, buttonY, buttonW, buttonH);
    
    CGFloat viewH = CGRectGetMaxY(self.leftButton.frame) + smallMargin;
    self.bounds = CGRectMake(0, 0, viewW, viewH);
    
    CGFloat separatorViewW = viewW;
    CGFloat separatorViewH = 0.5;
    CGFloat separatorViewX = 0;
    CGFloat separatorViewY = viewH - separatorViewH;
    CGRect separatorViewF = CGRectMake(separatorViewX, separatorViewY, separatorViewW, separatorViewH);
    UIView *separatorView = [[UIView alloc] initWithFrame:separatorViewF];
    separatorView.backgroundColor = SLLightGray;
    [self addSubview:separatorView];
    
    /** 设置leftButton数据 */
    [self.leftButton setTitle:@"左侧按钮" forState:UIControlStateNormal];
#warning 设置颜色
    [self.leftButton setTitleColor:SLRed forState:UIControlStateNormal];
    [self.leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.leftButton setBackgroundImage:[UIImage resizableImageWithImageName:@"icon_button_left_normal"] forState:UIControlStateNormal];
    [self.leftButton setBackgroundImage:[UIImage resizableImageWithImageName:@"icon_button_left_selected"] forState:UIControlStateSelected];
    [self.leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchDown];
    
    /** 设置rightButton数据 */
    [self.rightButton setTitle:@"右侧按钮" forState:UIControlStateNormal];
#warning 设置颜色
    [self.rightButton setTitleColor:SLRed forState:UIControlStateNormal];
    [self.rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.rightButton setBackgroundImage:[UIImage resizableImageWithImageName:@"icon_button_right_normal"] forState:UIControlStateNormal];
    [self.rightButton setBackgroundImage:[UIImage resizableImageWithImageName:@"icon_button_right_selected"] forState:UIControlStateSelected];
    [self.rightButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchDown];
}

#pragma mark ----- leftButton点击事件
- (void)leftButtonClick:(UIButton *)leftButton
{
    self.rightButton.selected = NO;
    self.leftButton.selected = YES;
    
    if ([self.delegate respondsToSelector:@selector(switchButtonView:didClickLeftButton:)]) {
        [self.delegate switchButtonView:self didClickLeftButton:leftButton];
    }
}

#pragma mark ----- rightButton点击事件
- (void)rightButtonClick:(UIButton *)rightButton
{
    self.leftButton.selected = NO;
    self.rightButton.selected = YES;
    
    if ([self.delegate respondsToSelector:@selector(switchButtonView:didClickRightButton:)]) {
        [self.delegate switchButtonView:self didClickRightButton:rightButton];
    }
}

#pragma mark ----- 设置左右按钮的title,采用默认颜色
- (void)setLeftTitle:(NSString *)leftTitle rightTitle:(NSString *)rightTitle
{
    [self.leftButton setTitle:leftTitle forState:UIControlStateNormal];
    [self.rightButton setTitle:rightTitle forState:UIControlStateNormal];
}

#pragma mark ----- 设置左边按钮的title属性
- (void)setLeftTitle:(NSString *)title titleColor:(UIColor *)color titleSelectedColor:(UIColor *)selectedColor
{
    [self.leftButton setTitle:title forState:UIControlStateNormal];
    [self.leftButton setTitleColor:color forState:UIControlStateNormal];
    [self.leftButton setTitleColor:selectedColor forState:UIControlStateSelected];
}

#pragma mark ----- 设置右边按钮的title属性
- (void)setRightTitle:(NSString *)title titleColor:(UIColor *)color titleSelectedColor:(UIColor *)selectedColor
{
    [self.rightButton setTitle:title forState:UIControlStateNormal];
    [self.rightButton setTitleColor:color forState:UIControlStateNormal];
    [self.rightButton setTitleColor:selectedColor forState:UIControlStateSelected];
}

#pragma mark ----- 设置两边按钮的image属性
- (void)setLeftButtonImage:(NSString *)leftButtonImageName leftButtonSelectedImage:(NSString *)leftButtonSelectedImageName rightButtonImage:(NSString *)rightButtonImageName rightButtonSelectedImage:(NSString *)rightButtonSelectedImageName
{
    [self.leftButton setBackgroundImage:[UIImage resizableImageWithImageName:leftButtonImageName] forState:UIControlStateNormal];
    [self.leftButton setBackgroundImage:[UIImage resizableImageWithImageName:leftButtonSelectedImageName] forState:UIControlStateSelected];
    
    [self.rightButton setBackgroundImage:[UIImage resizableImageWithImageName:rightButtonImageName] forState:UIControlStateNormal];
    [self.rightButton setBackgroundImage:[UIImage resizableImageWithImageName:rightButtonSelectedImageName] forState:UIControlStateSelected];
}

@end
