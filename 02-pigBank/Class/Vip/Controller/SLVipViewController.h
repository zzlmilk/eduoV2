//
//  SLVipViewController.h
//  02-pigBank
//
//  Created by 陆承东 on 14-9-13.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SLVipViewController;

@protocol SLVipViewControllerDelegate <NSObject>

@optional
- (void)vipViewController:(SLVipViewController *)vipViewController didClickMoreButton:(UIBarButtonItem *)more;

@end

@interface SLVipViewController : UITableViewController

@property (nonatomic, weak) id<SLVipViewControllerDelegate> delegate;

@end
