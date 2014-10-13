//
//  SLFinancialProductListTableHeadView.h
//  02-pigBank
//
//  Created by 陆承东 on 14-9-29.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SLFinancialProductListTableHeadView;

@protocol SLFinancialProductListTableHeadViewDelegate <NSObject>

@optional
- (void)financialProductListTableHeadView:(SLFinancialProductListTableHeadView *)financialProductListTableHeadView didClickExpectedYieldButton:(UIButton *)expectedYieldButton;
- (void)financialProductListTableHeadView:(SLFinancialProductListTableHeadView *)financialProductListTableHeadView didClickLeftTimeButton:(UIButton *)leftTimeButton;

@end

@interface SLFinancialProductListTableHeadView : UIView

@property (nonatomic, weak) id<SLFinancialProductListTableHeadViewDelegate> delegate;

@end
