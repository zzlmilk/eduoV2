//
//  SLHomeStatusResult.h
//  02-pigBank
//
//  Created by 陆承东 on 14-10-11.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SLHomeStatus.h"

@interface SLHomeStatusResult : NSObject

/**
 *  statuses数组里面放的都是IWStatus模型
 */
@property (nonatomic, strong) NSArray *homeStatuses;

@end
