//
//  SLTabBarViewController.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/12.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLTabBarViewController : UITabBarController

@property (nonatomic, assign) NSUInteger lastSelectedIndex;

@property (nonatomic, strong) NSArray *plateInfoListArray;

+ (SLTabBarViewController *)sharedTabbarController;
- (void)dead;

@end
