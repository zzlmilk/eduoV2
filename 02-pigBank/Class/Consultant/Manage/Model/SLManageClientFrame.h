//
//  SLManageClientFrame.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/28.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SLClient.h"

@interface SLManageClientFrame : NSObject

@property (nonatomic, strong) SLClient *client;

@property (nonatomic, assign, readonly) CGRect iconImageViewF;
@property (nonatomic, assign, readonly) CGRect nameLabelF;
@property (nonatomic, assign, readonly) CGRect priseImageViewF;
@property (nonatomic, assign, readonly) CGRect collectImageViewF;

@end
