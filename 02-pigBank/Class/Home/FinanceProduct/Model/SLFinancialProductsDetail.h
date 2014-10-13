//
//  SLFinancialProductsDetail.h
//  02-pigBank
//
//  Created by 陆承东 on 14-9-21.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLFinancialProductsDetail : NSObject


/** expectedYield 预期收益率 */
@property (nonatomic, copy) NSNumber *expectedYield;
/** extRiskLevel 风险等级 */
@property (nonatomic, copy) NSString *extRiskLevel;
/** extReceiptTimeType 到账时间类型 */
@property (nonatomic, copy) NSString *extReceiptTimeType;
/** minAmount 起购额 */
@property (nonatomic, assign) long minAmount;
/** managerRite 手续费 */
@property (nonatomic, assign) double managerRite;
/** valueDateFrom 起息日 */
@property (nonatomic, assign) long long valueDateFrom;
/** valueDateTo 到息日 */
@property (nonatomic, assign) long long valueDateTo;
/** assetManager 资产管理人 */
@property (nonatomic, copy) NSString *assetManager;
/** subscribeStart 认购开始时间 */
@property (nonatomic, assign) long long subscribeStart;
/** subscribeEnd 认购结束时间 */
@property (nonatomic, assign) long long subscribeEnd;

@end
