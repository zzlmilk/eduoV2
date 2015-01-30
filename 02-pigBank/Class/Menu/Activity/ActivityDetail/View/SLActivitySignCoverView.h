//
//  SLActivitySignCoverView.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/22.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SLActivityDetail.h"

@class SLActivitySignCoverView;

@protocol SLActivitySignCoverViewDelegate <NSObject>

@optional
- (void)activitySignCoverView:(SLActivitySignCoverView *)activitySignCoverView didClickedCancelButton:(UIButton *)cancelButton;
- (void)activitySignCoverView:(SLActivitySignCoverView *)activitySignCoverView didClickedCommitButton:(UIButton *)commitButton withName:(NSString *)name mobile:(NSString *)mobile;

@end

@interface SLActivitySignCoverView : UIView

@property (nonatomic, strong) SLActivityDetail *activityDetail;

@property (nonatomic, weak) id<SLActivitySignCoverViewDelegate> delegate;

@end
