//
//  SLMaterial.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/21.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

/*
 collectFlag = 0;
 firstReadTime = 1411295576431;
 joinFlag = 0;
 lastReadTime = 1411295576431;
 materialId = 181;
 materialInfo ={};
 praiseFlag = 1;
 praiseTime = 1411295277213;
 readFlag = 1;
 readTimes = 1;
 userId = 143;
 */

#import <Foundation/Foundation.h>

#import "SLMaterialInfoInClient.h"

@interface SLMaterial : NSObject

@property (nonatomic, copy) NSString *collectFlag;
@property (nonatomic, strong) NSNumber *firstReadTime;
@property (nonatomic, copy) NSString *joinFlag;
@property (nonatomic, strong) NSNumber *lastReadTime;
@property (nonatomic, copy) NSString *lastReadTimeStr;
@property (nonatomic, strong) NSNumber *materialId;
@property (nonatomic, strong) SLMaterialInfoInClient *materialInfo;
@property (nonatomic, copy) NSString *praiseFlag;
@property (nonatomic, strong) NSNumber *praiseTime;
@property (nonatomic, copy) NSString *readFlag;
@property (nonatomic, strong) NSNumber *readTimes;
@property (nonatomic, strong) NSNumber *userId;

@end
