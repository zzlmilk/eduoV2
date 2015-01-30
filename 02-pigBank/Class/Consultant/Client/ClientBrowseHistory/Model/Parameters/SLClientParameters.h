//
//  SLClientParameters.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/21.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

/*
 userId	Long
 curPage	Integer
 pageSize	Integer
 */

#import "SLBaseParameters.h"

@interface SLClientParameters : SLBaseParameters

@property (nonatomic, strong) NSNumber *userId;
@property (nonatomic, strong) NSNumber *curPage;
@property (nonatomic, strong) NSNumber *pageSize;

@end
