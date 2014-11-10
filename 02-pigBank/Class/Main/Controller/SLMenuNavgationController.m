//
//  SLMenuNavgationController.m
//  02-pigBank
//
//  Created by 陆承东 on 14/10/27.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLMenuNavgationController.h"

#import "UIBarButtonItem+SL.h"

@interface SLMenuNavgationController ()

@end

@implementation SLMenuNavgationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"iconMore"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"iconMorePress"] forState:UIControlStateHighlighted];
    button.frame = CGRectMake(0, 0, button.currentImage.size.width, button.currentImage.size.height);
    [button addTarget:self action:@selector(more:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    self.navigationItem.leftBarButtonItem = item;
    SLLog(@"-------%@---------", self.navigationItem.leftBarButtonItem);
}

/**
 *  第一次调用这个类时会调用,1个类只会调用一次
 */
+ (void)initialize
{
    // 设置导航栏主题
//    [self setupNavBarTheme];
}

+ (void)setupNavBarTheme
{
    // 取出appearance
    UINavigationBar *navBar = [UINavigationBar appearance];
    
    
}

- (void)more:(id)sender
{
    [self.drawer open];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ICSDrawerControllerPresenting

- (void)drawerControllerWillOpen:(ICSDrawerController *)drawerController
{
    self.view.userInteractionEnabled = NO;
}

- (void)drawerControllerDidOpen:(ICSDrawerController *)drawerController
{
    self.view.userInteractionEnabled = YES;
}

- (void)drawerControllerWillClose:(ICSDrawerController *)drawerController
{
    self.view.userInteractionEnabled = NO;
}

- (void)drawerControllerDidClose:(ICSDrawerController *)drawerController
{
    self.view.userInteractionEnabled = YES;
}

@end