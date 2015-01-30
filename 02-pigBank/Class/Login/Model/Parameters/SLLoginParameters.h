//
//  SLLoginParameters.h
//  02-pigBank
//
//  Created by 陆承东 on 14-10-15.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

/*
 appCode	String
 clientInfo	String
 deviceInfo	String
 */

#import <Foundation/Foundation.h>

@interface SLLoginParameters : NSObject

/** mobile */
@property (nonatomic, copy) NSString *mobile;

/** password */
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *appCode;
@property (nonatomic, copy) NSString *clientInfo;
@property (nonatomic, copy) NSString *deviceInfo;


@end
