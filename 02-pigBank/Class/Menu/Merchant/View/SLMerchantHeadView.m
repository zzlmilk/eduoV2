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
        [self addSubview:leftButton];
        self.leftButton = leftButton;
        
        /** rightButton 右按钮 */
        SLRotateButton *rightButton = [[SLRotateButton alloc] init];
        [self addSubview:rightButton];
        self.rightButton = rightButton;
        
        CGFloat viewW = [UIScreen mainScreen].bounds.size.width;
        
        CGFloat buttonW = 160;
        CGFloat buttonH = 40;
        CGFloat buttonY = 0;
        CGFloat serviceItemButtonX = 0;
        CGFloat serviceAreaButtonX = viewW * 0.5;
        self.leftButton.frame = CGRectMake(serviceItemButtonX, buttonY, buttonW, buttonH);
        self.rightButton.frame = CGRectMake(serviceAreaButtonX, buttonY, buttonW, buttonH);
        
        CGFloat viewH = buttonH;
        self.bounds = CGRectMake(0, 0, viewW, viewH);
    }
    return self;
}

- (void)setLeftButtonWithTitle:(NSString *)title imageName:(NSString *)image highlightImageName:(NSString *)highlightImage
{
    /** 设置leftButton数据 */
    [self.leftButton setTitle:title forState:UIControlStateNormal];
    [self.leftButton setTitleColor:SLColor(126, 33, 128) forState:UIControlStateNormal];
    [self.leftButton setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [self.leftButton setImage:[UIImage imageNamed:highlightImage] forState:UIControlStateSelected];
    // 背景
    //    [self.serviceItemButton setBackgroundImage:[UIImage resizableImageWithImageName:@"xian"] forState:UIControlStateNormal];
    [self.leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchDown];
}

- (void)leftButtonClick:(SLRotateButton *)leftButton
{
    SLLog(@"leftButton-------click");
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

- (void)setRightButtonWithTitle:(NSString *)title imageName:(NSString *)image highlightImageName:(NSString *)highlightImage
{
    /** 设置rightButton数据 */
    [self.rightButton setTitle:title forState:UIControlStateNormal];
    [self.rightButton setTitleColor:SLColor(126, 33, 128) forState:UIControlStateNormal];
    [self.rightButton setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [self.rightButton setImage:[UIImage imageNamed:highlightImage] forState:UIControlStateSelected];
    // 背景
    //    [self.serviceItemButton setBackgroundImage:[UIImage resizableImageWithImageName:@"xian"] forState:UIControlStateNormal];
    [self.rightButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchDown];
}

- (void)rightButtonClick:(SLRotateButton *)rightButton
{
    SLLog(@"rightButton-------click");
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

- (void)setLeftButtonWithTitle:(NSString *)title
{
    [self.leftButton setTitle:title forState:UIControlStateNormal];
}
- (void)setRightButtonWithTitle:(NSString *)title
{
    [self.rightButton setTitle:title forState:UIControlStateNormal];
}

- (void)setLeftButtonStatusNormal
{
    self.leftButton.selected = NO;
}
- (void)setRightButtonStatusNormal
{
    self.rightButton.selected = NO;
}

@end
