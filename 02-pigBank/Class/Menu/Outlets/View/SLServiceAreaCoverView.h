//
//  SLServiceAreaCoverView.h
//  02-pigBank
//
//  Created by 陆承东 on 14-10-17.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SLChildrenAreaList.h"

@class SLServiceAreaCoverView;

@protocol SLServiceAreaCoverViewDelegate <NSObject>

@optional
- (void)serviceAreaCoverView:(SLServiceAreaCoverView *)serviceAreaCoverView didSelectedChildrenArea:(SLChildrenAreaList *)childrenArea;

@end

@interface SLServiceAreaCoverView : UIView

@property (nonatomic, strong) NSArray *serviceAreaArray;

@property (nonatomic, weak) id<SLServiceAreaCoverViewDelegate> delegate;

@end
