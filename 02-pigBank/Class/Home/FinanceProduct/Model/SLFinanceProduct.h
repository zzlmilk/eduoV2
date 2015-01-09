//
//  SLFinanceProduct.h
//  02-pigBank
//
//  Created by 陆承东 on 14-9-19.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SLFinancialProductsDetail.h"
#import "SLMaterialUser.h"

@interface SLFinanceProduct : NSObject

/** title 标题 */
@property (nonatomic, copy) NSString *title;

/** collectCounts 素材被收藏次数 */
@property (nonatomic, strong) NSNumber *collectCounts;

/** praiseCounts 素材被赞次数 */
@property (nonatomic, strong) NSNumber *praiseCounts;

/** financialProductsDetail */
@property (nonatomic, strong) SLFinancialProductsDetail *financialProductsDetail;

/** materialUser */
@property (nonatomic, strong) SLMaterialUser *materialUser;

/** content 内容 */
@property (nonatomic, copy) NSString *content;

/** verifyTime 开始时间 */
@property (nonatomic, strong) NSNumber *verifyTime;

/** plateId */
@property (nonatomic, strong) NSNumber *plateId;

@end
