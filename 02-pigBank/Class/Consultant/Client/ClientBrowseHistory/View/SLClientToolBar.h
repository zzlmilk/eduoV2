//
//  SLClientToolBar.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/21.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SLTabBarButton.h"

@class SLClientToolBar;

@protocol SLClientToolBarDelegate <NSObject>

@optional
- (void)clientToolBar:(SLClientToolBar *)clientToolBar didClickedLeftButton:(SLTabBarButton *)leftButton;
- (void)clientToolBar:(SLClientToolBar *)clientToolBar didClickedRightButton:(SLTabBarButton *)rightButton;

@end

@interface SLClientToolBar : UIView

@property (nonatomic, weak) id<SLClientToolBarDelegate> delegate;

- (void)setLeftButtonTitle:(NSString *)leftButtonTitle image:(NSString *)imageName;
- (void)setRightButtonTitle:(NSString *)rightButtonTitle image:(NSString *)imageName;

@end
