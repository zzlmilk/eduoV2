//
//  SLMerchantHeadView.h
//  02-pigBank
//
//  Created by 陆承东 on 14/10/20.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SLRotateButton.h"

@class SLMerchantHeadView;

@protocol SLMerchantHeadViewDelegate <NSObject>

@optional
- (void)merchantHeadView:(SLMerchantHeadView *)merchantHeadView didClickLeftButton:(SLRotateButton *)leftButton;
- (void)merchantHeadView:(SLMerchantHeadView *)merchantHeadView didClickRightButton:(SLRotateButton *)rightButton;

@end

@interface SLMerchantHeadView : UIView

- (void)setLeftButtonWithTitle:(NSString *)title imageName:(NSString *)image highlightImageName:(NSString *)highlightImage;
- (void)setRightButtonWithTitle:(NSString *)title imageName:(NSString *)image highlightImageName:(NSString *)highlightImage;

- (void)setLeftButtonWithTitle:(NSString *)title;
- (void)setRightButtonWithTitle:(NSString *)title;

- (void)setLeftButtonStatusNormal;
- (void)setRightButtonStatusNormal;

@property (nonatomic, weak) id<SLMerchantHeadViewDelegate> delegate;

@end
