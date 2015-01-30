//
//  SLTagSelectView.h
//  carPark
//
//  Created by 陆承东 on 14/12/24.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SLScreenButton.h"

@class SLTagSelectView;

@protocol SLTagSelectViewDelegate <NSObject>

@optional
- (void)tagSelectedView:(SLTagSelectView *)tagSelectedView didSelectedTags:(NSArray *)selectedTags;
- (void)tagSelectedView:(SLTagSelectView *)tagSelectedView didSelectedScreenButton:(SLScreenButton *)screenButton;

@end

@interface SLTagSelectView : UIView

- (void)addTagWidth:(CGFloat)width tagStrArray:(NSArray *)tagStrArray;

- (CGFloat)getHeight;

@property (nonatomic, weak) id<SLTagSelectViewDelegate> delegate;

@end
