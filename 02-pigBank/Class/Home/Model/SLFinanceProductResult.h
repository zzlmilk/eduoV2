//
//  SLFinanceProductResult.h
//  02-pigBank
//
//  Created by 陆承东 on 14-10-13.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLFinanceProductResult : NSObject

/**
 *  statuses数组里面放的都是financeProductFrame模型
 */
@property (nonatomic, strong) NSArray *financeProductFrames;

@end
