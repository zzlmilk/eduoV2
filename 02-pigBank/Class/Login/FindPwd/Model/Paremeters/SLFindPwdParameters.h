//
//  SLFindPwdParameters.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/20.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

/*
 mobile
 vercode
 password
 */

#import <Foundation/Foundation.h>

@interface SLFindPwdParameters : NSObject

@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *vercode;
@property (nonatomic, copy) NSString *password;

+ (instancetype)parameters;

@end
