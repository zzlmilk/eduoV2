//
//  SLActivityList.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/20.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

/*
 address = "\U4e0a\U6d77\U957f\U5b81\U533a\U8679\U6865\U8def333\U53f7111\U5ba4";
 endTime = 1422690578000;
 isSign = 100;
 materialId = 271;
 recommendFlag = 0;
 signEndTime=1422604247000;
 startTime = 1422665373000;
 title = "\U6d3b\U52a8";
 */

#import <Foundation/Foundation.h>

@interface SLActivityList : NSObject

@property (nonatomic, copy) NSString *address;
@property (nonatomic, strong) NSNumber *endTime;
@property (nonatomic, strong) NSNumber *isSign;
@property (nonatomic, strong) NSNumber *materialId;
@property (nonatomic, copy) NSString *recommendFlag;
@property (nonatomic, strong) NSNumber *signEndTime;
@property (nonatomic, strong) NSNumber *startTime;
@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *activityTime;

@end
