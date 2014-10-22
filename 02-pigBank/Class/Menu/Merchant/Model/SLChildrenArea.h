//
//  SLChildrenArea.h
//  02-pigBank
//
//  Created by 陆承东 on 14/10/21.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLChildrenArea : NSObject

@property (nonatomic, strong) NSNumber *areaId;

@property (nonatomic, strong) NSNumber *areaSort;

@property (nonatomic, copy) NSString *areaName;

@property (nonatomic, strong) NSMutableArray *childrenAreaList;

@end
