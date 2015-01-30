//
//  SLMerchantHeadView.m
//  02-pigBank
//
//  Created by 陆承东 on 14/10/20.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLMerchantHeadView.h"

@interface SLMerchantHeadView()

/** leftButton 左按钮 */
@property (nonatomic, weak) SLRotateButton *leftButton;
/** rightButton 右按钮 */
@property (nonatomic, weak) SLRotateButton *rightButton;

@end

@implementation SLMerchantHeadView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        /** leftButton 左按钮 */
        SLRotateButton *leftButton = [[SLRotateButton alloc] init];
#warning 设置颜色
        [leftButton setTitleColor:SLRed forState:UIControlStateNormal];
        leftButton.titleLabel.font = SLFont16;
        [leftButton setImage:[UIImage imageNamed:@"icon_button_down_normal"] forState:UIControlStateNormal];
        [leftButton setImage:[UIImage imageNamed:@"icon_button_up_selected"] forState:UIControlStateSelected];
        [leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchDown];
        [self addSubview:leftButton];
        self.leftButton = leftButton;
        
        /** rightButton 右按钮 */
        SLRotateButton *rightButton = [[SLRotateButton alloc] init];
#warning 设置颜色
        [rightButton setTitleColor:SLRed forState:UIControlStateNormal];
        rightButton.titleLabel.font = SLFont16;
        [rightButton setImage:[UIImage imageNamed:@"icon_button_down_normal"] forState:UIControlStateNormal];
        [rightButton setImage:[UIImage imageNamed:@"icon_button_up_selected"] forState:UIControlStateSelected];
        [rightButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchDown];
        [self addSubview:rightButton];
        self.rightButton = rightButton;
        
        CGFloat viewW = [UIScreen mainScreen].bounds.size.width;
        
        CGFloat buttonW = screenW * 0.5 - 0.5;
        CGFloat buttonH = 39.5;
        CGFloat buttonY = 0;
        CGFloat serviceItemButtonX = 0;
        CGFloat serviceAreaButtonX = screenW * 0.5;
        self.leftButton.frame = CGRectMake(serviceItemButtonX, buttonY, buttonW, buttonH);
        self.rightButton.frame = CGRectMake(serviceAreaButtonX, buttonY, buttonW, buttonH);
        
        CGFloat verticalSeparatorViewX = buttonW;
        CGFloat verticalSeparatorViewY = middleMargin;
        CGFloat verticalSeparatorViewW = 0.5;
        CGFloat verticalSeparatorViewH = 20;
        CGRect verticalSeparatorViewF = CGRectMake(verticalSeparatorViewX, verticalSeparatorViewY, verticalSeparatorViewW, verticalSeparatorViewH);
        UIView *verticalSeparatorView = [[UIView alloc] initWithFrame:verticalSeparatorViewF];
        verticalSeparatorView.backgroundColor = SLLightGray;
        [self addSubview:verticalSeparatorView];
        
        CGFloat separatorViewW = viewW;
        CGFloat separatorViewH = 0.5;
        CGFloat separatorViewX = 0;
        CGFloat separatorViewY = buttonH;
        CGRect separatorViewF = CGRectMake(separatorViewX, separatorViewY, separatorViewW, separatorViewH);
        UIView *separatorView = [[UIView alloc] initWithFrame:separatorViewF];
        separatorView.backgroundColor = SLLightGray;
        [self addSubview:separatorView];
        
        CGFloat viewH = buttonH + separatorViewH;
        self.bounds = CGRectMake(0, 0, viewW, viewH);
    }
    return self;
}

#pragma mark ----- 左右按钮的点击事件
- (void)leftButtonClick:(SLRotateButton *)leftButton
{
    if (leftButton.selected == YES) {
        leftButton.selected = NO;
    } else {
        leftButton.selected = YES;
        self.rightButton.selected = NO;
    }
    
    if ([self.delegate respondsToSelector:@selector(merchantHeadView:didClickLeftButton:)]) {
        [self.delegate merchantHeadView:self didClickLeftButton:leftButton];
    }
}

- (void)rightButtonClick:(SLRotateButton *)rightButton
{
    if (rightButton.selected == YES) {
        rightButton.selected = NO;
    } else {
        rightButton.selected = YES;
        self.leftButton.selected = NO;
    }
    
    if ([self.delegate respondsToSelector:@selector(merchantHeadView:didClickRightButton:)]) {
        [self.delegate merchantHeadView:self didClickRightButton:rightButton];
    }
}

#pragma mark ----- 定制左右按钮的背景图片
- (void)setLeftButtonWithTitle:(NSString *)title titleColot:(UIColor *)color imageName:(NSString *)image highlightImageName:(NSString *)highlightImage
{
    /** 设置leftButton数据 */
    [self.leftButton setTitle:title forState:UIControlStateNormal];
#warning 设置颜色
    [self.leftButton setTitleColor:color forState:UIControlStateNormal];
    [self.leftButton setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [self.leftButton setImage:[UIImage imageNamed:highlightImage] forState:UIControlStateSelected];
}

- (void)setRightButtonWithTitle:(NSString *)title titleColot:(UIColor *)color  imageName:(NSString *)image highlightImageName:(NSString *)highlightImage
{
    /** 设置rightButton数据 */
    [self.rightButton setTitle:title forState:UIControlStateNormal];
#warning 设置颜色
    [self.rightButton setTitleColor:color forState:UIControlStateNormal];
    [self.rightButton setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [self.rightButton setImage:[UIImage imageNamed:highlightImage] forState:UIControlStateSelected];
}

#pragma mark ----- 设置按钮title
- (void)setLeftButtonWithTitle:(NSString *)title
{
    [self.leftButton setTitle:title forState:UIControlStateNormal];
}
- (void)setRightButtonWithTitle:(NSString *)title
{
    [self.rightButton setTitle:title forState:UIControlStateNormal];
}
- (void)setLeftButtonTitle:(NSString *)leftTitle rightButtonTitle:(NSString *)rightTitle
{
    [self.leftButton setTitle:leftTitle forState:UIControlStateNormal];
    [self.rightButton setTitle:rightTitle forState:UIControlStateNormal];
}

#pragma mark ----- 设置按钮为普通状态
- (void)setLeftButtonStatusNormal
{
    self.leftButton.selected = NO;
}
- (void)setRightButtonStatusNormal
{
    self.rightButton.selected = NO;
}

@end
