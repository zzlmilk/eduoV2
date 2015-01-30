//
//  SLNoNetReloadView.h
//  SLNoNetReloadView
//
//  Created by 陆承东 on 15/1/30.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SLNoNetReloadView;

@protocol SLNoNetReloadViewDelegate <NSObject>

@optional
- (void)noNetReloadView:(SLNoNetReloadView *)noNetReloadView didClickedReloadButton:(UIButton *)reloadButton;

@end

@interface SLNoNetReloadView : UIView

@property (nonatomic, weak) id<SLNoNetReloadViewDelegate> delegate;

@end
