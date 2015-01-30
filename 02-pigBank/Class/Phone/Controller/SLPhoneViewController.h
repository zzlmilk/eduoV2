//
//  SLPhoneViewController.h
//  02-pigBank
//
//  Created by 陆承东 on 14-9-13.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SLPhoneViewController;

@protocol SLPhoneViewControllerDelegate <NSObject>

@optional
- (void)phoneViewControllerDidPoped:(SLPhoneViewController *)phoneViewController;

@end

@interface SLPhoneViewController : UIViewController

@property (nonatomic, weak) id<SLPhoneViewControllerDelegate> delegate;

@end
