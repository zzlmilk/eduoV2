//
//  SLMenuViewController.h
//  02-pigBank
//
//  Created by 陆承东 on 14-9-25.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ICSDrawerController.h"

@class SLMenuViewController;

@protocol SLMenuViewControllerDelegate <NSObject>

@optional
- (void)menuViewController:(SLMenuViewController *)menuViewController didClickMoreButton:(UIBarButtonItem *)more;

@end

@interface SLMenuViewController : UITableViewController

@property (nonatomic, weak) id<SLMenuViewControllerDelegate> delegate;

@end
