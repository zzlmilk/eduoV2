//
//  SLRegisterBaseParameters.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/20.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

/*
 mobile	String
 name	String
 vercode	String
 invitation	String
 password	String
 appCode	String
 clientInfo	String
 deviceInfo	String
 */

#import <Foundation/Foundation.h>

@interface SLRegisterBaseParameters : NSObject

@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *vercode;
@property (nonatomic, copy) NSString *invitation;
@property (nonatomic, copy) NSString *cardNo;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *appCode;
@property (nonatomic, copy) NSString *clientInfo;
@property (nonatomic, copy) NSString *deviceInfo;

+ (instancetype)parameters;

@end
