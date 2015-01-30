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
#import "SLPlateInfo.h"

#import "SLTabBarViewController.h"
#import "SLFinancialProductsListController.h"
#import "SLOutletsViewController.h"
#import "SLMerchantControllerController.h"
#import "SLNavigationController.h"
#import "SLSettingViewController.h"
#import "SLActivityListViewController.h"

#import "SLAccountTool.h"
#import "SLPlateInfoTool.h"

#import "UIBarButtonItem+SL.h"
#import "UIImageView+MJWebCache.h"
#import "UIViewController+REXSideMenu.h"

@interface SLMoreViewController ()<SLFinancialProductsListControllerDelegate, REXSideMenuDelegate>

@property (nonatomic, copy) NSString *userType;

@property (nonatomic, strong) NSArray *moreGroups;

@property (nonatomic, assign) long financialProductMark;

@property (nonatomic, strong) SLTabBarViewController *tabbarController;

@end

@implementation SLMoreViewController

- (NSString *)userType
{
    if (_userType == nil) {
        _userType = [SLAccountTool getAccount].accountInfo.userType;
    }
    return _userType;
}

- (SLTabBarViewController *)tabbarController
{
    if (_tabbarController == nil) {
        _tabbarController = [[SLTabBarViewController alloc] init];
    }
    return _tabbarController;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadPlateInfoData];
    
}

- (void)loadPlateInfoData
{
    SLPlateInfoListParameters *parameters = [SLPlateInfoListParameters parameters];
    
    [SLPlateInfoTool plateInfoListWithParameters:parameters success:^(NSArray *plateInfoListArray) {
        
        self.plateInfoListArray = plateInfoListArray;
        [SLPlateInfoTool savePlateInfoList:plateInfoListArray];
        
        [self setGroupsAndItems];
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)setGroupsAndItems
{
    SLMoreGroups *mg1 = [[SLMoreGroups alloc] init];
    
    /** mi11 */
    SLMoreItem *mi11 = [[SLMoreItem alloc] init];
    mi11.title = [SLAccountTool getAccount].accountInfo.dispName;
    mi11.iconImage = [UIImage imageNamed:@"wo"];
    
    mg1.moreItems = @[mi11];
    
    SLMoreGroups *mg2 = [[SLMoreGroups alloc] init];
    
    NSMutableArray *moreItemArray = [NSMutableArray array];
    
    /** mi21 */
    for (int i = 0; i < self.plateInfoListArray.count; i ++) {
        
        NSArray *plateInfoList = self.plateInfoListArray;
        
        SLPlateInfo *plateInfo = plateInfoList[i];
        
        if ([plateInfo.plateType isEqualToString:@"1"]) {
            SLMoreItem *mi21 = [[SLMoreItem alloc] init];
            mi21.title = plateInfo.dispName;
            mi21.imageURLStr = plateInfo.pictureUrl;
            mi21.plateType = plateInfo.plateType;
            
            [moreItemArray addObject:mi21];
        } else if ([plateInfo.plateType isEqualToString:@"2"]) {
            SLMoreItem *mi22 = [[SLMoreItem alloc] init];
            mi22.title = plateInfo.dispName;
            mi22.imageURLStr = plateInfo.pictureUrl;
            mi22.plateType = plateInfo.plateType;
            
            [moreItemArray addObject:mi22];
        } else if ([plateInfo.plateType isEqualToString:@"3"]) {
            SLMoreItem *mi23 = [[SLMoreItem alloc] init];
            mi23.title = plateInfo.dispName;
            mi23.imageURLStr = plateInfo.pictureUrl;
            mi23.plateType = plateInfo.plateType;
            
            [moreItemArray addObject:mi23];
        } else if ([plateInfo.plateType isEqualToString:@"4"]) {
            SLMoreItem *mi24 = [[SLMoreItem alloc] init];
            mi24.title = plateInfo.dispName;
            mi24.imageURLStr = plateInfo.pictureUrl;
            mi24.plateType = plateInfo.plateType;
            
            [moreItemArray addObject:mi24];
        } else if ([plateInfo.plateType isEqualToString:@"5"]) {
            SLMoreItem *mi25 = [[SLMoreItem alloc] init];
            mi25.title = plateInfo.dispName;
            mi25.imageURLStr = plateInfo.pictureUrl;
            mi25.plateType = plateInfo.plateType;
            
            [moreItemArray addObject:mi25];
        } else if ([plateInfo.plateType isEqualToString:@"6"]) {
            SLMoreItem *mi26 = [[SLMoreItem alloc] init];
            mi26.title = plateInfo.dispName;
            mi26.imageURLStr = plateInfo.pictureUrl;
            mi26.plateType = plateInfo.plateType;
            
            [moreItemArray addObject:mi26];
        } else if ([plateInfo.plateType isEqualToString:@"7"]) {
            SLMoreItem *mi27 = [[SLMoreItem alloc] init];
            mi27.title = plateInfo.dispName;
            mi27.imageURLStr = plateInfo.pictureUrl;
            mi27.plateType = plateInfo.plateType;
            
            [moreItemArray addObject:mi27];
        }
    }
    
    mg2.moreItems = [NSArray arrayWithArray:moreItemArray];
    
    SLMoreGroups *mg3 = [[SLMoreGroups alloc] init];
    
    NSMutableArray *mg3MoreItemArray = [NSMutableArray array];
    
    for (int i = 0; i < self.plateInfoListArray.count; i ++) {
        SLPlateInfo *plateInfo = self.plateInfoListArray[i];
        
        if ([plateInfo.plateType isEqualToString:@"8"]) {
            SLMoreItem *mi31 = [[SLMoreItem alloc] init];
            mi31.title = plateInfo.dispName;
            mi31.imageURLStr = plateInfo.pictureUrl;
            mi31.plateType = plateInfo.plateType;
            
            [mg3MoreItemArray addObject:mi31];
        } else if ([plateInfo.plateType isEqualToString:@"9"]) {
            SLMoreItem *mi32 = [[SLMoreItem alloc] init];
            mi32.title = plateInfo.dispName;
            mi32.imageURLStr = plateInfo.pictureUrl;
            mi32.plateType = plateInfo.plateType;
            
            [mg3MoreItemArray addObject:mi32];
        } else if ([plateInfo.plateType isEqualToString:@"10"]) {
            SLMoreItem *mi33 = [[SLMoreItem alloc] init];
            mi33.title = plateInfo.dispName;
            mi33.imageURLStr = plateInfo.pictureUrl;
            mi33.plateType = plateInfo.plateType;
            if ([self.userType isEqualToString:@"3"]) {
                [mg3MoreItemArray addObject:mi33];
            } else if ([self.userType isEqualToString:@"2"]) {
            }
        }
    }
    
    mg3.moreItems = [NSArray arrayWithArray:mg3MoreItemArray];
    
    self.moreGroups = @[mg1, mg2, mg3];
    [self.tableView reloadData];
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
    [cell.imageView setImageURLStr:mi.imageURLStr placeholder:[UIImage imageNamed:@"dianPing"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        SLSettingViewController *settingvc = [[SLSettingViewController alloc] init];
        SLNavigationController *nav = [[SLNavigationController alloc] initWithRootViewController:settingvc];
        nav.title = @"设置";
        
        [self.sideMenuViewController setContentViewController:nav animated:YES];

        [self.sideMenuViewController hideMenuViewController];
    }
    
    SLMoreGroups *mg = self.moreGroups[indexPath.section];
    
    SLMoreItem *mi = mg.moreItems[indexPath.row];
    
    if ([self.userType isEqualToString:@"3"]) {
        if ([mi.plateType isEqualToString:@"1"]) {
            
            if ([self.sideMenuViewController.contentViewController isKindOfClass:[SLTabBarViewController class]]) {
                
            } else {
                [self.sideMenuViewController setContentViewController:[SLTabBarViewController sharedTabbarController] animated:YES];
            }
            
            [SLTabBarViewController sharedTabbarController].selectedIndex = 0;
            [SLTabBarViewController sharedTabbarController].lastSelectedIndex = 0;
            
            [self.sideMenuViewController hideMenuViewController];
            
        } else if ([mi.plateType isEqualToString:@"2"]) {
            
            if ([self.sideMenuViewController.contentViewController isKindOfClass:[SLTabBarViewController class]]) {
                
            } else {
                [self.sideMenuViewController setContentViewController:[SLTabBarViewController sharedTabbarController] animated:YES];
            }
            
            [SLTabBarViewController sharedTabbarController].selectedIndex = 1;
            [SLTabBarViewController sharedTabbarController].lastSelectedIndex = 1;
            
            [self.sideMenuViewController hideMenuViewController];
            
        } else if ([mi.plateType isEqualToString:@"3"]) {
            
            if ([self.sideMenuViewController.contentViewController isKindOfClass:[SLTabBarViewController class]]) {
                
            } else {
                [self.sideMenuViewController setContentViewController:[SLTabBarViewController sharedTabbarController] animated:YES];
            }
            
            [SLTabBarViewController sharedTabbarController].selectedIndex = 4;
            [SLTabBarViewController sharedTabbarController].lastSelectedIndex = 4;
            
            [self.sideMenuViewController hideMenuViewController];
            
        } else if ([mi.plateType isEqualToString:@"4"]) {
            
            if ([self.sideMenuViewController.contentViewController isKindOfClass:[SLTabBarViewController class]]) {
                
            } else {
                [self.sideMenuViewController setContentViewController:[SLTabBarViewController sharedTabbarController] animated:YES];
            }
            
            [SLTabBarViewController sharedTabbarController].selectedIndex = 5;
            [SLTabBarViewController sharedTabbarController].lastSelectedIndex = 5;
            
            [self.sideMenuViewController hideMenuViewController];
        } else if ([mi.plateType isEqualToString:@"5"]) {
            
            if ([self.sideMenuViewController.contentViewController isKindOfClass:[SLTabBarViewController class]]) {
                
            } else {
                [self.sideMenuViewController setContentViewController:[SLTabBarViewController sharedTabbarController] animated:YES];
            }
            
            [SLTabBarViewController sharedTabbarController].selectedIndex = 6;
            [SLTabBarViewController sharedTabbarController].lastSelectedIndex = 6;
            
            [self.sideMenuViewController hideMenuViewController];
        } else if ([mi.plateType isEqualToString:@"6"]) {
            
            if ([self.sideMenuViewController.contentViewController isKindOfClass:[SLTabBarViewController class]]) {
                
            } else {
                [self.sideMenuViewController setContentViewController:[SLTabBarViewController sharedTabbarController] animated:YES];
            }
            
            [SLTabBarViewController sharedTabbarController].selectedIndex = 7;
            [SLTabBarViewController sharedTabbarController].lastSelectedIndex = 7;
            
            [self.sideMenuViewController hideMenuViewController];
        } else if ([mi.plateType isEqualToString:@"7"]) {
            
            if ([self.sideMenuViewController.contentViewController isKindOfClass:[SLTabBarViewController class]]) {
                
            } else {
                [self.sideMenuViewController setContentViewController:[SLTabBarViewController sharedTabbarController] animated:YES];
            }
            
            [SLTabBarViewController sharedTabbarController].selectedIndex = 8;
            [SLTabBarViewController sharedTabbarController].lastSelectedIndex = 8;
            
            [self.sideMenuViewController hideMenuViewController];
        } else if ([mi.plateType isEqualToString:@"8"]) {
            
            if ([self.sideMenuViewController.contentViewController isKindOfClass:[SLTabBarViewController class]]) {
                
            } else {
                [self.sideMenuViewController setContentViewController:[SLTabBarViewController sharedTabbarController] animated:YES];
            }
            
            [SLTabBarViewController sharedTabbarController].selectedIndex = 9;
            [SLTabBarViewController sharedTabbarController].lastSelectedIndex = 9;
            
            [self.sideMenuViewController hideMenuViewController];
        } else if ([mi.plateType isEqualToString:@"9"]) {
            
            if ([self.sideMenuViewController.contentViewController isKindOfClass:[SLTabBarViewController class]]) {
                
            } else {
                [self.sideMenuViewController setContentViewController:[SLTabBarViewController sharedTabbarController] animated:YES];
            }
            
            [SLTabBarViewController sharedTabbarController].selectedIndex = 10;
            [SLTabBarViewController sharedTabbarController].lastSelectedIndex = 10;
            
            [self.sideMenuViewController hideMenuViewController];
        } else if ([mi.plateType isEqualToString:@"10"]) {
            
            if ([self.sideMenuViewController.contentViewController isKindOfClass:[SLTabBarViewController class]]) {
                
            } else {
                [self.sideMenuViewController setContentViewController:[SLTabBarViewController sharedTabbarController] animated:YES];
            }
            
            [SLTabBarViewController sharedTabbarController].selectedIndex = 11;
            [SLTabBarViewController sharedTabbarController].lastSelectedIndex = 11;
            
            [self.sideMenuViewController hideMenuViewController];
        }
    } else if ([self.userType isEqualToString:@"2"]) {
        if ([mi.plateType isEqualToString:@"1"]) {
            
            if ([self.sideMenuViewController.contentViewController isKindOfClass:[SLTabBarViewController class]]) {
                
            } else {
                [self.sideMenuViewController setContentViewController:[SLTabBarViewController sharedTabbarController] animated:YES];
            }
            
            [SLTabBarViewController sharedTabbarController].selectedIndex = 0;
            [SLTabBarViewController sharedTabbarController].lastSelectedIndex = 0;
            
            [self.sideMenuViewController hideMenuViewController];
            
        } else if ([mi.plateType isEqualToString:@"2"]) {
            
            if ([self.sideMenuViewController.contentViewController isKindOfClass:[SLTabBarViewController class]]) {
                
            } else {
                [self.sideMenuViewController setContentViewController:[SLTabBarViewController sharedTabbarController] animated:YES];
            }
            
            [SLTabBarViewController sharedTabbarController].selectedIndex = 3;
            [SLTabBarViewController sharedTabbarController].lastSelectedIndex = 3;
            
            [self.sideMenuViewController hideMenuViewController];
            
        } else if ([mi.plateType isEqualToString:@"3"]) {
            
            if ([self.sideMenuViewController.contentViewController isKindOfClass:[SLTabBarViewController class]]) {
                
            } else {
                [self.sideMenuViewController setContentViewController:[SLTabBarViewController sharedTabbarController] animated:YES];
            }
            
            [SLTabBarViewController sharedTabbarController].selectedIndex = 4;
            [SLTabBarViewController sharedTabbarController].lastSelectedIndex = 4;
            
            [self.sideMenuViewController hideMenuViewController];
            
        } else if ([mi.plateType isEqualToString:@"4"]) {
            
            if ([self.sideMenuViewController.contentViewController isKindOfClass:[SLTabBarViewController class]]) {
                
            } else {
                [self.sideMenuViewController setContentViewController:[SLTabBarViewController sharedTabbarController] animated:YES];
            }
            
            [SLTabBarViewController sharedTabbarController].selectedIndex = 5;
            [SLTabBarViewController sharedTabbarController].lastSelectedIndex = 5;
            
            [self.sideMenuViewController hideMenuViewController];
        } else if ([mi.plateType isEqualToString:@"5"]) {
            
            if ([self.sideMenuViewController.contentViewController isKindOfClass:[SLTabBarViewController class]]) {
                
            } else {
                [self.sideMenuViewController setContentViewController:[SLTabBarViewController sharedTabbarController] animated:YES];
            }
            
            [SLTabBarViewController sharedTabbarController].selectedIndex = 6;
            [SLTabBarViewController sharedTabbarController].lastSelectedIndex = 6;
            
            [self.sideMenuViewController hideMenuViewController];
        } else if ([mi.plateType isEqualToString:@"6"]) {
            
            if ([self.sideMenuViewController.contentViewController isKindOfClass:[SLTabBarViewController class]]) {
                
            } else {
                [self.sideMenuViewController setContentViewController:[SLTabBarViewController sharedTabbarController] animated:YES];
            }
            
            [SLTabBarViewController sharedTabbarController].selectedIndex = 7;
            [SLTabBarViewController sharedTabbarController].lastSelectedIndex = 7;
            
            [self.sideMenuViewController hideMenuViewController];
        } else if ([mi.plateType isEqualToString:@"7"]) {
            
            if ([self.sideMenuViewController.contentViewController isKindOfClass:[SLTabBarViewController class]]) {
                
            } else {
                [self.sideMenuViewController setContentViewController:[SLTabBarViewController sharedTabbarController] animated:YES];
            }
            
            [SLTabBarViewController sharedTabbarController].selectedIndex = 8;
            [SLTabBarViewController sharedTabbarController].lastSelectedIndex = 8;
            
            [self.sideMenuViewController hideMenuViewController];
        } else if ([mi.plateType isEqualToString:@"8"]) {
            
            if ([self.sideMenuViewController.contentViewController isKindOfClass:[SLTabBarViewController class]]) {
                
            } else {
                [self.sideMenuViewController setContentViewController:[SLTabBarViewController sharedTabbarController] animated:YES];
            }
            
            [SLTabBarViewController sharedTabbarController].selectedIndex = 9;
            [SLTabBarViewController sharedTabbarController].lastSelectedIndex = 9;
            
            [self.sideMenuViewController hideMenuViewController];
        } else if ([mi.plateType isEqualToString:@"9"]) {
            
            if ([self.sideMenuViewController.contentViewController isKindOfClass:[SLTabBarViewController class]]) {
                
            } else {
                [self.sideMenuViewController setContentViewController:[SLTabBarViewController sharedTabbarController] animated:YES];
            }
            
            [SLTabBarViewController sharedTabbarController].selectedIndex = 10;
            [SLTabBarViewController sharedTabbarController].lastSelectedIndex = 10;
            
            [self.sideMenuViewController hideMenuViewController];
        }
    }
    
    
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
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

@end
