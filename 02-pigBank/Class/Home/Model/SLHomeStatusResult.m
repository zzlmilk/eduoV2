//
//  SLHomeStatusResult.m
//  02-pigBank
//
//  Created by 陆承东 on 14-10-11.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLHomeStatusResult.h"

#import "MJExtension.h"
#import "SLHomeStatus.h"


@implementation SLHomeStatusResult

- (NSDictionary *)objectClassInArray
{
    return @{@"homeStatus" : [SLHomeStatus class]};
}

@end
