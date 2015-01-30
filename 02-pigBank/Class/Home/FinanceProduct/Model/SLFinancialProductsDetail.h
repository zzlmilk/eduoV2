//
//  SLFinancialProductsDetail.h
//  02-pigBank
//
//  Created by 陆承东 on 14-9-21.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

/*
 assetManager = "\U6613\U6735\U94f6\U884c";
 compareStr = "\U6d3b\U671f\U94f6\U884c\U5229\U7387";
 compareValue = "0.35";
 expectedYield = "7.3";
 extProductSeries = "L\U7cfb\U5217\U4ea7\U54c1";
 extProductStruct = "\U4fdd\U672c\U975e\U4fdd\U6536\U76ca";
 extReceiptTimeType = "t+2 \U6216 t+3";
 extRiskLevel = "\U9ad8\U98ce\U9669";
 id = 80;
 managerRite = "0.2";
 materialId = 264;
 minAmount = 500000;
 pictureSmallUrl = "http://xynh.eduoinfo.com/resources/client/image/d1c956b3-df94-4377-9305-dc96de5e6662.jpg";
 pictureUrl = "http://xynh.eduoinfo.com/resources/client/image/d1c956b3-df94-4377-9305-dc96de5e6662.jpg";
 productCode = ZZGYCB0004;
 productSeries = 2;
 productStruct = 2;
 receiptTimeType = 2;
 riskLevel = "#ff0d15";
 subscribeEnd = 1414684800000;
 subscribeStart = 1407081600000;
 valueDateFrom = 1414771200000;
 valueDateTo = 1430409600000;
 */

#import <Foundation/Foundation.h>

@interface SLFinancialProductsDetail : NSObject

/** assetManager 资产管理人 */
@property (nonatomic, copy) NSString *assetManager;
@property (nonatomic, copy) NSString *compareStr;
@property (nonatomic, strong) NSNumber *compareValue;
/** expectedYield 预期收益率 */
@property (nonatomic, strong) NSNumber *expectedYield;
@property (nonatomic, copy) NSString *extProductSeries;
@property (nonatomic, copy) NSString *extProductStruct;
/** extReceiptTimeType 到账时间类型 */
@property (nonatomic, copy) NSString *extReceiptTimeType;
/** extRiskLevel 风险等级 */
@property (nonatomic, copy) NSString *extRiskLevel;
/** managerRite 手续费 */
@property (nonatomic, strong) NSNumber *managerRite;
@property (nonatomic, strong) NSNumber *materialId;
/** minAmount 起购额 */
@property (nonatomic, strong) NSNumber *minAmount;
@property (nonatomic, copy) NSString *pictureSmallUrl;
@property (nonatomic, copy) NSString *pictureUrl;
@property (nonatomic, copy) NSString *productCode;
@property (nonatomic, copy) NSString *productSeries;
@property (nonatomic, copy) NSString *productStruct;
@property (nonatomic, copy) NSString *receiptTimeType;
/** subscribeStart 认购开始时间 */
@property (nonatomic, strong) NSNumber *subscribeStart;
/** subscribeEnd 认购结束时间 */
@property (nonatomic, strong) NSNumber *subscribeEnd;
/** valueDateFrom 起息日 */
@property (nonatomic, strong) NSNumber *valueDateFrom;
/** valueDateTo 到息日 */
@property (nonatomic, strong) NSNumber *valueDateTo;

@end
