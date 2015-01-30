//
//  SLActivityListParameters.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/20.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

/*
 plateId[必填]	Long
 classId[选填]	Long
 pageSize[选填]	Integer
 curPage[必填]	Integer
 */

#import "SLBaseParameters.h"

@interface SLActivityListParameters : SLBaseParameters

@property (nonatomic, strong) NSNumber *plateId;
@property (nonatomic, strong) NSNumber *classId;
@property (nonatomic, strong) NSNumber *pageSize;
@property (nonatomic, strong) NSNumber *curPage;

@property (nonatomic, assign) BOOL flag;

@end
