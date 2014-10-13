//
//  SLBaseParameters.h
//  02-pigBank
//
//  Created by 陆承东 on 14-10-11.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLBaseParameters : NSObject

/**
 *  采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得
 */
@property (nonatomic, copy) NSString *token;

@property (nonatomic, assign) NSNumber *uid;

+ (instancetype)parameters;

@end
