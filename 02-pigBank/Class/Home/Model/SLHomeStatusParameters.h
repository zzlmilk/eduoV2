//
//  SLHomeStatusParameters.h
//  02-pigBank
//
//  Created by 陆承东 on 14-10-11.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//  封装home页面的状态网络请求参数

#import "SLBaseParameters.h"

@interface SLHomeStatusParameters : SLBaseParameters

/**
 *  单页返回的记录条数，最大不超过100，默认为20。
 */
@property (nonatomic, strong) NSNumber *pageSize;

/**
 *  当前页
 */
@property (nonatomic, strong) NSNumber *curPage;

@property (nonatomic, copy) NSString *search;

@end
