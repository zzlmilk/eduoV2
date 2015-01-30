//
//  SLClientListParameters.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/19.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

/*
 search	String
 curPage	Integer
 pageSize	Integer
 */

#import "SLBaseParameters.h"

@interface SLClientListParameters : SLBaseParameters

@property (nonatomic, copy) NSString *search;
@property (nonatomic, strong) NSNumber *curPage;
@property (nonatomic, strong) NSNumber *pageSize;

@end
