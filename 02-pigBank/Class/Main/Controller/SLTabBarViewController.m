//
//  SLTabBarViewController.m
//  02-pigBank
//
//  Created by 陆承东 on 15/1/12.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import "SLTabBarViewController.h"

#import "SLPlateInfo.h"

#import "SLHomeViewController.h"
#import "SLVipViewController.h"
#import "SLMessageViewController.h"
#import "SLMenuViewController.h"
#import "SLPhoneViewController.h"
#import "SLFinancialProductsListController.h"
#import "SLOutletsViewController.h"
#import "SLMerchantControllerController.h"
#import "SLMyCommentViewController.h"
//#import "SLMyCollectionController.h"
#import "SLCollectViewController.h"
#import "SLMyConsultantController.h"
#import "SLMessageListController.h"
#import "SLClientListTableViewController.h"
#import "SLActivityListViewController.h"
#import "SLSubscribeListController.h"
#import "SLNavigationController.h"
#import "UIImage+WebP.h"

#import "SLAccountTool.h"
#import "SLPlateInfoTool.h"

@interface SLTabBarViewController ()<UITabBarControllerDelegate, SLMessageViewControllerDelegate, SLPhoneViewControllerDelegate>

@property (nonatomic, strong) NSArray *tabbarItems;

@property (nonatomic, copy) NSString *userType;

@end

@implementation SLTabBarViewController
static SLTabBarViewController *shareInstance = nil;

- (NSString *)userType
{
    if (_userType == nil) {
        _userType = [SLAccountTool getAccount].accountInfo.userType;
    }
    return _userType;
}

+ (SLTabBarViewController *)sharedTabbarController
{
    if (shareInstance == nil) {
        shareInstance = [[SLTabBarViewController alloc] init];
    }
    return shareInstance;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    self.tabBar.selectedImageTintColor = SLRed;
    
    [self addSubviews];
}

- (void)addSubviews
{
    NSArray *plateInfoListArray = [SLPlateInfoTool getPlateInfoList];
    
    SLHomeViewController *homevc = [[SLHomeViewController alloc] init];
    SLNavigationController *home = [[SLNavigationController alloc] initWithRootViewController:homevc];
    homevc.title = @"首页";
    UITabBarItem *homeItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:[UIImage imageNamed:@"iconHome"] selectedImage:[UIImage imageNamed:@"iconHomePress"]];
    home.tabBarItem = homeItem;
    
    SLVipViewController *vipvc = [[SLVipViewController alloc] init];
    SLNavigationController *vip = [[SLNavigationController alloc] initWithRootViewController:vipvc];
    for (SLPlateInfo *plateInfo in plateInfoListArray) {
        if ([plateInfo.plateType isEqualToString:@"2"]) {
            vipvc.title = plateInfo.dispName;
        }
    }
    UITabBarItem *vipItem = [[UITabBarItem alloc] initWithTitle:@"特权" image:[UIImage imageNamed:@"iconVip"] selectedImage:[UIImage imageNamed:@"iconVipPress"]];
    vip.tabBarItem = vipItem;
    
    SLMessageViewController *messagevc = [[SLMessageViewController alloc] init];
    SLNavigationController *message = [[SLNavigationController alloc] initWithRootViewController:messagevc];
    messagevc.title = @"留言";
    messagevc.delegate = self;
    UITabBarItem *messageItem = [[UITabBarItem alloc] initWithTitle:@"留言" image:[UIImage imageNamed:@"iconMessage"] selectedImage:[UIImage imageNamed:@"iconMessagePress"]];
    message.tabBarItem = messageItem;
    
    SLMessageListController *messageListVc = [[SLMessageListController alloc] init];
    SLNavigationController *messageList = [[SLNavigationController alloc] initWithRootViewController:messageListVc];
    messageListVc.title = @"留言";
    UITabBarItem *messageListItem = [[UITabBarItem alloc] initWithTitle:@"留言" image:[UIImage imageNamed:@"iconMessage"] selectedImage:[UIImage imageNamed:@"iconMessagePress"]];
    messageList.tabBarItem = messageListItem;
    
//    SLMenuViewController *menuvc = [[SLMenuViewController alloc] init];
//    SLNavigationController *menu = [[SLNavigationController alloc] initWithRootViewController:menuvc];
//    menuvc.title = @"电联";
//    UITabBarItem *menuItem = [[UITabBarItem alloc] initWithTitle:@"设置" image:[UIImage imageNamed:@"iconPhone"] selectedImage:[UIImage imageNamed:@"iconPhonePress"]];
//    menu.tabBarItem = menuItem;
    
    SLPhoneViewController *phonevc = [[SLPhoneViewController alloc] init];
    SLNavigationController *phone = [[SLNavigationController alloc] initWithRootViewController:phonevc];
    phonevc.title = @"电联";
    phonevc.delegate = self;
    UITabBarItem *phoneItem = [[UITabBarItem alloc] initWithTitle:@"电联" image:[UIImage imageNamed:@"iconPhone"] selectedImage:[UIImage imageNamed:@"iconPhonePress"]];
    phone.tabBarItem = phoneItem;
    
    SLClientListTableViewController *clientListVc = [[SLClientListTableViewController alloc] init];
    SLNavigationController *clientList = [[SLNavigationController alloc] initWithRootViewController:clientListVc];
    clientListVc.title = @"客户列表";
    UITabBarItem *clientListItem = [[UITabBarItem alloc] initWithTitle:@"客户" image:[UIImage imageNamed:@"renWu"] selectedImage:[UIImage imageNamed:@"renWuJiaoHu"]];
    clientList.tabBarItem = clientListItem;
    
    SLFinancialProductsListController *fplvc = [[SLFinancialProductsListController alloc] init];
    SLNavigationController *fpl = [[SLNavigationController alloc] initWithRootViewController:fplvc];
    for (SLPlateInfo *plateInfo in plateInfoListArray) {
        if ([plateInfo.plateType isEqualToString:@"3"]) {
            fplvc.title = plateInfo.dispName;
        }
    }
    UITabBarItem *fplItem = [[UITabBarItem alloc] initWithTitle:@"理财" image:[UIImage imageNamed:@"iconPhone"] selectedImage:[UIImage imageNamed:@"iconPhonePress"]];
    fpl.tabBarItem = fplItem;
    
    SLOutletsViewController *outletsvc = [[SLOutletsViewController alloc] init];
    SLNavigationController *outlets = [[SLNavigationController alloc] initWithRootViewController:outletsvc];
    for (SLPlateInfo *plateInfo in plateInfoListArray) {
        if ([plateInfo.plateType isEqualToString:@"4"]) {
            outletsvc.title = plateInfo.dispName;
        }
    }
    UITabBarItem *outletsItem = [[UITabBarItem alloc] initWithTitle:@"网点" image:[UIImage imageNamed:@"iconPhone"] selectedImage:[UIImage imageNamed:@"iconPhonePress"]];
    outlets.tabBarItem = outletsItem;
    
    SLMerchantControllerController *merchantvc = [[SLMerchantControllerController alloc] init];
    SLNavigationController *merchant = [[SLNavigationController alloc] initWithRootViewController:merchantvc];
    merchantvc.title = @"商圈";
    UITabBarItem *merchantItem = [[UITabBarItem alloc] initWithTitle:@"商户" image:[UIImage imageNamed:@"iconPhone"] selectedImage:[UIImage imageNamed:@"iconPhonePress"]];
    merchant.tabBarItem = merchantItem;
    
    SLActivityListViewController *activityvc = [[SLActivityListViewController alloc] init];
    SLNavigationController *activity = [[SLNavigationController alloc] initWithRootViewController:activityvc];
    for (SLPlateInfo *plateInfo in plateInfoListArray) {
        if ([plateInfo.plateType isEqualToString:@"5"]) {
            activityvc.title = plateInfo.dispName;
        }
    }
    UITabBarItem *activityItem = [[UITabBarItem alloc] initWithTitle:@"活动" image:[UIImage imageNamed:@"iconPhone"] selectedImage:[UIImage imageNamed:@"iconPhonePress"]];
    activity.tabBarItem = activityItem;
    
    SLSubscribeListController *subscribevc = [[SLSubscribeListController alloc] init];
    SLNavigationController *subscribe = [[SLNavigationController alloc] initWithRootViewController:subscribevc];
    subscribevc.title = @"订阅";
    UITabBarItem *subscribeItem = [[UITabBarItem alloc] initWithTitle:@"订阅" image:[UIImage imageNamed:@"iconPhone"] selectedImage:[UIImage imageNamed:@"iconPhonePress"]];
    subscribe.tabBarItem = subscribeItem;
    
    SLMyCommentViewController *commentvc = [[SLMyCommentViewController alloc] init];
    SLNavigationController *comment = [[SLNavigationController alloc] initWithRootViewController:commentvc];
    commentvc.title = @"我的评论";
    UITabBarItem *commentItem = [[UITabBarItem alloc] initWithTitle:@"我的评论" image:[UIImage imageNamed:@"iconPhone"] selectedImage:[UIImage imageNamed:@"iconPhonePress"]];
    comment.tabBarItem = commentItem;
    
//    SLMyCollectionController *collectionvc = [[SLMyCollectionController alloc] init];
//    SLNavigationController *collection = [[SLNavigationController alloc] initWithRootViewController:collectionvc];
//    collectionvc.title = @"我的收藏";
//    UITabBarItem *collectionItem = [[UITabBarItem alloc] initWithTitle:@"我的收藏" image:[UIImage imageNamed:@"iconPhone"] selectedImage:[UIImage imageNamed:@"iconPhonePress"]];
    //    collection.tabBarItem = collectionItem;
    
    SLCollectViewController *collectionvc = [[SLCollectViewController alloc] init];
    SLNavigationController *collection = [[SLNavigationController alloc] initWithRootViewController:collectionvc];
    collectionvc.title = @"我的收藏";
    UITabBarItem *collectionItem = [[UITabBarItem alloc] initWithTitle:@"我的收藏" image:[UIImage imageNamed:@"iconPhone"] selectedImage:[UIImage imageNamed:@"iconPhonePress"]];
    collection.tabBarItem = collectionItem;
    
    SLMyConsultantController *consultantvc = [[SLMyConsultantController alloc] init];
    SLNavigationController *consultant = [[SLNavigationController alloc] initWithRootViewController:consultantvc];
    consultantvc.title = @"我的顾问";
    UITabBarItem *consultantItem = [[UITabBarItem alloc] initWithTitle:@"我的顾问" image:[UIImage imageNamed:@"iconPhone"] selectedImage:[UIImage imageNamed:@"iconPhonePress"]];
    consultant.tabBarItem = consultantItem;
    
    if ([self.userType isEqualToString:@"3"]) {
        self.viewControllers = [[NSArray alloc] initWithObjects:home, vip, message, phone, fpl, outlets, activity, merchant, subscribe, comment, collection, consultant, nil];
        
        CGRect tabbarFrame = self.tabBar.frame;
        tabbarFrame.size.width += 80;
        self.tabBar.frame = tabbarFrame;
    } else if ([self.userType isEqualToString:@"2"]) {
        self.viewControllers = [[NSArray alloc] initWithObjects:home, messageList, clientList, vip, fpl, outlets, activity, merchant, subscribe, comment, collection, nil];
        
        CGRect tabbarFrame = self.tabBar.frame;
        tabbarFrame.size.width += 320 / 3 *2;
        self.tabBar.frame = tabbarFrame;
    }
    
//    [self addChildViewController:home];
//    [self addChildViewController:vip];
//    [self addChildViewController:message];
//    [self addChildViewController:menu];
//    
//    self.viewControllers = @[home, vip, message, menu];
}

- (void)messageViewController:(SLMessageViewController *)messageViewController didPopWithFlag:(BOOL)flag
{
    self.selectedIndex = self.lastSelectedIndex;
}

- (void)phoneViewControllerDidPoped:(SLPhoneViewController *)phoneViewController
{
    self.selectedIndex = self.lastSelectedIndex;
}

// 再次设置上次点击的地方，超过五个暂时无法解决
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    if ([self.userType isEqualToString:@"3"]) {
        if ([viewController isKindOfClass:[SLNavigationController class]]) {
            SLNavigationController *nav = (SLNavigationController *)viewController;
            UIViewController *vc = nav.topViewController;
            if ([vc isKindOfClass:[SLHomeViewController class]]) {
                self.lastSelectedIndex = 0;
            } else if ([vc isKindOfClass:[SLVipViewController class]]) {
                self.lastSelectedIndex = 1;
            } else if ([vc isKindOfClass:[SLMessageViewController class]]) {
                
            } else if ([vc isKindOfClass:[SLMenuViewController class]]) {
                self.lastSelectedIndex = 3;
            }
        } else if ([viewController isKindOfClass:[UIViewController class]]) {
            
        }
    } else if ([self.userType isEqualToString:@"2"]) {
        if ([viewController isKindOfClass:[SLNavigationController class]]) {
            SLNavigationController *nav = (SLNavigationController *)viewController;
            UIViewController *vc = nav.topViewController;
            if ([vc isKindOfClass:[SLHomeViewController class]]) {
                self.lastSelectedIndex = 0;
            } else if ([vc isKindOfClass:[SLClientListTableViewController class]]) {
                self.lastSelectedIndex = 2;
            }
        } else if ([viewController isKindOfClass:[UIViewController class]]) {
            
        }
    }
}

- (void)dead
{
    shareInstance = nil;
}

- (void)tabbarSave
{
    
    //    NSMutableArray *viewControllers = [NSMutableArray array];
    //
    //    for (int i = 0; i < self.plateInfoListArray.count; i++) {
    //        SLPlateInfo *plateInfo = self.plateInfoListArray[i];
    //
    //        if ([self.userType isEqualToString:@"3"]) {
    //
    //            if ([plateInfo.plateType isEqualToString:@"1"]) {
    //                SLHomeViewController *homevc = [[SLHomeViewController alloc] init];
    //                SLNavigationController *home = [[SLNavigationController alloc] initWithRootViewController:homevc];
    //                home.title = plateInfo.dispName;
    //                UITabBarItem *homeItem = [[UITabBarItem alloc] initWithTitle:plateInfo.dispName image:[UIImage imageNamed:@"iconHome"] selectedImage:[UIImage imageNamed:@"iconHomePress"]];
    //                home.tabBarItem = homeItem;
    //                [viewControllers addObject:home];
    //            } else if ([plateInfo.plateType isEqualToString:@"2"]) {
    //                SLVipViewController *vipvc = [[SLVipViewController alloc] init];
    //                SLNavigationController *vip = [[SLNavigationController alloc] initWithRootViewController:vipvc];
    //                vip.title = plateInfo.dispName;
    //                UITabBarItem *vipItem = [[UITabBarItem alloc] initWithTitle:plateInfo.dispName image:[UIImage imageNamed:@"iconVip"] selectedImage:[UIImage imageNamed:@"iconVipPress"]];
    //                vip.tabBarItem = vipItem;
    //                [viewControllers addObject:vip];
    //
    //                SLMessageViewController *messagevc = [[SLMessageViewController alloc] init];
    //                SLNavigationController *message = [[SLNavigationController alloc] initWithRootViewController:messagevc];
    //                message.title = @"消息";
    //                messagevc.delegate = self;
    //                UITabBarItem *messageItem = [[UITabBarItem alloc] initWithTitle:@"消息" image:[UIImage imageNamed:@"iconMessage"] selectedImage:[UIImage imageNamed:@"iconMessagePress"]];
    //                message.tabBarItem = messageItem;
    //                [viewControllers addObject:message];
    //
    //                SLMenuViewController *menuvc = [[SLMenuViewController alloc] init];
    //                SLNavigationController *menu = [[SLNavigationController alloc] initWithRootViewController:menuvc];
    //                menu.title = @"电联";
    //                UITabBarItem *menuItem = [[UITabBarItem alloc] initWithTitle:@"设置" image:[UIImage imageNamed:@"iconPhone"] selectedImage:[UIImage imageNamed:@"iconPhonePress"]];
    //                menu.tabBarItem = menuItem;
    //                [viewControllers addObject:menu];
    //            } else if ([plateInfo.plateType isEqualToString:@"3"]) {
    //
    //                SLFinancialProductsListController *fplvc = [[SLFinancialProductsListController alloc] init];
    //                SLNavigationController *fpl = [[SLNavigationController alloc] initWithRootViewController:fplvc];
    //                fpl.title = plateInfo.dispName;
    //                UITabBarItem *fplItem = [[UITabBarItem alloc] initWithTitle:plateInfo.dispName image:[UIImage imageNamed:@"iconPhone"] selectedImage:[UIImage imageNamed:@"iconPhonePress"]];
    //                fpl.tabBarItem = fplItem;
    //                [viewControllers addObject:fpl];
    //            } else if ([plateInfo.plateType isEqualToString:@"4"]) {
    //
    //                SLOutletsViewController *outletsvc = [[SLOutletsViewController alloc] init];
    //                SLNavigationController *outlets = [[SLNavigationController alloc] initWithRootViewController:outletsvc];
    //                outlets.title = plateInfo.dispName;
    //                UITabBarItem *outletsItem = [[UITabBarItem alloc] initWithTitle:plateInfo.dispName image:[UIImage imageNamed:@"iconPhone"] selectedImage:[UIImage imageNamed:@"iconPhonePress"]];
    //                outlets.tabBarItem = outletsItem;
    //                [viewControllers addObject:outlets];
    //            } else if ([plateInfo.plateType isEqualToString:@"5"]) {
    //
    //                SLActivityListViewController *activityvc = [[SLActivityListViewController alloc] init];
    //                SLNavigationController *activity = [[SLNavigationController alloc] initWithRootViewController:activityvc];
    //                activity.title = plateInfo.dispName;
    //                UITabBarItem *activityItem = [[UITabBarItem alloc] initWithTitle:plateInfo.dispName image:[UIImage imageNamed:@"iconPhone"] selectedImage:[UIImage imageNamed:@"iconPhonePress"]];
    //                activity.tabBarItem = activityItem;
    //                [viewControllers addObject:activity];
    //            } else if ([plateInfo.plateType isEqualToString:@"6"]) {
    //
    //                SLMerchantControllerController *merchantvc = [[SLMerchantControllerController alloc] init];
    //                SLNavigationController *merchant = [[SLNavigationController alloc] initWithRootViewController:merchantvc];
    //                merchant.title = plateInfo.dispName;
    //                UITabBarItem *merchantItem = [[UITabBarItem alloc] initWithTitle:plateInfo.dispName image:[UIImage imageNamed:@"iconPhone"] selectedImage:[UIImage imageNamed:@"iconPhonePress"]];
    //                merchant.tabBarItem = merchantItem;
    //                [viewControllers addObject:merchant];
    //            } else if ([plateInfo.plateType isEqualToString:@"7"]) {
    //
    //                SLSubscribeListController *subscribevc = [[SLSubscribeListController alloc] init];
    //                SLNavigationController *subscribe = [[SLNavigationController alloc] initWithRootViewController:subscribevc];
    //                subscribe.title = plateInfo.dispName;
    //                UITabBarItem *subscribeItem = [[UITabBarItem alloc] initWithTitle:plateInfo.dispName image:[UIImage imageNamed:@"iconPhone"] selectedImage:[UIImage imageNamed:@"iconPhonePress"]];
    //                subscribe.tabBarItem = subscribeItem;
    //                [viewControllers addObject:subscribe];
    //            } else if ([plateInfo.plateType isEqualToString:@"8"]) {
    //
    //                SLMyCommentViewController *commentvc = [[SLMyCommentViewController alloc] init];
    //                SLNavigationController *comment = [[SLNavigationController alloc] initWithRootViewController:commentvc];
    //                comment.title = plateInfo.dispName;
    //                UITabBarItem *commentItem = [[UITabBarItem alloc] initWithTitle:plateInfo.dispName image:[UIImage imageNamed:@"iconPhone"] selectedImage:[UIImage imageNamed:@"iconPhonePress"]];
    //                comment.tabBarItem = commentItem;
    //                [viewControllers addObject:comment];
    //            } else if ([plateInfo.plateType isEqualToString:@"9"]) {
    //
    //                SLMyCollectionController *collectionvc = [[SLMyCollectionController alloc] init];
    //                SLNavigationController *collection = [[SLNavigationController alloc] initWithRootViewController:collectionvc];
    //                collection.title = plateInfo.dispName;
    //                UITabBarItem *collectionItem = [[UITabBarItem alloc] initWithTitle:plateInfo.dispName image:[UIImage imageNamed:@"iconPhone"] selectedImage:[UIImage imageNamed:@"iconPhonePress"]];
    //                collection.tabBarItem = collectionItem;
    //                [viewControllers addObject:collection];
    //            } else if ([plateInfo.plateType isEqualToString:@"10"]) {
    //
    //                SLMyConsultantController *consultantvc = [[SLMyConsultantController alloc] init];
    //                SLNavigationController *consultant = [[SLNavigationController alloc] initWithRootViewController:consultantvc];
    //                consultant.title = plateInfo.dispName;
    //                UITabBarItem *consultantItem = [[UITabBarItem alloc] initWithTitle:plateInfo.dispName image:[UIImage imageNamed:@"iconPhone"] selectedImage:[UIImage imageNamed:@"iconPhonePress"]];
    //                consultant.tabBarItem = consultantItem;
    //                [viewControllers addObject:consultant];
    //            }
    //
    //            CGRect tabbarFrame = self.tabBar.frame;
    //            tabbarFrame.size.width += 80;
    //            self.tabBar.frame = tabbarFrame;
    //        } else if ([self.userType isEqualToString:@"2"]) {
    //
    //            if ([plateInfo.plateType isEqualToString:@"1"]) {
    //                SLHomeViewController *homevc = [[SLHomeViewController alloc] init];
    //                SLNavigationController *home = [[SLNavigationController alloc] initWithRootViewController:homevc];
    //                home.title = plateInfo.dispName;
    //                UITabBarItem *homeItem = [[UITabBarItem alloc] initWithTitle:plateInfo.dispName image:[UIImage imageNamed:@"iconHome"] selectedImage:[UIImage imageNamed:@"iconHomePress"]];
    //                home.tabBarItem = homeItem;
    //                [viewControllers addObject:home];
    //
    //                SLMessageListController *messageListVc = [[SLMessageListController alloc] init];
    //                SLNavigationController *messageList = [[SLNavigationController alloc] initWithRootViewController:messageListVc];
    //                messageList.title = @"留言";
    //                UITabBarItem *messageListItem = [[UITabBarItem alloc] initWithTitle:@"留言" image:[UIImage imageNamed:@"iconMessage"] selectedImage:[UIImage imageNamed:@"iconMessagePress"]];
    //                messageList.tabBarItem = messageListItem;
    //                [viewControllers addObject:messageList];
    //
    //                SLClientListTableViewController *clientListVc = [[SLClientListTableViewController alloc] init];
    //                SLNavigationController *clientList = [[SLNavigationController alloc] initWithRootViewController:clientListVc];
    //                clientList.title = @"客户列表";
    //                UITabBarItem *clientListItem = [[UITabBarItem alloc] initWithTitle:@"客户" image:[UIImage imageNamed:@"renWu"] selectedImage:[UIImage imageNamed:@"renWuJiaoHu"]];
    //                clientList.tabBarItem = clientListItem;
    //                [viewControllers addObject:clientList];
    //            } else if ([plateInfo.plateType isEqualToString:@"2"]) {
    //                SLVipViewController *vipvc = [[SLVipViewController alloc] init];
    //                SLNavigationController *vip = [[SLNavigationController alloc] initWithRootViewController:vipvc];
    //                vip.title = plateInfo.dispName;
    //                UITabBarItem *vipItem = [[UITabBarItem alloc] initWithTitle:plateInfo.dispName image:[UIImage imageNamed:@"iconVip"] selectedImage:[UIImage imageNamed:@"iconVipPress"]];
    //                vip.tabBarItem = vipItem;
    //                [viewControllers addObject:vip];
    //            } else if ([plateInfo.plateType isEqualToString:@"3"]) {
    //
    //                SLFinancialProductsListController *fplvc = [[SLFinancialProductsListController alloc] init];
    //                SLNavigationController *fpl = [[SLNavigationController alloc] initWithRootViewController:fplvc];
    //                fpl.title = plateInfo.dispName;
    //                UITabBarItem *fplItem = [[UITabBarItem alloc] initWithTitle:plateInfo.dispName image:[UIImage imageNamed:@"iconPhone"] selectedImage:[UIImage imageNamed:@"iconPhonePress"]];
    //                fpl.tabBarItem = fplItem;
    //                [viewControllers addObject:fpl];
    //            } else if ([plateInfo.plateType isEqualToString:@"4"]) {
    //
    //                SLOutletsViewController *outletsvc = [[SLOutletsViewController alloc] init];
    //                SLNavigationController *outlets = [[SLNavigationController alloc] initWithRootViewController:outletsvc];
    //                outlets.title = plateInfo.dispName;
    //                UITabBarItem *outletsItem = [[UITabBarItem alloc] initWithTitle:plateInfo.dispName image:[UIImage imageNamed:@"iconPhone"] selectedImage:[UIImage imageNamed:@"iconPhonePress"]];
    //                outlets.tabBarItem = outletsItem;
    //                [viewControllers addObject:outlets];
    //            } else if ([plateInfo.plateType isEqualToString:@"5"]) {
    //
    //                SLActivityListViewController *activityvc = [[SLActivityListViewController alloc] init];
    //                SLNavigationController *activity = [[SLNavigationController alloc] initWithRootViewController:activityvc];
    //                activity.title = plateInfo.dispName;
    //                UITabBarItem *activityItem = [[UITabBarItem alloc] initWithTitle:plateInfo.dispName image:[UIImage imageNamed:@"iconPhone"] selectedImage:[UIImage imageNamed:@"iconPhonePress"]];
    //                activity.tabBarItem = activityItem;
    //                [viewControllers addObject:activity];
    //            } else if ([plateInfo.plateType isEqualToString:@"6"]) {
    //
    //                SLMerchantControllerController *merchantvc = [[SLMerchantControllerController alloc] init];
    //                SLNavigationController *merchant = [[SLNavigationController alloc] initWithRootViewController:merchantvc];
    //                merchant.title = plateInfo.dispName;
    //                UITabBarItem *merchantItem = [[UITabBarItem alloc] initWithTitle:plateInfo.dispName image:[UIImage imageNamed:@"iconPhone"] selectedImage:[UIImage imageNamed:@"iconPhonePress"]];
    //                merchant.tabBarItem = merchantItem;
    //                [viewControllers addObject:merchant];
    //            } else if ([plateInfo.plateType isEqualToString:@"7"]) {
    //
    //                SLSubscribeListController *subscribevc = [[SLSubscribeListController alloc] init];
    //                SLNavigationController *subscribe = [[SLNavigationController alloc] initWithRootViewController:subscribevc];
    //                subscribe.title = plateInfo.dispName;
    //                UITabBarItem *subscribeItem = [[UITabBarItem alloc] initWithTitle:plateInfo.dispName image:[UIImage imageNamed:@"iconPhone"] selectedImage:[UIImage imageNamed:@"iconPhonePress"]];
    //                subscribe.tabBarItem = subscribeItem;
    //                [viewControllers addObject:subscribe];
    //            } else if ([plateInfo.plateType isEqualToString:@"8"]) {
    //
    //                SLMyCommentViewController *commentvc = [[SLMyCommentViewController alloc] init];
    //                SLNavigationController *comment = [[SLNavigationController alloc] initWithRootViewController:commentvc];
    //                comment.title = plateInfo.dispName;
    //                UITabBarItem *commentItem = [[UITabBarItem alloc] initWithTitle:plateInfo.dispName image:[UIImage imageNamed:@"iconPhone"] selectedImage:[UIImage imageNamed:@"iconPhonePress"]];
    //                comment.tabBarItem = commentItem;
    //                [viewControllers addObject:comment];
    //            } else if ([plateInfo.plateType isEqualToString:@"9"]) {
    //
    //                SLMyCollectionController *collectionvc = [[SLMyCollectionController alloc] init];
    //                SLNavigationController *collection = [[SLNavigationController alloc] initWithRootViewController:collectionvc];
    //                collection.title = plateInfo.dispName;
    //                UITabBarItem *collectionItem = [[UITabBarItem alloc] initWithTitle:plateInfo.dispName image:[UIImage imageNamed:@"iconPhone"] selectedImage:[UIImage imageNamed:@"iconPhonePress"]];
    //                collection.tabBarItem = collectionItem;
    //                [viewControllers addObject:collection];
    //            }
    //            
    //            CGRect tabbarFrame = self.tabBar.frame;
    //            tabbarFrame.size.width += 320 / 3 *2;
    //            self.tabBar.frame = tabbarFrame;
    //        }
    //        
    //        self.viewControllers = [NSArray arrayWithArray:viewControllers];
    //    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
