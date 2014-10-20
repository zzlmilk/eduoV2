//
//  SLFinanceProductFrame.m
//  02-pigBank
//
//  Created by 陆承东 on 14-9-19.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLFinanceProductFrame.h"
#import "MJExtension.h"

#import "SLFinanceProduct.h"

#define basicButtonW 150

#define fengxi 2
#define fengxi2 4

@interface SLFinanceProductFrame()

@end

@implementation SLFinanceProductFrame

- (void)setFinanceProduct:(SLFinanceProduct *)financeProduct
{
    _financeProduct = financeProduct;
    
    [self setupFinanceProductFrame];
    
    
}

- (void)setupFinanceProductFrame
{
    /** scrollView */
    _scrollViewF = [UIScreen mainScreen].bounds;
    
    /** titleLabel */
    CGFloat titleLabelX = middleMargin;
    CGFloat titleLabelY = middleMargin;
    CGFloat titleLabelMaxW = _scrollViewF.size.width - middleMargin;
    CGSize titleLabelS = [self.financeProduct.title sizeWithFont:SLFinanceProductTitleFont constrainedToSize:CGSizeMake(titleLabelMaxW, CGFLOAT_MAX)];
    _titleLabelF = (CGRect){{titleLabelX, titleLabelY}, titleLabelS};
    
    /** dateLabel */
    CGFloat dateLabelX = middleMargin;
    CGFloat dateLabelY = CGRectGetMaxY(_titleLabelF);
    CGFloat dateLabelW = _scrollViewF.size.width * 0.5 - middleMargin;
    CGFloat dateLabelH = smallLabelHeight;
    _dateLabelF = CGRectMake(dateLabelX, dateLabelY, dateLabelW, dateLabelH);
    
    /** leftTimeLabel */
    CGFloat leftTimeLabelX = _scrollViewF.size.width * 0.5;
    CGFloat leftTimeLabelY = dateLabelY;
    CGFloat leftTimeLabelW = _scrollViewF.size.width * 0.5 - middleMargin;
    CGFloat leftTimeLabelH = smallLabelHeight;
    _leftTimeLabelF = CGRectMake(leftTimeLabelX, leftTimeLabelY, leftTimeLabelW, leftTimeLabelH);
    
    
    /** 图表区域整体的view */
    CGFloat chartViewX = middleMargin;
    CGFloat chartViewY = CGRectGetMaxY(_dateLabelF) + middleMargin;
    CGFloat chartViewW = _scrollViewF.size.width;
    
    /** currentInterestView 银行活期利息 */
    CGFloat currentInterestViewX = 0;
    CGFloat currentInterestViewY = middleMargin;
    CGFloat currentInterestViewW = _scrollViewF.size.width * 0.3;
    CGFloat currentInterestViewH = smallLabelHeight;
    _currentInterestViewF = CGRectMake(currentInterestViewX, currentInterestViewY, currentInterestViewW, currentInterestViewH);
    
    /** expEarningView 预期年化收益 */
    CGFloat expEarningViewX = _scrollViewF.size.width * 0.3 + middleMargin;
    CGFloat expEarningViewY = currentInterestViewY;
    CGFloat expEarningViewW = _scrollViewF.size.width * 0.3;
    CGFloat expEarningViewH = smallLabelHeight;
    _expEarningViewF = CGRectMake(expEarningViewX, expEarningViewY, expEarningViewW, expEarningViewH);
    
    /** multipleLabel */
    CGFloat multipleLabelW = _scrollViewF.size.width * 0.3;
    CGFloat multipleLabelH = expEarningViewY;
    CGFloat multipleLabelX = _scrollViewF.size.width * 0.3 * 2 + middleMargin;
    CGFloat multipleLabelY = middleMargin * 0.5;
    _multipleLabelF = CGRectMake(multipleLabelX, multipleLabelY, multipleLabelW, multipleLabelH);
    
    
    /** 收益对比图 */
    CGFloat comparisonViewX = 0;
    CGFloat comparisonViewY = CGRectGetMaxY(_currentInterestViewF);
    CGFloat comparisonViewW = 200;
    CGFloat comparisonViewH = 130; // _chartViewF.size.height - smallLabelHeight
    _comparisonViewF = CGRectMake(comparisonViewX, comparisonViewY, comparisonViewW, comparisonViewH);
    
    /** 期限按钮 */
    CGFloat deadlineButtonX = CGRectGetMaxX(_comparisonViewF);
    CGFloat deadlineButtonY = comparisonViewY + 5.5 +fengxi;
    CGFloat deadlineButtonW = shortButtonW;
    CGFloat deadlineButtonH = buttonH - fengxi2;
    _deadlineButtonF = CGRectMake(deadlineButtonX, deadlineButtonY, deadlineButtonW, deadlineButtonH);
    
    /** 期限数据按钮 */
    CGFloat deadlineDataButtonX = CGRectGetMaxX(_deadlineButtonF);
    CGFloat deadlineDataButtonY = deadlineButtonY;
    CGFloat deadlineDataButtonW = longButtonW;
    CGFloat deadlineDataButtonH = buttonH - fengxi2;
    _deadlineDataButtonF = CGRectMake(deadlineDataButtonX, deadlineDataButtonY, deadlineDataButtonW, deadlineDataButtonH);
    
    /** 风险按钮 */
    CGFloat riskButtonX = deadlineButtonX;
    CGFloat riskButtonY = CGRectGetMaxY(_deadlineButtonF) + fengxi2;
    CGFloat riskButtonW = shortButtonW;
    CGFloat riskButtonH = buttonH - fengxi2;
    _riskButtonF = CGRectMake(riskButtonX, riskButtonY, riskButtonW, riskButtonH);
    
    /** 风险数据按钮 */
    CGFloat riskDataButtonX = deadlineDataButtonX;
    CGFloat riskDataButtonY = riskButtonY;
    CGFloat riskDataButtonW = longButtonW;
    CGFloat riskDataButtonH = buttonH - fengxi2;
    _riskDataButtonF = CGRectMake(riskDataButtonX, riskDataButtonY, riskDataButtonW, riskDataButtonH);
    
    /** 起购额按钮 */
    CGFloat minBuyLimitButtonX = deadlineButtonX;
    CGFloat minBuyLimitButtonY = CGRectGetMaxY(_riskButtonF) + fengxi2;
    CGFloat minBuyLimitButtonW = shortButtonW;
    CGFloat minBuyLimitButtonH = buttonH - fengxi2;
    _minBuyLimitButtonF = CGRectMake(minBuyLimitButtonX, minBuyLimitButtonY, minBuyLimitButtonW, minBuyLimitButtonH);
    
    /** 起购额数据按钮 */
    CGFloat minBuyLimitDataButtonX = deadlineDataButtonX;
    CGFloat minBuyLimitDataButtonY = minBuyLimitButtonY;
    CGFloat minBuyLimitDataButtonW = longButtonW;
    CGFloat minBuyLimitDataButtonH = buttonH - fengxi2;
    _minBuyLimitDataButtonF = CGRectMake(minBuyLimitDataButtonX, minBuyLimitDataButtonY, minBuyLimitDataButtonW, minBuyLimitDataButtonH);
    
    /** 手续费按钮 */
    CGFloat feeButtonX = deadlineButtonX;
    CGFloat feeButtonY = CGRectGetMaxY(_minBuyLimitButtonF) + fengxi2;
    CGFloat feeButtonW = shortButtonW;
    CGFloat feeButtonH = buttonH - fengxi2;
    _feeButtonF = CGRectMake(feeButtonX, feeButtonY, feeButtonW, feeButtonH);
    
    /** 手续费数据按钮 */
    CGFloat feeDataButtonX = deadlineDataButtonX;
    CGFloat feeDataButtonY = feeButtonY;
    CGFloat feeDataButtonW = longButtonW;
    CGFloat feeDataButtonH = buttonH - fengxi2;
    _feeDataButtonF = CGRectMake(feeDataButtonX, feeDataButtonY, feeDataButtonW, feeDataButtonH);
    
    /** basicInfoButton */
    CGFloat basicInfoButtonX = 0;
    CGFloat basicInfoButtonY = CGRectGetMaxY(_comparisonViewF) + middleMargin;
    CGFloat basicInfoButtonW = basicButtonW;
    CGFloat basicInfoButtonH = 30;
    _basicInfoButtonF = CGRectMake(basicInfoButtonX, basicInfoButtonY, basicInfoButtonW, basicInfoButtonH);
    
    /** basicInfoButtonView */
    CGFloat basicInfoViewX = 0;
    CGFloat basicInfoViewY = CGRectGetMaxY(_basicInfoButtonF) + middleMargin;
    CGFloat basicInfoViewW = basicButtonW * 2;
    CGFloat basicInfoViewH = 100;
    _basicInfoViewF = CGRectMake(basicInfoViewX, basicInfoViewY, basicInfoViewW, basicInfoViewH);
    
    /** arriveTimeLabelF */
    CGFloat arriveTimeLabelX = 0;
    CGFloat arriveTimeLabelY = middleMargin * 0.5;
    CGSize arriveTimeLabelS = [@"到账时间:" sizeWithFont:SLDetailGrayLabelFont];
    _arriveTimeLabelF = (CGRect){{arriveTimeLabelX, arriveTimeLabelY}, arriveTimeLabelS};
    
    /** arriveTimeInfoLabelF */
    CGFloat arriveTimeInfoLabelX = CGRectGetMaxX(_arriveTimeLabelF);
    CGFloat arriveTimeInfoLabelY = arriveTimeLabelY;
    CGFloat arriveTimeInfoLabelW = chartViewW - middleMargin - arriveTimeInfoLabelX;
    CGFloat arriveTimeInfoLabelH = arriveTimeLabelS.height;
    _arriveTimeInfoLabelF = CGRectMake(arriveTimeInfoLabelX, arriveTimeInfoLabelY, arriveTimeInfoLabelW, arriveTimeInfoLabelH);
    //    CGSize arriveTimeInfoLabelS = [financeProduct.financialProductsDetail.extReceiptTimeType sizeWithFont:SLDetailGrayLabelFont];
    //    _arriveTimeInfoLabelF = (CGRect){{arriveTimeInfoLabelX, arriveTimeInfoLabelY}, arriveTimeInfoLabelS};
    
    /** assetManagerLabelF */
    CGFloat assetManagerLabelX = arriveTimeLabelX;
    CGFloat assetManagerLabelY = CGRectGetMaxY(_arriveTimeLabelF) + middleMargin;
    CGSize assetManagerLabelS = [@"资产管理人:" sizeWithFont:SLDetailGrayLabelFont];
    _assetManagerLabelF = (CGRect){{assetManagerLabelX, assetManagerLabelY}, assetManagerLabelS};
    
    /** assetManagerInfoLabelF */
    CGFloat assetManagerInfoLabelX = CGRectGetMaxX(_assetManagerLabelF);
    CGFloat assetManagerInfoLabelY = assetManagerLabelY;
    CGFloat assetManagerInfoLabelW = chartViewW - middleMargin - assetManagerInfoLabelX;
    CGFloat assetManagerInfoLabelH = assetManagerLabelS.height;
    _assetManagerInfoLabelF = CGRectMake(assetManagerInfoLabelX, assetManagerInfoLabelY, assetManagerInfoLabelW, assetManagerInfoLabelH);
//    CGSize assetManagerInfoLabelS = [financeProduct.financialProductsDetail.assetManager sizeWithFont:SLDetailGrayLabelFont];
//    _assetManagerInfoLabelF = (CGRect){{assetManagerInfoLabelX, assetManagerInfoLabelY}, assetManagerInfoLabelS};
    
    /** subscriptionTimeLabelF */
    CGFloat subscriptionTimeLabelX = assetManagerLabelX;
    CGFloat subscriptionTimeLabelY = CGRectGetMaxY(_assetManagerLabelF) + middleMargin;
    CGSize subscriptionTimeLabelS = [@"认购时间:" sizeWithFont:SLDetailGrayLabelFont];
    _subscriptionTimeLabelF = (CGRect){{subscriptionTimeLabelX, subscriptionTimeLabelY}, subscriptionTimeLabelS};
    
    /** subscriptionTimeInfoLabelF */
    CGFloat subscriptionTimeInfoLabelX = CGRectGetMaxX(_subscriptionTimeLabelF);
    CGFloat subscriptionTimeInfoLabelY = subscriptionTimeLabelY;
    CGFloat subscriptionTimeInfoLabelW = chartViewW - middleMargin - subscriptionTimeInfoLabelX;
    CGFloat subscriptionTimeInfoLabelH = subscriptionTimeLabelS.height;
    _subscriptionTimeInfoLabelF = CGRectMake(subscriptionTimeInfoLabelX, subscriptionTimeInfoLabelY, subscriptionTimeInfoLabelW, subscriptionTimeInfoLabelH);
    SLLog(@"%@", NSStringFromCGRect(_earningTimeLabelF));
//    // 转换时间
//    NSDate *subscriptionDateStart = [NSDate dateWithTimeIntervalSince1970: self.financeProduct.financialProductsDetail.subscribeStart / 1000];
//    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
//    [dateFormat setDateFormat:@"yyyy/MM/dd"];
//    NSString *subscribeStart = [dateFormat stringFromDate: subscriptionDateStart];
//    // 转换时间
//    NSDate *subscriptionDateEnd = [NSDate dateWithTimeIntervalSince1970: self.financeProduct.financialProductsDetail.subscribeEnd / 1000];
//    NSString *subscribeEnd = [dateFormat stringFromDate: subscriptionDateEnd];
//    NSString *subscriptionTime = [NSString stringWithFormat:@"%@ 至 %@", subscribeStart, subscribeEnd];
//    CGSize subscriptionTimeInfoLabelS = [subscriptionTime sizeWithFont:SLDetailGrayLabelFont];
//    _subscriptionTimeInfoLabelF = (CGRect){{subscriptionTimeInfoLabelX, subscriptionTimeInfoLabelY}, subscriptionTimeInfoLabelS};
    
    /** earningTimeLabelF */
    CGFloat earningTimeLabelX = subscriptionTimeLabelX;
    CGFloat earningTimeLabelY = CGRectGetMaxY(_subscriptionTimeLabelF) + middleMargin;
    CGSize earningTimeLabelS = [@"收益时间:" sizeWithFont:SLDetailGrayLabelFont];
    _earningTimeLabelF = (CGRect){{earningTimeLabelX, earningTimeLabelY}, earningTimeLabelS};
    
    /** earningTimeInfoLabelF */
    CGFloat earningTimeInfoLabelX = CGRectGetMaxX(_earningTimeLabelF);
    CGFloat earningTimeInfoLabelY = earningTimeLabelY;
    CGFloat earningTimeInfoLabelW = chartViewW - middleMargin - earningTimeInfoLabelX;
    CGFloat earningTimeInfoLabelH = earningTimeLabelS.height;
    _earningTimeInfoLabelF = CGRectMake(earningTimeInfoLabelX, earningTimeInfoLabelY, earningTimeInfoLabelW, earningTimeInfoLabelH);
//    // 转换时间
//    NSDate *earnDateStart = [NSDate dateWithTimeIntervalSince1970: self.financeProduct.financialProductsDetail.valueDateFrom / 1000];
//    NSString *earnStart = [dateFormat stringFromDate: earnDateStart];
//    // 转换时间
//    NSDate *earnDateEnd = [NSDate dateWithTimeIntervalSince1970: self.financeProduct.financialProductsDetail.valueDateTo / 1000];
//    NSString *earnEnd = [dateFormat stringFromDate: earnDateEnd];
//    NSString *earningTime = [NSString stringWithFormat:@"%@ 至 %@", earnStart, earnEnd];
//    CGSize earningTimeInfoLabelS = [earningTime sizeWithFont:SLDetailGrayLabelFont];
//    _earningTimeInfoLabelF = (CGRect){{earningTimeInfoLabelX, earningTimeInfoLabelY}, earningTimeInfoLabelS};
    
    /** expEarningCulButton */
    CGFloat expEarningCulButtonX = basicInfoButtonW;
    CGFloat expEarningCulButtonY = basicInfoButtonY;
    CGFloat expEarningCulButtonW = basicInfoButtonW;
    CGFloat expEarningCulButtonH = 30;
    _expEarningCulButtonF = CGRectMake(expEarningCulButtonX, expEarningCulButtonY, expEarningCulButtonW, expEarningCulButtonH);
    
    /** expEarningCulView */
    CGFloat expEarningCulViewX = 0;
    CGFloat expEarningCulViewY = CGRectGetMaxY(_basicInfoButtonF) + middleMargin;
    CGFloat expEarningCulViewW = basicButtonW * 2;
    CGFloat expEarningCulViewH = 100;
    _expEarningCulViewF = CGRectMake(expEarningCulViewX, expEarningCulViewY, expEarningCulViewW, expEarningCulViewH);
    
    /** moneyAmountTextFieldF */
    CGFloat moneyAmountTextFieldX = 0;
    CGFloat moneyAmountTextFieldY = 0;
    CGFloat moneyAmountTextFieldW = 90;
    CGFloat moneyAmountTextFieldH = 25;
    _moneyAmountTextFieldF = CGRectMake(moneyAmountTextFieldX, moneyAmountTextFieldY, moneyAmountTextFieldW, moneyAmountTextFieldH);
    
    /** moneyYuanLabelF */
    CGFloat moneyYuanLabelX = CGRectGetMaxX(_moneyAmountTextFieldF) + middleMargin * 0.5;
    CGFloat moneyYuanLabelY = moneyAmountTextFieldY;
    CGSize moneyYuanLabelS = [@"元" sizeWithFont:SLDetailGrayLabelFont];
    CGFloat moneyYuanLabelH = moneyAmountTextFieldH;
    _moneyYuanLabelF = CGRectMake(moneyYuanLabelX, moneyYuanLabelY, moneyYuanLabelS.width, moneyYuanLabelH);
    
    /** middleLabelF */
    CGFloat middleLabelX = CGRectGetMaxX(_moneyYuanLabelF) + middleMargin * 2;
    CGFloat middleLabelY = moneyYuanLabelY;
    long long days = (self.financeProduct.financialProductsDetail.valueDateTo - self.financeProduct.financialProductsDetail.valueDateFrom) / 1000 / 60 / 60 / 24;
    CGSize middleLabelS = [[NSString stringWithFormat:@"%lld天", days] sizeWithFont:SLDetailGrayLabelFont];
    CGFloat middleLabelH = moneyYuanLabelH;
    _middleLabelF = CGRectMake(middleLabelX, middleLabelY, middleLabelS.width, middleLabelH);
    
    /** equalLabelF */
    CGFloat equalLabelX = CGRectGetMaxX(_middleLabelF) + middleMargin * 2;
    CGFloat equalLabelY = middleLabelY;
    CGSize equalLabelS = [@"=" sizeWithFont:SLDetailGrayLabelFont];
    CGFloat equalLabelH = middleLabelH;
    _equalLabelF = CGRectMake(equalLabelX, equalLabelY, equalLabelS.width, equalLabelH);
    
    
    /** resultLabelF */
    CGFloat resultLabelX = CGRectGetMaxX(_equalLabelF);
    CGFloat resultLabelY = equalLabelY;
    CGFloat resultLabelW = 90;
    CGFloat resultLabelH = moneyAmountTextFieldH;
    _resultLabelF = CGRectMake(resultLabelX, resultLabelY, resultLabelW, resultLabelH);
    
    /** yuanLabelF */
    CGFloat yuanLabelX = CGRectGetMaxX(_resultLabelF);
    CGFloat yuanLabelY = resultLabelY;
    CGSize yuanLabelS = [@"元" sizeWithFont:SLDetailGrayLabelFont];
    _resultYuanLabelF = (CGRect){{yuanLabelX, yuanLabelY}, yuanLabelS};
    _resultYuanLabelF = CGRectMake(yuanLabelX, yuanLabelY, yuanLabelS.width, resultLabelH);
    
    /** calculateButtonF */
    CGFloat calculateButtonW = 150;
    CGFloat calculateButtonH = 30;
    CGFloat calculateButtonX = (_scrollViewF.size.width - middleMargin * 2) * 0.5 - calculateButtonW * 0.5;
    CGFloat calculateButtonY = CGRectGetMaxY(_moneyAmountTextFieldF) + middleMargin;
    _calculateButtonF = CGRectMake(calculateButtonX, calculateButtonY, calculateButtonW, calculateButtonH);
    
    /** attentionLabelF */
    CGFloat attentionLabelX = 0;
    CGFloat attentionLabelY = CGRectGetMaxY(_calculateButtonF) + middleMargin;
    CGFloat attentionLabelW = _scrollViewF.size.width - middleMargin * 2;
    CGFloat attentionLabelH = 15;
    _attentionLabelF = CGRectMake(attentionLabelX, attentionLabelY, attentionLabelW, attentionLabelH);
    
    
    /** detailInfoLabel */
    CGFloat detailInfoLabelX = 0;
    CGFloat detailInfoLabelY = CGRectGetMaxY(_basicInfoButtonF) + middleMargin * 2 + 100;
    CGFloat detailInfoLabelW = basicButtonW * 2;
    CGFloat detailInfoLabelH = 15;
    _detailInfoLabelF = CGRectMake(detailInfoLabelX, detailInfoLabelY, detailInfoLabelW, detailInfoLabelH);
    
    /** detailInfoLabelContent */
    CGFloat detailInfoContentLabelX = 0;
    CGFloat detailInfoContentLabelY = CGRectGetMaxY(_detailInfoLabelF) + middleMargin;
    CGSize detailInfoContentLabelS = [self.financeProduct.content sizeWithFont:SLDetailGrayLabelFont constrainedToSize:CGSizeMake(basicButtonW * 2, CGFLOAT_MAX)];
    _detailInfoContentLabelF = (CGRect){{detailInfoContentLabelX, detailInfoContentLabelY}, detailInfoContentLabelS};
    
    /** detailInfoContentWebViewF */
    CGFloat detailInfoContentWebViewX = 0;
    CGFloat detailInfoContentWebViewY = detailInfoContentLabelY;
    CGFloat detailInfoContentWebViewW = 0;
    CGFloat detailInfoContentWebViewH = 0;
    
    /** 图标区域整体的view */
    CGFloat chartViewH = CGRectGetMaxY(_detailInfoContentLabelF);
    _chartViewF = CGRectMake(chartViewX, chartViewY, chartViewW, chartViewH);
}

MJCodingImplementation

@end
