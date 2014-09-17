//
//  SLTabBar.h
//  02-pigBank
//
//  Created by 陆承东 on 14-9-14.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SLTabBar;

@protocol SLTabBarDelegate <NSObject>

@optional
- (void)tabBar:(SLTabBar *)tabBar didSelectedFrom:(int)from to:(int)to;

@end

@interface SLTabBar : UIView

- (void)addTabBarButtonWithItem:(UITabBarItem *)item;
@property (nonatomic, weak) id<SLTabBarDelegate> delegate;

@end
