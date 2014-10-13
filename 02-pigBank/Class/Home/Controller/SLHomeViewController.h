//
//  SLHomeViewController.h
//  02-pigBank
//
//  Created by 陆承东 on 14-9-13.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ICSDrawerController.h"
@class SLHomeViewController;

@protocol SLHomeViewControllerDelegate <NSObject>

@optional
- (void)homeViewController:(SLHomeViewController *)homeViewController didClickMoreButton:(UIBarButtonItem *)more;

@end

@interface SLHomeViewController : UITableViewController<ICSDrawerControllerChild, ICSDrawerControllerPresenting>

@property(nonatomic, weak) ICSDrawerController *drawer;

@property (nonatomic, weak) id<SLHomeViewControllerDelegate> delegate;

@end
