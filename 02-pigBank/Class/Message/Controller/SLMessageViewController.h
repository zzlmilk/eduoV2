//
//  SLMessageViewController.h
//  02-pigBank
//
//  Created by 陆承东 on 14-9-13.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SLMessageViewController;

@protocol SLMessageViewControllerDelegate <NSObject>

@optional
- (void)messageViewController:(SLMessageViewController *)messageViewController didPopWithFlag:(BOOL)flag;

@end

@interface SLMessageViewController : UIViewController

@property (nonatomic, copy) NSString *from;

@property (nonatomic, weak) id<SLMessageViewControllerDelegate> delegate;

@end
