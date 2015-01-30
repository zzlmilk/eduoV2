//
//  SLSubscribeListParameters.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/23.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import "SLBaseParameters.h"

@interface SLSubscribeListParameters : SLBaseParameters

@property (nonatomic, strong) NSNumber *pageSize;
@property (nonatomic, strong) NSNumber *curPage;

@end
