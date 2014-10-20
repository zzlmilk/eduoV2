//
//  SLOutletsServiceArea.h
//  02-pigBank
//
//  Created by 陆承东 on 14-10-17.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

/*
 {
 areaId = 1; 传递
 areaName = "\U4e0a\U6d77";
 areaSort = 1;
 childrenAreaList = (
 {
 areaId = 5;
 areaName = "\U5f90\U6c47\U533a";
 areaSort = 1;
 preAreaId = 1;
 },
 {
 areaId = 6;
 areaName = "\U9ec4\U6d66\U533a";
 areaSort = 2;
 preAreaId = 1;
 },
 {
 areaId = 7;
 areaName = "\U666e\U9640\U533a";
 areaSort = 3;
 preAreaId = 1;
 }
 );
 },
 */

#import <Foundation/Foundation.h>

@interface SLOutletsServiceArea : NSObject

@property (nonatomic, strong) NSNumber *areaId;

@property (nonatomic, strong) NSNumber *areaSort;

@property (nonatomic, copy) NSString *areaName;

@property (nonatomic, strong) NSMutableArray *childrenAreaList;

@end
