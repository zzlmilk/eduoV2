//
//  SLClientDetailFrame.m
//  02-pigBank
//
//  Created by 陆承东 on 15/1/24.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import "SLClientDetailFrame.h"

#import "NSString+S_LINE.h"

@implementation SLClientDetailFrame

- (void)setClientDetail:(SLClientDetail *)clientDetail
{
    _clientDetail = clientDetail;
    
    CGFloat iconImageViewX = middleMargin;
    CGFloat iconImageViewY = middleMargin;
    CGFloat iconImageViewW = 50;
    CGFloat iconImageViewH = iconImageViewW;
    _iconImageViewF = CGRectMake(iconImageViewX, iconImageViewY, iconImageViewW, iconImageViewH);
    
    CGFloat attentionButtonW = 60;
    CGFloat attentionButtonH = iconImageViewH;
    CGFloat attentionButtonX = screenW - attentionButtonW;
    CGFloat attentionButtonY = iconImageViewY;
    _attentionButtonF = CGRectMake(attentionButtonX, attentionButtonY, attentionButtonW, attentionButtonH);
    
    CGFloat verticalSeparatorViewW = 0.5;
    CGFloat verticalSeparatorViewH = 25;
    CGFloat verticalSeparatorViewX = attentionButtonX - verticalSeparatorViewW;
    CGFloat verticalSeparatorViewY = iconImageViewY + iconImageViewH * 0.25;
    _verticalSeparatorViewF = CGRectMake(verticalSeparatorViewX, verticalSeparatorViewY, verticalSeparatorViewW, verticalSeparatorViewH);
    
    CGFloat nameLabelX = CGRectGetMaxX(_iconImageViewF) + smallMargin;
    CGFloat nameLabelY = iconImageViewY + smallMargin;
    CGFloat nameLabelW = verticalSeparatorViewX - nameLabelX;
    CGFloat nameLabelH = 16;
    _nameLabelF = CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    
    CGFloat gradeLabelX = nameLabelX;
    CGFloat gradeLabelY = CGRectGetMaxY(_nameLabelF) + smallMargin;
    CGFloat gradeLabelW = nameLabelW;
    CGFloat gradeLabelH = 14;
    _gradeLabelF = CGRectMake(gradeLabelX, gradeLabelY, gradeLabelW, gradeLabelH);
    
    CGFloat horizontalSeparatorViewFirstX = 0;
    CGFloat horizontalSeparatorViewFirstY = CGRectGetMaxY(_iconImageViewF) + middleMargin;
    CGFloat horizontalSeparatorViewFirstW = screenW;
    CGFloat horizontalSeparatorViewFirstH = verticalSeparatorViewW;
    _horizontalSeparatorViewFirstF = CGRectMake(horizontalSeparatorViewFirstX, horizontalSeparatorViewFirstY, horizontalSeparatorViewFirstW, horizontalSeparatorViewFirstH);
    
    CGFloat remarkButtonX = 0;
    CGFloat remarkButtonY = CGRectGetMaxY(_horizontalSeparatorViewFirstF);
    CGFloat remarkButtonW = screenW;
    CGSize remarkButtonS = [[NSString stringWithFormat:@"备注  %@", clientDetail.userRemark.remarkDesc] sizeWithFont:SLFont14 maxSize:CGSizeMake(screenW - 60, CGFLOAT_MAX)];
    CGFloat remarkButtonH = remarkButtonS.height + largeMargin;
    _remarkButtonF = CGRectMake(remarkButtonX, remarkButtonY, remarkButtonW, remarkButtonH);
    
    CGFloat horizontalSeparatorViewSecondX = 0;
    CGFloat horizontalSeparatorViewSecondY = CGRectGetMaxY(_remarkButtonF);
    CGFloat horizontalSeparatorViewSecondW = screenW;
    CGFloat horizontalSeparatorViewSecondH = horizontalSeparatorViewFirstH;
    _horizontalSeparatorViewSecondF = CGRectMake(horizontalSeparatorViewSecondX, horizontalSeparatorViewSecondY, horizontalSeparatorViewSecondW, horizontalSeparatorViewSecondH);
}

@end
