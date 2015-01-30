//
//  SLFinancialProductsListController.h
//  02-pigBank
//
//  Created by 陆承东 on 14-9-25.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SLFinancialProductsListController;

@protocol SLFinancialProductsListControllerDelegate <NSObject>

@optional
- (void)financialProductListController:(SLFinancialProductsListController *)financialProductListController didClickMoreButton:(UIBarButtonItem *)more;

@end

@interface SLFinancialProductsListController : UIViewController

@property (nonatomic, assign) NSInteger tag;

@property (nonatomic, weak) id<SLFinancialProductsListControllerDelegate> delegate;

@end
