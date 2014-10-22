//
//  SLMerchantTypeCoverView.h
//  02-pigBank
//
//  Created by 陆承东 on 14/10/20.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SLChildrenScope.h"

@class SLMerchantTypeCoverView;

@protocol SLMerchantTypeCoverViewDelegate <NSObject>

@optional
- (void)merchantTypeCoverView:(SLMerchantTypeCoverView *)merchantTypeCoverView didSelectedChildrenScope:(SLChildrenScope *)childrenScope;

@end

@interface SLMerchantTypeCoverView : UIView

@property (nonatomic, strong) NSArray *merchantChildScopeArray;

@property (nonatomic, weak) id<SLMerchantTypeCoverViewDelegate> delegate;

@end
