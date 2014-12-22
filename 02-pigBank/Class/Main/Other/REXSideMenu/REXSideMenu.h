//
//  REXSIdeMenu.h
//  BankYiDou
//
//  Created by zzlmilk on 14-5-23.
//  Copyright (c) 2014年 zzlmilk. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "BaseNavigationController.h"
//#import "Clients.h"
@protocol REXSideMenuDelegate;

@interface REXSideMenu : UIViewController<UIGestureRecognizerDelegate>

//@property (nonatomic, strong) Clients *_client;

@property (strong, readwrite, nonatomic) UIViewController *contentViewController;
@property (strong, readwrite, nonatomic) UIViewController *leftMenuViewController;
@property (strong, readwrite, nonatomic) UIViewController *rightMenuViewController;
@property (weak, readwrite, nonatomic) id<REXSideMenuDelegate> delegate;

@property (assign, readwrite, nonatomic) NSTimeInterval animationDuration;
@property (strong, readwrite, nonatomic) UIImage *backgroundImage;
@property (assign, readwrite, nonatomic) BOOL panGestureEnabled;
@property (assign, readwrite, nonatomic) BOOL panFromEdge;
@property (assign, readwrite, nonatomic) NSUInteger panMinimumOpenThreshold;
@property (assign, readwrite, nonatomic) BOOL interactivePopGestureRecognizerEnabled;
@property (assign, readwrite, nonatomic) BOOL scaleContentView;
@property (assign, readwrite, nonatomic) BOOL scaleBackgroundImageView;
@property (assign, readwrite, nonatomic) BOOL scaleMenuView;
@property (assign, readwrite, nonatomic) BOOL contentViewShadowEnabled;
@property (strong, readwrite, nonatomic) UIColor *contentViewShadowColor;
@property (assign, readwrite, nonatomic) CGSize contentViewShadowOffset;
@property (assign, readwrite, nonatomic) CGFloat contentViewShadowOpacity;
@property (assign, readwrite, nonatomic) CGFloat contentViewShadowRadius;
@property (assign, readwrite, nonatomic) CGFloat contentViewScaleValue;
@property (assign, readwrite, nonatomic) CGFloat contentViewInLandscapeOffsetCenterX;
@property (assign, readwrite, nonatomic) CGFloat contentViewInPortraitOffsetCenterX;
@property (assign, readwrite, nonatomic) CGFloat parallaxMenuMinimumRelativeValue;
@property (assign, readwrite, nonatomic) CGFloat parallaxMenuMaximumRelativeValue;
@property (assign, readwrite, nonatomic) CGFloat parallaxContentMinimumRelativeValue;
@property (assign, readwrite, nonatomic) CGFloat parallaxContentMaximumRelativeValue;
@property (assign, readwrite, nonatomic) CGAffineTransform menuViewControllerTransformation;
@property (assign, readwrite, nonatomic) BOOL parallaxEnabled;
@property (assign, readwrite, nonatomic) BOOL bouncesHorizontally;
@property (assign, readwrite, nonatomic) UIStatusBarStyle menuPreferredStatusBarStyle;
@property (assign, readwrite, nonatomic) BOOL menuPrefersStatusBarHidden;

- (id)initWithContentViewController:(UIViewController *)contentViewController leftMenuViewController:(UIViewController *)leftMenuViewController rightMenuViewController:(UIViewController *)rightMenuViewController;
- (void)presentLeftMenuViewController;
- (void)presentRightMenuViewController;
- (void)hideMenuViewController;

- (void)setContentViewController:(UIViewController *)contentViewController animated:(BOOL)animated;

@end

@protocol REXSideMenuDelegate <NSObject>

@optional
- (void)sideMenu:(REXSideMenu *)sideMenu didRecognizePanGesture:(UIPanGestureRecognizer *)recognizer;
- (void)sideMenu:(REXSideMenu *)sideMenu willShowMenuViewController:(UIViewController *)menuViewController;
- (void)sideMenu:(REXSideMenu *)sideMenu didShowMenuViewController:(UIViewController *)menuViewController;
- (void)sideMenu:(REXSideMenu *)sideMenu willHideMenuViewController:(UIViewController *)menuViewController;
- (void)sideMenu:(REXSideMenu *)sideMenu didHideMenuViewController:(UIViewController *)menuViewController;

@end


