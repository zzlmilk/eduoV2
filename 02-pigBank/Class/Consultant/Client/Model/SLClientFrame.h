//
//  SLClientFrame.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/19.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SLClient.h"

@interface SLClientFrame : NSObject

@property (nonatomic, strong) SLClient *client;

@property (nonatomic, assign, readonly) CGRect iconImageViewF;
@property (nonatomic, assign, readonly) CGRect nameLabelF;
@property (nonatomic, assign, readonly) CGRect remarkLabelF;
@property (nonatomic, assign, readonly) CGRect separatorViewF;
@property (nonatomic, assign, readonly) CGRect attentionButtonF;

@end
