//
//  SLPostCommentView.h
//  02-pigBank
//
//  Created by 陆承东 on 14/10/27.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SLPostCommentView;

@protocol SLPostCommentViewDelegate <NSObject>

@optional
- (void)postCommentView:(SLPostCommentView *)postCommentView didClickPostCommentButton:(UIButton *)button;

@end

@interface SLPostCommentView : UIView

@property (nonatomic, weak) id<SLPostCommentViewDelegate> delegate;

@end