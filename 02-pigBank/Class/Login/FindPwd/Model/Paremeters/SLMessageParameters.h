//
//  SLMessageParameters.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/20.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLMessageParameters : NSObject

@property (nonatomic, copy) NSString *mobile;

+ (instancetype)parameters;

@end
