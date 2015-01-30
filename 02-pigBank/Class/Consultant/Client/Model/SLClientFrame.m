//
//  SLClientFrame.m
//  02-pigBank
//
//  Created by 陆承东 on 15/1/19.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import "SLClientFrame.h"

@implementation SLClientFrame

- (void)setClient:(SLClient *)client
{
    _client = client;
    
    CGFloat iconImageViewX = middleMargin;
    CGFloat iconImageViewY = middleMargin;
    CGFloat iconImageViewW = 40;
    CGFloat iconImageViewH = iconImageViewW;
    _iconImageViewF = CGRectMake(iconImageViewX, iconImageViewY, iconImageViewW, iconImageViewH);
    
    CGFloat attentionButtonW = 50;
    CGFloat attentionButtonH = 35;
    CGFloat attentionButtonX = screenW - middleMargin - attentionButtonW;
    CGFloat attentionButtonY = iconImageViewY;
    _attentionButtonF = CGRectMake(attentionButtonX, attentionButtonY, attentionButtonW, attentionButtonH);
    
    CGFloat separatorViewW = 0.5;
    CGFloat separatorViewH = iconImageViewH;
    CGFloat separatorViewX = attentionButtonX - 10.5;
    CGFloat separatorViewY = iconImageViewY;
    _separatorViewF = CGRectMake(separatorViewX, separatorViewY, separatorViewW, separatorViewH);
    
    CGFloat nameLabelX = CGRectGetMaxX(_iconImageViewF) + middleMargin;
    CGFloat nameLabelY = iconImageViewY;
    CGFloat nameLabelW = CGRectGetMinX(_separatorViewF) - nameLabelX - middleMargin;
    CGFloat nameLabelH = 18;
    _nameLabelF = CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    
    CGFloat remarkLabelX = nameLabelX;
    CGFloat remarkLabelY = CGRectGetMaxY(_nameLabelF) + middleMargin;
    CGFloat remarkLabelW = nameLabelW;
    CGFloat remarkLabelH = 14;
    _remarkLabelF = CGRectMake(remarkLabelX, remarkLabelY, remarkLabelW, remarkLabelH);
}

@end
