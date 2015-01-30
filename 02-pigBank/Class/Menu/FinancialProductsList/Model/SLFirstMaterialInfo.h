//
//  SLFirstMaterialInfo.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/19.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SLFinancialProductsDetail.h"

/*
 
 classId = 5;
 collectCounts = 5;
 content = "<p> </p>";
 financialProductsDetail = { };
 materialId = 262;
 plateId = 2;
 praiseCounts = 6;
 publishModel = 1;
 recommendFlag = 0;
 searchKey = "\U7406\U8d22\U4ea7\U54c1";
 status = 1;
 templetType = 3;
 title = "\U6613\U6735\U94f6\U884c\U7406\U8d22\U4e4b\U9f0e\U9f0e\U6210\U91d168267\U53f7\U7406\U8d22\U8ba1\U5212";
 verifyStatus = 1;
 verifyTime = 1408091890243;
 
 */

@interface SLFirstMaterialInfo : NSObject

@property (nonatomic, strong) NSNumber *classId;
@property (nonatomic, strong) NSNumber *collectCounts;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, strong) SLFinancialProductsDetail *financialProductsDetail;
@property (nonatomic, strong) NSNumber *materialId;
@property (nonatomic, strong) NSNumber *plateId;
@property (nonatomic, strong) NSNumber *praiseCounts;
@property (nonatomic, copy) NSString *publishModel;
@property (nonatomic, copy) NSString *recommendFlag;
@property (nonatomic, copy) NSString *searchKey;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *templetType;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *verifyStatus;
@property (nonatomic, strong) NSNumber *verifyTime;

@end
