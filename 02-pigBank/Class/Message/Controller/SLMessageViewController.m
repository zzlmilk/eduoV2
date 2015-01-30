//
//  SLMessageViewController.m
//  02-pigBank
//
//  Created by 陆承东 on 14-9-13.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLMessageViewController.h"

#import "SLSearchBar.h"
#import "SLBackButton.h"

#import "SLChatViewController.h"

#import "UIBarButtonItem+SL.h"

@interface SLMessageViewController ()

@property (nonatomic, assign) CGFloat tabbarFrameY;

@property (nonatomic, assign) BOOL flag;

@end

@implementation SLMessageViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setNavBar];
}

#pragma mark ----- setNavBar设置导航栏
- (void)setNavBar
{
    if ([self.from isEqualToString:@"toolBar"]) {
        SLBackButton *backButton = [SLBackButton button];
        [backButton addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        self.navigationItem.leftBarButtonItem = backItem;
    } else {
        CGRect tabbatFrame = self.tabBarController.tabBar.frame;
        self.tabbarFrameY = tabbatFrame.origin.y;
        tabbatFrame.origin.y += 49;
        
        [UIView animateWithDuration:0.5 animations:^{
            self.tabBarController.tabBar.frame = tabbatFrame;
        }];
        
        SLBackButton *backButton = [SLBackButton button];
        [backButton addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        self.navigationItem.leftBarButtonItem = backItem;
    }
}

#pragma mark ----- backButtonClicked返回按钮点击事件
- (void)backButtonClicked:(SLBackButton *)backButton
{
    if ([self.from isEqualToString:@"toolBar"]) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {if ([self.delegate respondsToSelector:@selector(messageViewController:didPopWithFlag:)]) {
        [self.delegate messageViewController:self didPopWithFlag:NO];
    }
        
        CGRect tabbatFrame = self.tabBarController.tabBar.frame;
        tabbatFrame.origin.y = self.tabbarFrameY;
        
        [UIView animateWithDuration:0.5 animations:^{
            self.tabBarController.tabBar.frame = tabbatFrame;
        }];
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
