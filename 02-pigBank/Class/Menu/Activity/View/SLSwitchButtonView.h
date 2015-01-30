//
//  SLSwitchButtonView.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/19.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SLSwitchButtonView;

@protocol SLSwitchButtonViewDelegate <NSObject>

@optional
- (void)switchButtonView:(SLSwitchButtonView *)switchButtonView didClickLeftButton:(UIButton *)leftButton;
- (void)switchButtonView:(SLSwitchButtonView *)switchButtonView didClickRightButton:(UIButton *)rightButton;

@end

@interface SLSwitchButtonView : UIView

@property (nonatomic, weak) id<SLSwitchButtonViewDelegate> delegate;

#pragma mark ----- 属性设置方法
- (void)setLeftTitle:(NSString *)leftTitle rightTitle:(NSString *)rightTitle;
- (void)setLeftTitle:(NSString *)title titleColor:(UIColor *)color titleSelectedColor:(UIColor *)selectedColor;
- (void)setRightTitle:(NSString *)title titleColor:(UIColor *)color titleSelectedColor:(UIColor *)selectedColor;

- (void)setLeftButtonImage:(NSString *)leftButtonImageName leftButtonSelectedImage:(NSString *)leftButtonSelectedImageName rightButtonImage:(NSString *)rightButtonImageName rightButtonSelectedImage:(NSString *)rightButtonSelectedImageName;

@end
