//
//  SLTabBarController.m
//  02-pigBank
//
//  Created by 陆承东 on 14-9-12.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLTabBarController.h"

#import "SLHomeViewController.h"
#import "SLMessageViewController.h"
#import "SLPhoneViewController.h"
#import "SLVipViewController.h"
#import "SLTabBar.h"
#import "SLNavigationController.h"
#import "SLMoreViewController.h"
#import "SLMenuViewController.h"


@interface SLTabBarController () <SLTabBarDelegate, SLHomeViewControllerDelegate, SLVipViewControllerDelegate, SLMenuViewControllerDelegate>

@property (nonatomic, weak) SLTabBar *custom;

@end

@implementation SLTabBarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - 按钮的监听代理
- (void)tabBar:(SLTabBar *)tabBar didSelectedFrom:(int)from to:(int)to
{
    self.selectedIndex = to;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupTabBar];
    
    [self setupAllChildController];
}


- (void)viewWillAppear:(BOOL)animated
{
    
    SLLog(@"SLTabBarController----selectedIndexPath-----%lu", (unsigned long)self.selectedIndex);
    
    //    [self tabBar:self.custom didSelectedFrom:0 to:self.selectedIndex];
    
    self.selectedIndex = 1;
    
    [super viewWillAppear:animated];
    
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}

- (void)setupTabBar
{
    SLTabBar *custom = [[SLTabBar alloc] init];
    custom.frame = self.tabBar.bounds;
    [self.tabBar addSubview:custom];
    custom.delegate = self;
    
    self.custom = custom;
}

- (void)setupAllChildController
{
    // 首页
    SLHomeViewController *home = [[SLHomeViewController alloc] init];
    home.tabBarItem.badgeValue = @"1";
    home.delegate = self;
    [self setupChildController:home title:@"首页" imageName:@"iconHome" selectedImageName:@"iconHomePress"];
     
    // Vip
    SLVipViewController *vip = [[SLVipViewController alloc] init];
    vip.tabBarItem.badgeValue = @"11";
    vip.delegate = self;
    [self setupChildController:vip title:@"特权" imageName:@"iconVip" selectedImageName:@"iconVipPress"];
    
    // 消息
    SLMessageViewController *message = [[SLMessageViewController alloc] init];
    [self setupChildController:message title:@"消息" imageName:@"iconMessage" selectedImageName:@"iconMessagePress"];
    
    // Phone
//    SLPhoneViewController *phone = [[SLPhoneViewController alloc] init];
//    [self setupChildController:phone title:@"电联" imageName:@"iconPhone" selectedImageName:@"iconPhonePress"];
    
    // menu
    SLMenuViewController *menu = [[SLMenuViewController alloc] init];
    menu.delegate = self;
    [self setupChildController:menu title:@"电联" imageName:@"iconPhone" selectedImageName:@"iconPhonePress"];
    
}

- (void)setupChildController:(UIViewController *)controller title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    // 设置控制器的标题(这样设置可以同时设置导航控制器和tabbar的标题)
    controller.title = title;
    // 设置tabbar的image
    controller.tabBarItem.image = [UIImage imageNamed:imageName];
    // 设置tabbar的选中时的image(selectedImage)
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    controller.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // 为所有子控制器添加一个导航控制器
    SLNavigationController *nav = [[SLNavigationController alloc] initWithRootViewController:controller];
    // 添加子控制器
    [self addChildViewController:nav];
    
    [self.custom addTabBarButtonWithItem:controller.tabBarItem];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
