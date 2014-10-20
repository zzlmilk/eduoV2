//
//  SLChildrenAreaList.h
//  02-pigBank
//
//  Created by 陆承东 on 14-10-17.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

/*
 {
 areaId = 7;
 areaName = "\U666e\U9640\U533a";
 areaSort = 3;
 preAreaId = 1;
 }
 */

#import <Foundation/Foundation.h>

@interface SLChildrenAreaList : NSObject

@property (nonatomic, strong) NSNumber *areaId;

@property (nonatomic, strong) NSNumber *areaSort;

@property (nonatomic, strong) NSNumber *preAreaId;

@property (nonatomic, copy) NSString *areaName;

@end
