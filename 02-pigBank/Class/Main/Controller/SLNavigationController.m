//
//  SLNavigationController.m
//  02-pigBank
//
//  Created by 陆承东 on 14-9-14.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLNavigationController.h"

#import "UIBarButtonItem+SL.h"

#import "SLFinancialProductsListController.h"

@interface SLNavigationController () <SLFinancialProductsListControllerDelegate>

@end

@implementation SLNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        // Custom initialization
    }
    return self;
}

/**
 *  第一次调用这个类时会调用,1个类只会调用一次
 */
+ (void)initialize
{
    // 设置导航栏主题
    [self setupNavBarTheme];
    
    
}

+ (void)setupNavBarTheme
{
    // 取出appearance
    UINavigationBar *navBar = [UINavigationBar appearance];
    
    
#warning 状态栏样式设置失效
    // 设置状态栏样式
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    NSMutableDictionary *attri = [NSMutableDictionary dictionary];
    attri[UITextAttributeFont] = [UIFont boldSystemFontOfSize:18];
    attri[UITextAttributeTextShadowOffset] = [NSValue valueWithUIOffset:UIOffsetZero];
    [navBar setTitleTextAttributes:attri];
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - vipViewController的代理方法
/**
 *  点击了vip页面的more按钮
 */
-(void)financialProductListController:(SLFinancialProductsListController *)financialProductListController didClickMoreButton:(UIBarButtonItem *)more
{
    [self.drawer open];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 设置只有根控制器时不需要隐藏tabBar
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}
@end
