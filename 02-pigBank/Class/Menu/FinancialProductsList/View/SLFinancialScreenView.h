//
//  SLFinancialScreenView.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/19.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SLFinancialScreenView;

@protocol SLFinancialScreenViewDelegate <NSObject>

@optional
- (void)financialScreenView:(SLFinancialScreenView *)financialScreenView didSelectedClassId:(NSNumber *)classId;
- (void)financialScreenViewDidTouchCoverView:(SLFinancialScreenView *)financialScreenView;

@end

@interface SLFinancialScreenView : UIView

@property (nonatomic, strong) NSArray *financialProductClassArray;

@property (nonatomic, weak) id<SLFinancialScreenViewDelegate> delegate;

@end
