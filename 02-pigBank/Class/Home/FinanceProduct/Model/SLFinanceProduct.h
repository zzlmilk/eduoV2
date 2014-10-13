//
//  SLFinanceProduct.h
//  02-pigBank
//
//  Created by 陆承东 on 14-9-19.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SLFinancialProductsDetail.h"

@interface SLFinanceProduct : NSObject


/** title 标题 */
@property (nonatomic, copy) NSString *title;
/** collectCounts 素材被收藏次数 */
@property (nonatomic, assign) long collectCounts;
/** praiseCounts 素材被赞次数 */
@property (nonatomic, assign) long praiseCounts;
/** financialProductsDetail */
@property (nonatomic, strong) SLFinancialProductsDetail *financialProductsDetail;
/** content 内容 */
@property (nonatomic, copy) NSString *content;
/** verifyTime 开始时间 */
@property (nonatomic, assign) long long verifyTime;

@end
