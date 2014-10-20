//
//  SLFinanceProductResult.m
//  02-pigBank
//
//  Created by 陆承东 on 14-10-13.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLFinanceProductResult.h"

#import "MJExtension.h"

#import "SLFinanceProductFrame.h"

@implementation SLFinanceProductResult

- (NSDictionary *)objectClassInArray
{
    return @{@"homeStatus" : [SLFinanceProductFrame class]};
}

@end
