//
//  SLBaseParameters.m
//  02-pigBank
//
//  Created by 陆承东 on 14-10-11.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLBaseParameters.h"
#import "SLAccount.h"
#import "SLAccountTool.h"

@implementation SLBaseParameters

- (id)init
{
    if (self = [super init]) {
        SLAccount *account = [SLAccountTool getAccount];
        self.token = account.token;
        self.uid = account.uid;
    }
    return self;
}

+ (instancetype)parameters
{
    return [[self alloc] init];
}

@end
