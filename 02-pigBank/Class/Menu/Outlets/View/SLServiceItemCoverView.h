//
//  SLServiceItemCoverView.h
//  02-pigBank
//
//  Created by 陆承东 on 14-10-17.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SLOutletsServiceItem.h"

@class SLServiceItemCoverView;

@protocol SLServiceItemCoverViewDelegate <NSObject>

@optional
- (void)serviceItemCoverView:(SLServiceItemCoverView *)serviceItemCoverView didSelectedServiceItem:(SLOutletsServiceItem *)serviceItem;

@end

@interface SLServiceItemCoverView : UIView

@property (nonatomic, strong) NSArray *serviceItemArray;

@property (nonatomic, weak) id<SLServiceItemCoverViewDelegate> delegate;

@end
