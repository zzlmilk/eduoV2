//
//  SLMoreViewController.m
//  02-pigBank
//
//  Created by 陆承东 on 14-9-18.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLMoreViewController.h"

#import "SLMoreGroups.h"
#import "SLMoreItem.h"
#import "UIBarButtonItem+SL.h"

#import "SLTabBarController.h"
#import "SLFinancialProductsListController.h"
#import "SLOutletsViewController.h"
#import "SLMerchantControllerController.h"
#import "SLNavigationController.h"
#import "SLMenuNavgationController.h"

#import "UIViewController+REXSideMenu.h"

@interface SLMoreViewController ()<SLFinancialProductsListControllerDelegate, REXSideMenuDelegate>

@property (nonatomic, strong) NSArray *moreGroups;

@property (nonatomic, assign) long financialProductMark;

@end

@implementation SLMoreViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    SLMoreGroups *mg1 = [[SLMoreGroups alloc] init];
    
    /** mi11 */
    SLMoreItem *mi11 = [[SLMoreItem alloc] init];
    mi11.title = @"user";
    mi11.iconImage = [UIImage imageNamed:@"wo"];
    
    mg1.moreItems = @[mi11];
    
    SLMoreGroups *mg2 = [[SLMoreGroups alloc] init];
    
    /** mi21 */
    SLMoreItem *mi21 = [[SLMoreItem alloc] init];
    mi21.title = @"首页";
    mi21.iconImage = [UIImage imageNamed:@"shouYe"];
    
    /** mi22 */
//    SLMoreItem *mi22 = [[SLMoreItem alloc] init];
//    mi22.title = @"vip特权";
//    mi22.iconImage = [UIImage imageNamed:@"vip"];
    
    /** mi23 */
    SLMoreItem *mi23 = [[SLMoreItem alloc] init];
    mi23.title = @"尊享理财";
    mi23.iconImage = [UIImage imageNamed:@"zunXiangLiCai"];
    
    /** mi24 */
    SLMoreItem *mi24 = [[SLMoreItem alloc] init];
    mi24.title = @"网点信息";
    mi24.iconImage = [UIImage imageNamed:@"wangDian"];
    
    /** mi25 */
    SLMoreItem *mi25 = [[SLMoreItem alloc] init];
    mi25.title = @"商户信息";
    mi25.iconImage = [UIImage imageNamed:@"shangQuan"];
    
    mg2.moreItems = @[mi21, mi23, mi24, mi25];
    
    SLMoreGroups *mg3 = [[SLMoreGroups alloc] init];
    
    /** mi31 */
    SLMoreItem *mi31 = [[SLMoreItem alloc] init];
    mi31.title = @"我的点评";
    mi31.iconImage = [UIImage imageNamed:@"dianPing"];
    
    /** mi32 */
    SLMoreItem *mi32 = [[SLMoreItem alloc] init];
    mi32.title = @"我的收藏";
    mi32.iconImage = [UIImage imageNamed:@"shouCang"];
    
    /** mi33 */
    SLMoreItem *mi33 = [[SLMoreItem alloc] init];
    mi33.title = @"我的顾问";
    mi33.iconImage = [UIImage imageNamed:@"guWen"];
    
    mg3.moreItems = @[mi31, mi32, mi33];
    
    self.moreGroups = @[mg1, mg2, mg3];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.moreGroups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    SLMoreGroups *mg = self.moreGroups[section];
    return mg.moreItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SLMoreGroups *cg = self.moreGroups[indexPath.section];
    SLMoreItem *mi = cg.moreItems[indexPath.row];
    
    static NSString *ID = @"moreItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = mi.title;
    cell.imageView.image = mi.iconImage;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SLMoreGroups *mg = self.moreGroups[indexPath.section];
    
    SLMoreItem *mi = mg.moreItems[indexPath.row];
    
    if ([mi.title isEqualToString:@"首页"]) {
        
        SLTabBarController *tabbar = [[SLTabBarController alloc] init];
        [self.sideMenuViewController setContentViewController:tabbar animated:YES];
        
        tabbar.selectedIndexPath = 1;
        
        [self.sideMenuViewController hideMenuViewController];
        
    } else if ([mi.title isEqualToString:@"尊享理财"]) {
        SLFinancialProductsListController *financial = [[SLFinancialProductsListController alloc] init];
        financial.tag = 1;
        
        SLMenuNavgationController *nav = [[SLMenuNavgationController alloc] initWithRootViewController:financial];
        nav.title = @"尊享理财";
        [self.sideMenuViewController setContentViewController:nav animated:YES];
        
        [self.sideMenuViewController hideMenuViewController];
        
    } else if ([mi.title isEqualToString:@"网点信息"]) {
        SLOutletsViewController *outlets = [[SLOutletsViewController alloc] init];
        outlets.tag = 1;
        
        SLMenuNavgationController *nav = [[SLMenuNavgationController alloc] initWithRootViewController:outlets];
        nav.title = @"尊享理财";
        [self.sideMenuViewController setContentViewController:nav animated:YES];
        
        [self.sideMenuViewController hideMenuViewController];
    } else if ([mi.title isEqualToString:@"商户信息"]) {
        SLMerchantControllerController *merchant = [[SLMerchantControllerController alloc] init];
        merchant.tag = 1;
        
        SLMenuNavgationController *nav = [[SLMenuNavgationController alloc] initWithRootViewController:merchant];
        nav.title = @"尊享理财";
        [self.sideMenuViewController setContentViewController:nav animated:YES];
        
        [self.sideMenuViewController hideMenuViewController];
    }
}

- (void)financialProductListController:(SLFinancialProductsListController *)financialProductListController didClickMoreButton:(UIBarButtonItem *)more
{
    
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
}

#pragma mark - ICSDrawerControllerPresenting

- (void)drawerControllerWillOpen:(ICSDrawerController *)drawerController
{
    self.view.userInteractionEnabled = YES;
}

- (void)drawerControllerDidClose:(ICSDrawerController *)drawerController
{
    self.view.userInteractionEnabled = NO;
}

@end
