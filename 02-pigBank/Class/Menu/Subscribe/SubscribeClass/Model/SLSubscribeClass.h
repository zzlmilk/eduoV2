//
//  SLSubscribeClass.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/23.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

/*
 isChk = 100;
 labelName = "\U671f\U8d27";
 labelSort = 1;
 slId = 1;
 */

#import <Foundation/Foundation.h>

@interface SLSubscribeClass : NSObject

@property (nonatomic, strong) NSNumber *isChk;
@property (nonatomic, copy) NSString *labelName;
@property (nonatomic, strong) NSNumber *labelSort;
@property (nonatomic, strong) NSNumber *slId;

@end
