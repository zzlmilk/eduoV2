//
//  SLTabBarController.m
//  02-pigBank
//
//  Created by 陆承东 on 14-9-12.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLTabBarController.h"

#import "ICSDrawerController.h"

#import "SLHomeViewController.h"
#import "SLMessageViewController.h"
#import "SLPhoneViewController.h"
#import "SLVipViewController.h"
#import "SLTabBar.h"
#import "SLNavigationController.h"
#import "SLMoreViewController.h"
#import "UIViewController+REFrostedViewController.h"
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
    // Do any additional setup after loading the view.
    
    [self setupTabBar];
    
    [self setupAllChildController];
    
}


- (void)viewWillAppear:(BOOL)animated
{
    
    SLLog(@"SLTabBarController----selectedIndexPath-----%d", self.selectedIndex);
    
//    [self tabBar:self.custom didSelectedFrom:0 to:self.selectedIndex];
    self.selectedIndex = self.selectedIndexPath;
    
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
//    custom.backgroundColor = [UIColor redColor];
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

#pragma mark - homeViewController的代理方法
/**
 *  点击了home页面的more按钮
 */
- (void)homeViewController:(SLHomeViewController *)homeViewController didClickMoreButton:(UIBarButtonItem *)more
{
//    [self.frostedViewController presentMenuViewController]
    [self.drawer open];
}


#pragma mark ---- REF侧滑菜单的按钮实现方法 --- 未完成
//- (void)showMenu
//{
//    [self.frostedViewController presentMenuViewController];
//}

#pragma mark - vipViewController的代理方法
/**
 *  点击了vip页面的more按钮
 */
- (void)vipViewController:(SLVipViewController *)vipViewController didClickMoreButton:(UIBarButtonItem *)more
{
    [self.drawer open];
}

#pragma mark - vipViewController的代理方法
/**
 *  点击了menu页面的more按钮
 */
- (void)menuViewController:(SLMenuViewController *)menuViewController didClickMoreButton:(UIBarButtonItem *)more
{
    [self.drawer open];
}

#pragma mark - ICSDrawerControllerPresenting
- (void)drawerControllerWillOpen:(ICSDrawerController *)drawerController
{
    self.view.userInteractionEnabled = NO;
}

- (void)drawerControllerDidClose:(ICSDrawerController *)drawerController
{
    self.view.userInteractionEnabled = YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
