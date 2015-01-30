//
//  SLClientDetailFrame.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/24.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SLClientDetail.h"

@interface SLClientDetailFrame : NSObject

@property (nonatomic, assign, readonly) CGRect iconImageViewF;
@property (nonatomic, assign, readonly) CGRect nameLabelF;
@property (nonatomic, assign, readonly) CGRect gradeLabelF;
@property (nonatomic, assign, readonly) CGRect verticalSeparatorViewF;
@property (nonatomic, assign, readonly) CGRect attentionButtonF;
@property (nonatomic, assign, readonly) CGRect horizontalSeparatorViewFirstF;
@property (nonatomic, assign, readonly) CGRect remarkButtonF;
@property (nonatomic, assign, readonly) CGRect horizontalSeparatorViewSecondF;

@property (nonatomic, strong) SLClientDetail *clientDetail;

@end
