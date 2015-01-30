//
//  SLSubscribeDetail.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/23.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLSubscribeDetail : NSObject

@property (nonatomic, copy) NSString *content;
@property (nonatomic, strong) NSNumber *insertTime;
@property (nonatomic, copy) NSString *insertTimeStr;
@property (nonatomic, strong) NSNumber *insertUser;
@property (nonatomic, copy) NSString *labelName;
@property (nonatomic, copy) NSString *pictureSmallUrl;
@property (nonatomic, copy) NSString *pictureUrl;
@property (nonatomic, strong) NSNumber *siId;
@property (nonatomic, strong) NSNumber *slId;
@property (nonatomic, strong) NSNumber *status;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSNumber *updateTime;
@property (nonatomic, copy) NSString *updateTimeStr;
@property (nonatomic, strong) NSNumber *updater;

@end
