//
//  SLActivityDetailFrame.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/22.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SLActivityDetail.h"

@interface SLActivityDetailFrame : NSObject

@property (nonatomic, strong) SLActivityDetail *activityDetail;

@property (nonatomic, assign, readonly) CGFloat timeHeight;
@property (nonatomic, assign, readonly) CGFloat timeLabelHeight;
@property (nonatomic, assign, readonly) CGFloat addressHeight;

@end
