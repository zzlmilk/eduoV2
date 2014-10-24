//
//  SLMerchantDetailItem.h
//  02-pigBank
//
//  Created by 陆承东 on 14/10/23.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SLMerchantDetailFrame.h"

@interface SLMerchantDetailItem : NSObject

@property (assign, nonatomic) Class cellClass;
@property (nonatomic, strong) SLMerchantDetailFrame *merchantDetailFrame;

+ (instancetype)itemWithMerchantDetail:(SLMerchantDetailFrame *)merchantDetailFrame andCellClass:(Class)cellClass;

+ (instancetype)item;

@end
