//
//  SLVipStatus.h
//  02-pigBank
//
//  Created by 陆承东 on 14-9-23.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SLVipStatusFirstMaterialInfo.h"

#define SLVipStatusTitleFont [UIFont boldSystemFontOfSize:14]
#define SLVipStatusPraiseCountsFont [UIFont systemFontOfSize:12]

@interface SLVipStatus : NSObject

/** className */
@property (nonatomic, copy) NSString *className;

/** firstMaterialInfo */
@property (nonatomic, strong) SLVipStatusFirstMaterialInfo *firstMaterialInfo;


@end
