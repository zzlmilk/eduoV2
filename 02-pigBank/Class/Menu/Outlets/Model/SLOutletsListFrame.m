//
//  SLOutletsListFrame.m
//  02-pigBank
//
//  Created by 陆承东 on 14-10-16.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLOutletsListFrame.h"

@implementation SLOutletsListFrame

- (void)setOutletsInfo:(SLOutletsInfo *)outletsInfo
{
    _outletsInfo = outletsInfo;
    
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
    
    /** titleLabelF */
    CGFloat titleLabelX = middleMargin;
    CGFloat titleLabelY = smallMargin;
    CGFloat titleLabelW = cellW - middleMargin * 2;
    CGFloat titleLabelH = 16;
    _titleLabelF = CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
    
    /** adressLabelF */
    CGFloat adressLabelX = middleMargin;
    CGFloat adressLabelY = CGRectGetMaxY(_titleLabelF) + smallMargin;
    CGFloat adressLabelW = cellW - middleMargin * 2 - 100;
    CGFloat adressLabelH = 14;
    _adressLabelF = CGRectMake(adressLabelX, adressLabelY, adressLabelW, adressLabelH);
    
    /** distanceLabelF */
    CGFloat distanceLabelX = CGRectGetMaxX(_adressLabelF) + smallMargin;
    CGFloat distanceLabelY = adressLabelY;
    CGFloat distanceLabelW = 100;
    CGFloat distanceLabelH = 14;
    _distanceLabelF = CGRectMake(distanceLabelX, distanceLabelY, distanceLabelW, distanceLabelH);
}

@end
