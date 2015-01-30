//
//  SLConsultantListParameters.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/10.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

/*
 search
 pageSize
 curPage
 */

#import "SLBaseParameters.h"

@interface SLConsultantListParameters : SLBaseParameters

@property (nonatomic, copy) NSString *search;
@property (nonatomic, strong) NSNumber *pageSize;
@property (nonatomic, strong) NSNumber *curPage;

@end
