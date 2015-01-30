//
//  SLMaterialUser.h
//  02-pigBank
//
//  Created by 陆承东 on 14-10-16.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 collectFlag = 0;
 firstReadTime = 1411013954076;
 joinFlag = 0;
 lastReadTime = 1411635946694;
 materialId = 263;
 praiseFlag = 0;
 readFlag = 1;
 readTimes = 75;
 userId = 147;
 */

@interface SLMaterialUser : NSObject

@property (nonatomic, copy) NSString *collectFlag;
@property (nonatomic, strong) NSNumber *firstReadTime;
@property (nonatomic, copy) NSString *joinFlag;
@property (nonatomic, strong) NSNumber *lastReadTime;
@property (nonatomic, strong) NSNumber *materialId;
@property (nonatomic, copy) NSString *praiseFlag;
@property (nonatomic, strong) NSNumber *praiseTime;
@property (nonatomic, copy) NSString *readFlag;
@property (nonatomic, strong) NSNumber *readTimes;
@property (nonatomic, strong) NSNumber *userId;

@end
