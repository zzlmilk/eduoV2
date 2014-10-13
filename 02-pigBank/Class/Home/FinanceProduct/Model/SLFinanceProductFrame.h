//
//  SLFinanceProductFrame.h
//  02-pigBank
//
//  Created by 陆承东 on 14-9-19.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SLFinanceProduct.h"


#define SLFinanceProductTitleFont [UIFont boldSystemFontOfSize:18]
#define SLFinanceProductContentFont [UIFont systemFontOfSize:11]
#define SLFinanceProductContentSmallFont [UIFont systemFontOfSize:9]
#define SLDetailGrayLabelFont [UIFont systemFontOfSize:13]
#define margin 10
#define smallLabelHeight 14
#define buttonH 26
#define shortButtonW 41
#define longButtonW 59

@interface SLFinanceProductFrame : NSObject

@property (nonatomic, strong) SLFinanceProduct *financeProduct;

/** scrollView */
@property (nonatomic, assign, readonly) CGRect scrollViewF;

/** titleLabel */
@property (nonatomic, assign, readonly) CGRect titleLabelF;

/** dateLabel */
@property (nonatomic, assign, readonly) CGRect dateLabelF;

/** leftTimeLabel */
@property (nonatomic, assign, readonly) CGRect leftTimeLabelF;


/** 图表区域整体的view */
@property (nonatomic, assign, readonly) CGRect chartViewF;

/** currentInterestButton */
@property (nonatomic, assign, readonly) CGRect currentInterestViewF;

/** expEarningButton */
@property (nonatomic, assign, readonly) CGRect expEarningViewF;

/** multipleLabel */
@property (nonatomic, assign, readonly) CGRect multipleLabelF;


/** 收益对比图 */
@property (nonatomic, assign, readonly) CGRect comparisonViewF;

/** 期限按钮 */
@property (nonatomic, assign, readonly) CGRect deadlineButtonF;

/** 期限数据按钮 */
@property (nonatomic, assign, readonly) CGRect deadlineDataButtonF;

/** 风险按钮 */
@property (nonatomic, assign, readonly) CGRect riskButtonF;

/** 风险数据按钮 */
@property (nonatomic, assign, readonly) CGRect riskDataButtonF;

/** 起购额按钮 */
@property (nonatomic, assign, readonly) CGRect minBuyLimitButtonF;

/** 起购额数据按钮 */
@property (nonatomic, assign, readonly) CGRect minBuyLimitDataButtonF;

/** 手续费按钮 */
@property (nonatomic, assign, readonly) CGRect feeButtonF;

/** 手续费数据按钮 */
@property (nonatomic, assign, readonly) CGRect feeDataButtonF;


/** basicInfoButton */
@property (nonatomic, assign, readonly) CGRect basicInfoButtonF;

/** basicInfoButtonView */
@property (nonatomic, assign, readonly) CGRect basicInfoViewF;


/** arriveTimeLabel */
@property (nonatomic, assign, readonly) CGRect arriveTimeLabelF;
/** arriveTimeInfoLabel */
@property (nonatomic, assign, readonly) CGRect arriveTimeInfoLabelF;
/** assetManagerLabel */
@property (nonatomic, assign, readonly) CGRect assetManagerLabelF;
/** assetManagerInfoLabel */
@property (nonatomic, assign, readonly) CGRect assetManagerInfoLabelF;
/** subscriptionTimeLabel */
@property (nonatomic, assign, readonly) CGRect subscriptionTimeLabelF;
/** subscriptionTimeInfoLabel */
@property (nonatomic, assign, readonly) CGRect subscriptionTimeInfoLabelF;
/** earningTimeLabel */
@property (nonatomic, assign, readonly) CGRect earningTimeLabelF;
/** earningTimeInfoLabel */
@property (nonatomic, assign, readonly) CGRect earningTimeInfoLabelF;


/** expEarningCulButton */
@property (nonatomic, assign, readonly) CGRect expEarningCulButtonF;

/** expEarningCulView */
@property (nonatomic, assign, readonly) CGRect expEarningCulViewF;

/** moneyAmountTextField */
@property (nonatomic, assign, readonly) CGRect moneyAmountTextFieldF;
/** moneyYuanLabelF */
@property (nonatomic, assign, readonly) CGRect moneyYuanLabelF;
/** middleLabelF */
@property (nonatomic, assign, readonly) CGRect middleLabelF;
/** equalLabelF */
@property (nonatomic, assign, readonly) CGRect equalLabelF;
/** resultLabel */
@property (nonatomic, assign, readonly) CGRect resultLabelF;
/** yuanLabel */
@property (nonatomic, assign, readonly) CGRect resultYuanLabelF;
/** calculateButton */
@property (nonatomic, assign, readonly) CGRect calculateButtonF;
/** attentionLabel */
@property (nonatomic, assign, readonly) CGRect attentionLabelF;

/** detailInfoLabel */
@property (nonatomic, assign, readonly) CGRect detailInfoLabelF;

/** detailInfoLabelContent */
@property (nonatomic, assign, readonly) CGRect detailInfoContentLabelF;

/** detailInfoContentWebViewF */
@property (nonatomic, assign, readonly) CGRect detailInfoContentWebViewF;


@end
