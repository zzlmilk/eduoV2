//
//  SLNavigationController.m
//  02-pigBank
//
//  Created by 陆承东 on 14-9-14.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLNavigationController.h"

@interface SLNavigationController ()

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
