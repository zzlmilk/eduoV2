//
//  SLManageClientFrame.m
//  02-pigBank
//
//  Created by 陆承东 on 15/1/28.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import "SLManageClientFrame.h"

@implementation SLManageClientFrame

- (void)setClient:(SLClient *)client
{
    _client = client;
    
    CGFloat iconImageViewX = middleMargin;
    CGFloat iconImageViewY = middleMargin;
    CGFloat iconImageViewW = 40;
    CGFloat iconImageViewH = iconImageViewW;
    _iconImageViewF = CGRectMake(iconImageViewX, iconImageViewY, iconImageViewW, iconImageViewH);
    
    CGFloat nameLabelX = CGRectGetMaxX(_iconImageViewF) + middleMargin;
    CGFloat nameLabelY = iconImageViewY;
    CGFloat nameLabelW = screenW - nameLabelX - middleMargin;
    CGFloat nameLabelH = 18;
    _nameLabelF = CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    
    CGFloat priseImageViewX = nameLabelX;
    CGFloat priseImageViewY = CGRectGetMaxY(_nameLabelF) + smallMargin;
    CGFloat priseImageViewW = 12;
    CGFloat priseImageViewH = 12;
    _priseImageViewF = CGRectMake(priseImageViewX, priseImageViewY, priseImageViewW, priseImageViewH);
    
    CGFloat collectImageViewX = CGRectGetMaxX(_priseImageViewF) + smallMargin;
    CGFloat collectImageViewY = priseImageViewY;
    CGFloat collectImageViewW = priseImageViewW;
    CGFloat collectImageViewH = priseImageViewH;
    _collectImageViewF = CGRectMake(collectImageViewX, collectImageViewY, collectImageViewW, collectImageViewH);
}

@end
