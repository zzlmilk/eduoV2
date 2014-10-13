//
//  SLFinancialStatusFrame.h
//  02-pigBank
//
//  Created by 陆承东 on 14-9-27.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SLFinancialProductListStatus.h"
#import "SLFinanceProduct.h"


@interface SLFinancialStatusFrame : NSObject

@property (nonatomic, strong) SLFinancialProductListStatus *financialProductListStatus;

@property (nonatomic, strong) SLFinanceProduct *financeProduct;

/** extRiskLevelLabelF */
@property (nonatomic, assign, readonly) CGRect extRiskLevelLabelF;
/** titleLabelF */
@property (nonatomic, assign, readonly) CGRect titleLabelF;
/** deadlineLabelF */
@property (nonatomic, assign, readonly) CGRect deadlineLabelF;
/** deadlineDataLabelF */
@property (nonatomic, assign, readonly) CGRect deadlineDataLabelF;
/** leftTimeLabelF */
@property (nonatomic, assign, readonly) CGRect leftTimeLabelF;
/** leftTimeDataLabelF */
@property (nonatomic, assign, readonly) CGRect leftTimeDataLabelF;
/** expectedYieldLabelF */
@property (nonatomic, assign, readonly) CGRect expectedYieldLabelF;
/** expectedYieldDataLabelF */
@property (nonatomic, assign, readonly) CGRect expectedYieldDataLabelF;

/** cellHeight */
@property (nonatomic, assign, readonly) CGFloat cellHeight;

@end
