//
//  SLManageHeadView.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/28.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SLRotateButton.h"

@class SLManageHeadView;

@protocol SLManageHeadViewDelegate <NSObject>

@optional
- (void)manageHeadView:(SLManageHeadView *)manageHeadView didClickedFirstButton:(UIButton *)firstButton;
- (void)manageHeadView:(SLManageHeadView *)manageHeadView didClickedSecondButton:(UIButton *)secondButton;
- (void)manageHeadView:(SLManageHeadView *)manageHeadView didClickedThirdButton:(UIButton *)thirdButton;
- (void)manageHeadView:(SLManageHeadView *)manageHeadView didClickedforthButton:(UIButton *)forthButton;

@end

@interface SLManageHeadView : UIView

@property (nonatomic, weak) id<SLManageHeadViewDelegate> delegate;

@end
