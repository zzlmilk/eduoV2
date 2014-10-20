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

/** collectFlag */
@property (nonatomic, assign) int collectFlag;

/** firstReadTime */
@property (nonatomic, strong) NSNumber *firstReadTime;

/** firstReadTime */
@property (nonatomic, assign) int joinFlag;

/** firstReadTime */
@property (nonatomic, strong) NSNumber *lastReadTime;

/** firstReadTime */
@property (nonatomic, assign) int praiseFlag;

/** firstReadTime */
@property (nonatomic, assign) int readFlag;

/** firstReadTime */
@property (nonatomic, strong) NSNumber *readTimes;

@end
