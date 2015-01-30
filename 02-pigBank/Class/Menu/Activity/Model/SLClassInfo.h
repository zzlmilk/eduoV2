//
//  SLClassInfo.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/22.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SLFirstMaterialInfo.h"

@interface SLClassInfo : NSObject

@property (nonatomic, strong) NSNumber *classId;
@property (nonatomic, copy) NSString *className;
@property (nonatomic, strong) NSNumber *classSort;
@property (nonatomic, copy) NSString *dispName;
@property (nonatomic, strong) SLFirstMaterialInfo *firstMaterialInfo;
@property (nonatomic, strong) NSNumber *insertTime;
@property (nonatomic, strong) NSNumber *insertUser;
@property (nonatomic, copy) NSString *pictureUrl;
@property (nonatomic, strong) NSNumber *plateId;
@property (nonatomic, strong) NSNumber *updateTime;
@property (nonatomic, strong) NSNumber *updateUser;
@property (nonatomic, copy) NSString *usedFlag;

@end
