//
//  SLVipChildTableHeadView.h
//  02-pigBank
//
//  Created by 陆承东 on 14-10-15.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SLVipChildTableHeadView;

@protocol SLVipChildTableHeadViewDelegate <NSObject>

@optional
- (void)vipChildTableHeadView:(SLVipChildTableHeadView *)vipChildTableHeadView didClickLocalButton:(UIButton *)localButton;
- (void)vipChildTableHeadView:(SLVipChildTableHeadView *)vipChildTableHeadView didClickNationwideButton:(UIButton *)nationwideButton;

@end

@interface SLVipChildTableHeadView : UIView

@property (nonatomic, weak) id<SLVipChildTableHeadViewDelegate> delegate;

@end
