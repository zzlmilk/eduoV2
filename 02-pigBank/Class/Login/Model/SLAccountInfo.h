//
//  SLAccountInfo.h
//  02-pigBank
//
//  Created by 陆承东 on 14-9-26.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SLVipDetail.h"

@interface SLAccountInfo : NSObject

@property (nonatomic, copy) NSString *dispName;

@property (nonatomic, strong) NSNumber *mobile;

@property (nonatomic, strong) SLVipDetail *vipDetail ;

@end
