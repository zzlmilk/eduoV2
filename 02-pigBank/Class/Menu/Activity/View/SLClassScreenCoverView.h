//
//  SLClassScreenCoverView.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/22.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SLClassScreenCoverView;

@protocol SLClassScreenCoverViewDelegate <NSObject>

@optional
- (void)classScreenCoverView:(SLClassScreenCoverView *)classScreenCoverView didSelectedClassId:(NSNumber *)classId;
- (void)classScreenCoverViewDidTouchCoverView:(SLClassScreenCoverView *)classScreenCoverView;

@end

@interface SLClassScreenCoverView : UIView

@property (nonatomic, strong) NSArray *classesArray;

@property (nonatomic, weak) id<SLClassScreenCoverViewDelegate> delegate;

@end
