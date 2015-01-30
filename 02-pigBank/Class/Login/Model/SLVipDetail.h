//
//  SLVipDetail.h
//  02-pigBank
//
//  Created by 陆承东 on 14-9-29.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

/*
 levelSign = 1;
 levelSignText = "\U94bb\U77f3\U4f1a\U5458";
 userConsultant = 195;
 userId = 147;
 vipNumber = 559467339;
 */

#import <Foundation/Foundation.h>

@interface SLVipDetail : NSObject

@property (nonatomic, copy) NSString *levelSign;
@property (nonatomic, copy) NSString *levelSignText;
@property (nonatomic, strong) NSNumber *userConsultant;
@property (nonatomic, strong) NSNumber *userId;
@property (nonatomic, copy) NSString *vipNumber;

@end
