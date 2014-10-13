//
//  SLFinancialStatusFrame.m
//  02-pigBank
//
//  Created by 陆承东 on 14-9-27.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLFinancialStatusFrame.h"

#define ratio 0.75

#define leftW 200
#define rightW 100

@implementation SLFinancialStatusFrame

- (void)setFinanceProduct:(SLFinanceProduct *)financeProduct
{
    _financeProduct = financeProduct;
    
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
    
    /** extRiskLevelLabelF */
    CGFloat extRiskLevelLabelX = middleMargin;
    CGFloat extRiskLevelLabelY = middleMargin;
    CGFloat extRiskLevelLabelW = 40;
    CGFloat extRiskLevelLabelH = 15;
    _extRiskLevelLabelF = CGRectMake(extRiskLevelLabelX, extRiskLevelLabelY, extRiskLevelLabelW, extRiskLevelLabelH);
    
    /** titleLabelF */
    CGFloat titleLabelX = CGRectGetMaxX(_extRiskLevelLabelF) + smallMargin;
    CGFloat titleLabelW = leftW - titleLabelX;
    CGFloat titleLabelH = 15;
    CGFloat titleLabelY = extRiskLevelLabelY + (extRiskLevelLabelH - titleLabelH) * 0.5;
    _titleLabelF = CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
    
    /** deadlineLabelF */
    CGFloat deadlineLabelX = extRiskLevelLabelX;
    CGFloat deadlineLabelY = CGRectGetMaxY(_titleLabelF) + smallMargin;
    CGSize deadlineLabelS = [@"期限:" sizeWithFont:SLFont13];
    //    CGFloat deadlineLabelW = 30;
    //    CGFloat deadlineLabelH = titleLabelH;
    _deadlineLabelF = (CGRect){{deadlineLabelX, deadlineLabelY}, deadlineLabelS};
    
    /** deadlineDataLabelF */
    CGFloat deadlineDataLabelX = CGRectGetMaxX(_deadlineLabelF) + 1;
    CGFloat deadlineDataLabelY = deadlineLabelY;
    CGFloat deadlineDataLabelW = 100;
    CGFloat deadlineDataLabelH = titleLabelH;
    _deadlineDataLabelF = CGRectMake(deadlineDataLabelX, deadlineDataLabelY, deadlineDataLabelW, deadlineDataLabelH);
    
    /** leftTimeLabelF */
    CGFloat leftTimeLabelX = deadlineLabelX;
    CGFloat leftTimeLabelY = CGRectGetMaxY(_deadlineLabelF) + smallMargin;
    CGSize leftTimeLabelS = [@"认购时间剩余:" sizeWithFont:SLFont13];
    //    CGFloat leftTimeLabelW = 100;
    //    CGFloat leftTimeLabelH = deadlineLabelH;
    _leftTimeLabelF = (CGRect){{leftTimeLabelX, leftTimeLabelY}, leftTimeLabelS};
    
    /** leftTimeDataLabelF */
    CGFloat leftTimeDataLabelX = CGRectGetMaxX(_leftTimeLabelF) + 1;
    CGFloat leftTimeDataLabelY = leftTimeLabelY;
    CGFloat leftTimeDataLabelW = 100;
    CGFloat leftTimeDataLabelH = deadlineDataLabelH;
    _leftTimeDataLabelF = CGRectMake(leftTimeDataLabelX, leftTimeDataLabelY, leftTimeDataLabelW, leftTimeDataLabelH);
    
    /** expectedYieldDataLabelF */
    CGFloat expectedYieldDataLabelX = cellW - middleMargin - rightW;
    CGFloat expectedYieldDataLabelY = middleMargin;
    CGFloat expectedYieldDataLabelW = rightW;
    CGFloat expectedYieldDataLabelH = 30;
    _expectedYieldDataLabelF = CGRectMake(expectedYieldDataLabelX, expectedYieldDataLabelY, expectedYieldDataLabelW, expectedYieldDataLabelH);
    
    /** expectedYieldLabelF */
    CGFloat expectedYieldLabelX = expectedYieldDataLabelX;
    CGFloat expectedYieldLabelY = CGRectGetMaxY(_expectedYieldDataLabelF) + middleMargin;
    CGFloat expectedYieldLabelW = rightW;
    CGFloat expectedYieldLabelH = 15;
    _expectedYieldLabelF = CGRectMake(expectedYieldLabelX, expectedYieldLabelY, expectedYieldLabelW, expectedYieldLabelH);
    
    _cellHeight = CGRectGetMaxY(_expectedYieldLabelF) + middleMargin;
}

@end
