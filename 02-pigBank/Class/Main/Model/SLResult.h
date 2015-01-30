//
//  SLResult.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/9.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLResult : NSObject

@property (nonatomic, copy) NSString *code;
@property (nonatomic, strong) NSArray *info;
@property (nonatomic, copy) NSString *msg;
@property (nonatomic, strong) NSNumber *time;

@end
