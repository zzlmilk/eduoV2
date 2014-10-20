//
//  SLOutletsTableHeadView.h
//  02-pigBank
//
//  Created by 陆承东 on 14-10-16.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SLRotateButton.h"

@class SLOutletsTableHeadView;

@protocol SLOutletsTableHeadViewDelegate <NSObject>

@optional
- (void)outletsTableHeadView:(SLOutletsTableHeadView *)vipChildTableHeadView didClickServiceItemButton:(UIButton *)serviceItemButton;
- (void)outletsTableHeadView:(SLOutletsTableHeadView *)vipChildTableHeadView didClickServiceAreaButton:(UIButton *)serviceAreaButton;

@end

@interface SLOutletsTableHeadView : UIView

/** serviceItemButton 服务项目 */
@property (nonatomic, weak) SLRotateButton *serviceItemButton;
/** serviceAreaButton 服务区域 */
@property (nonatomic, weak) SLRotateButton *serviceAreaButton;

@property (nonatomic, weak) id<SLOutletsTableHeadViewDelegate> delegate;

@end
