//
//  SLOutletsServiceArea.m
//  02-pigBank
//
//  Created by 陆承东 on 14-10-17.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLOutletsServiceArea.h"

@implementation SLOutletsServiceArea

- (NSMutableArray *)childrenAreaList
{
    if (_childrenAreaList == nil) {
        _childrenAreaList = [NSMutableArray array];
    }
    return _childrenAreaList;
}

@end
