//
//  SLMaterialBrowseHistoryFrame.m
//  02-pigBank
//
//  Created by 陆承东 on 15/1/22.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import "SLMaterialBrowseHistoryFrame.h"

#import "NSString+S_LINE.h"

@implementation SLMaterialBrowseHistoryFrame

- (void)setMaterial:(SLMaterial *)material
{
    _material = material;
    
    /*
     @property (nonatomic, assign) CGRect iconImageViewF;
     @property (nonatomic, assign) CGRect titleLabelF;
     @property (nonatomic, assign) CGRect priseImageViewF;
     @property (nonatomic, assign) CGRect collectImageViewF;
     @property (nonatomic, assign) CGRect timeLabelF;
     */
    
    CGFloat iconImageViewX = middleMargin;
    CGFloat iconImageViewY = middleMargin;
    CGFloat iconImageViewW = 50;
    CGFloat iconImageViewH = iconImageViewW;
    _iconImageViewF = CGRectMake(iconImageViewX, iconImageViewY, iconImageViewW, iconImageViewH);
    
    CGFloat titleLabelX = CGRectGetMaxX(_iconImageViewF) + smallMargin;
    CGFloat titleLabelY = iconImageViewY;
    CGFloat titleLabelW = screenW - middleMargin - titleLabelX;
    CGFloat titleLabelH = 34;
    _titleLabelF = CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
    
    CGFloat priseImageViewX = titleLabelX;
    CGFloat priseImageViewY = CGRectGetMaxY(_titleLabelF) + 3;
    CGFloat priseImageViewW = 12;
    CGFloat priseImageViewH = 12;
    _priseImageViewF = CGRectMake(priseImageViewX, priseImageViewY, priseImageViewW, priseImageViewH);
    
    CGFloat collectImageViewX = CGRectGetMaxX(_priseImageViewF) + smallMargin;
    CGFloat collectImageViewY = priseImageViewY;
    CGFloat collectImageViewW = priseImageViewW;
    CGFloat collectImageViewH = priseImageViewH;
    _collectImageViewF = CGRectMake(collectImageViewX, collectImageViewY, collectImageViewW, collectImageViewH);
    
    CGSize timeLabelS = [material.lastReadTimeStr sizeWithFont:SLFont12 maxSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
    CGFloat timeLabelX = screenW - middleMargin - timeLabelS.width;
    CGFloat timeLabelY = collectImageViewY;
    _timeLabelF = CGRectMake(timeLabelX, timeLabelY, timeLabelS.width, timeLabelS.height);
}

@end
