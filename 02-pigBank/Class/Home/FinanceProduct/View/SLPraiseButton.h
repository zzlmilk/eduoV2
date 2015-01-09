//
//  SLPraiseButton.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/8.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLPraiseButton : UIButton

+ (instancetype)button;

- (void)setMaterialId:(NSNumber *)materialId praiseCounts:(NSNumber *)praiseCounts praiseFlag:(NSNumber *)praiseFlag;
- (void)setMaterialId:(NSNumber *)materialId praiseFlag:(NSNumber *)praiseFlag;

- (void)setMerchantId:(NSNumber *)merchantId praiseCounts:(NSNumber *)praiseCounts praiseFlag:(NSNumber *)praiseFlag;
- (void)setMerchantId:(NSNumber *)merchantId praiseFlag:(NSNumber *)praiseFlag;

@end
