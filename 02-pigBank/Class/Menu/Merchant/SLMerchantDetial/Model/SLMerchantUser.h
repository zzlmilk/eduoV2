//
//  SLMerchantUser.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/9.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

/*
 collectFlag = 1;
 collectTime = 1419239753973;
 merchantId = 49;
 praiseFlag = 0;
 userId = 147;
 */

#import <Foundation/Foundation.h>

@interface SLMerchantUser : NSObject

@property (nonatomic, strong) NSNumber *collectFlag;
@property (nonatomic, strong) NSNumber *collectTime;
@property (nonatomic, strong) NSNumber *merchantId;
@property (nonatomic, strong) NSNumber *praiseFlag;
@property (nonatomic, strong) NSNumber *userId;

@end
