//
//  SLTabBarController.h
//  02-pigBank
//
//  Created by 陆承东 on 14-9-12.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ICSDrawerController.h"

@interface SLTabBarController : UITabBarController <ICSDrawerControllerChild, ICSDrawerControllerPresenting>

@property(nonatomic, weak) ICSDrawerController *drawer;

@property (nonatomic, assign) int selectedIndexPath;

- (void)showMenu;

@end
