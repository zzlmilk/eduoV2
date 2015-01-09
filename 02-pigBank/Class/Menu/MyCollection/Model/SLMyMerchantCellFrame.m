//
//  SLMyMerchantCellFrame.m
//  02-pigBank
//
//  Created by 陆承东 on 15/1/7.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import "SLMyMerchantCellFrame.h"

#import "NSString+S_LINE.h"

@implementation SLMyMerchantCellFrame

- (void)setMerchantDetial:(SLMerchantStatus *)merchantDetial
{
    _merchantDetial = merchantDetial;
    
    // cell的宽度
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
    
    /** pictureImageViewF */
    CGFloat pictureImageViewX = smallMargin;
    CGFloat pictureImageViewY = smallMargin;
    CGFloat pictureImageViewW = 60;
    CGFloat pictureImageViewH = pictureImageViewW;
    _pictureImageViewF = CGRectMake(pictureImageViewX, pictureImageViewY, pictureImageViewW, pictureImageViewH);
    
    /** titleLabelF */
    CGFloat titleLabelX = CGRectGetMaxX(_pictureImageViewF) + smallMargin;
    CGFloat titleLabelY = pictureImageViewY;
    CGFloat titleLabelW = cellW - titleLabelX - smallMargin;
    CGFloat titleLabelH = 16;
    _titleLabelF = CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
    
    /** adressLabelF */
    CGFloat adressLabelX = titleLabelX;
    CGFloat adressLabelY = CGRectGetMaxY(_titleLabelF) + smallMargin;
    CGFloat adressLabelW = titleLabelW;
    CGFloat adressLabelH = 16;
    _adressLabelF = CGRectMake(adressLabelX, adressLabelY, adressLabelW, adressLabelH);
    
    /** 赞的图标 */
    CGFloat likeViewX = titleLabelX;
    CGFloat likeViewY = CGRectGetMaxY(_adressLabelF) + smallMargin;
    CGFloat likeViewW = 12;
    CGFloat likeViewH = 16;
    _likeViewF = CGRectMake(likeViewX, likeViewY, likeViewW, likeViewH);
    
    /** priseCountLabelF */
    CGFloat priseCountLabelX = CGRectGetMaxX(_likeViewF) + smallMargin;
    CGFloat priseCountLabelY = likeViewY;
    CGSize priseCountLabelS = [[NSString stringWithFormat:@"%@人很喜欢", merchantDetial.praiseCounts] sizeWithFont:SLFont12 maxSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
    _priseCountLabelF = (CGRect){{priseCountLabelX, priseCountLabelY}, priseCountLabelS};
    
    /** distanceLabelF */
    CGFloat distanceLabelX = cellW - middleMargin - 50;
    CGFloat distanceLabelY = priseCountLabelY;
    CGFloat distanceLabelW = 50;
    CGFloat distanceLabelH = _priseCountLabelF.size.height;
    _distanceLabelF = CGRectMake(distanceLabelX, distanceLabelY, distanceLabelW, distanceLabelH);
}

@end
