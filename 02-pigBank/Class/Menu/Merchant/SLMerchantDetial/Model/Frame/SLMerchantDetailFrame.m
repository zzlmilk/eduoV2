//
//  SLMerchantDetailFrame.m
//  02-pigBank
//
//  Created by 陆承东 on 14/10/23.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLMerchantDetailFrame.h"

@implementation SLMerchantDetailFrame

- (id)init
{
    if (self = [super init]) {
        _merchantHeadCellFrame = [[SLMerchantHeadCellFrame alloc] init];
        _merchantPhotoFrame = [[SLMerchantPhotosFrame alloc] init];
    }
    return self;
}

- (void)setMerchantDetail:(SLMerchantDetail *)merchantDetail
{
    _merchantDetail = merchantDetail;
    
    [self initMerchantHeadCellFrame];
    
    [self initMerchantPhotoFrame];
}

- (void)initMerchantHeadCellFrame
{
    CGFloat iconImageViewX = middleMargin;
    CGFloat iconImageViewY = middleMargin;
    CGFloat iconImageViewW = 66;
    CGFloat iconImageViewH = 50;
    _merchantHeadCellFrame.iconImageViewF = CGRectMake(iconImageViewX, iconImageViewY, iconImageViewW, iconImageViewH);
    
    CGFloat titleLabelX = CGRectGetMaxX(self.merchantHeadCellFrame.iconImageViewF) + middleMargin;
    CGFloat titleLabelY = iconImageViewY + 6;
    CGFloat titleLabelW = screenW - iconImageViewW - 2 *middleMargin;
    CGFloat titleLabelH = 20;
    _merchantHeadCellFrame.titleLabelF = CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
    
    CGFloat subTitleLabelX = titleLabelX;
    CGFloat subTitleLabelY = CGRectGetMaxY(self.merchantHeadCellFrame.titleLabelF) + smallMargin;
    CGFloat subTitleLabelW = screenW - iconImageViewW - 2 *middleMargin;
    CGFloat subTitleLabelH = 15;
    CGRect subTitleLabelF = CGRectMake(subTitleLabelX, subTitleLabelY, subTitleLabelW, subTitleLabelH);
    _merchantHeadCellFrame.subTitleLabelF = subTitleLabelF;
    
    _merchantHeadCellFrame.cellHeight = CGRectGetMaxY(self.merchantHeadCellFrame.iconImageViewF) + middleMargin;
}

- (void)initMerchantPhotoFrame
{
    _merchantPhotoFrame.cellHeight = 90;
}

@end
