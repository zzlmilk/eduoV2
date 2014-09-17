//
//  SLAccount.h
//  02-pigBank
//
//  Created by 陆承东 on 14-9-16.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLAccount : NSObject<NSCoding>

@property (nonatomic, assign) long long code;
@property (nonatomic, strong) NSArray *info;
@property (nonatomic, copy) NSString *msg;
@property (nonatomic, assign) long long time;
@property (nonatomic, copy) NSString *token;
@property (nonatomic, assign) long long uid;
@property (nonatomic, strong) NSDate *expireTime;

//+ (instancetype)accountWithDict:(NSDictionary *)dict;
//- (instancetype)initWithDict:(NSDictionary *)dict;

@end
