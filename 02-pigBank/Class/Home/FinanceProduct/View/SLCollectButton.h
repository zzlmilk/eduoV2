//
//  SLCollectButton.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/8.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLCollectButton : UIButton

+ (instancetype)button;

- (void)setMaterialId:(NSNumber *)materialId collectCounts:(NSNumber *)collectCounts collectFlag:(NSString *)collectFlag;
- (void)setMaterialId:(NSNumber *)materialId collectFlag:(NSString *)collectFlag;

- (void)setMerchantId:(NSNumber *)merchantId collectCounts:(NSNumber *)collectCounts collectFlag:(NSString *)collectFlag;
- (void)setMerchantId:(NSNumber *)merchantId collectFlag:(NSString *)collectFlag;

@end
