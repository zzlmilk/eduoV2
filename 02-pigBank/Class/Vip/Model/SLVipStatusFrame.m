//
//  SLVipStatusFrame.m
//  02-pigBank
//
//  Created by 陆承东 on 14-9-23.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLVipStatusFrame.h"
#import "SLVipStatus.h"
#import "SLVipStatusFirstMaterialInfo.h"
#import "SLVipPrivilegeDetail.h"
#import "SLVipMerchantDetail.h"

#define marginS 5

@implementation SLVipStatusFrame

- (void)setVipStatus:(SLVipStatus *)vipStatus
{
    _vipStatus = vipStatus;
    
    // cell的宽度
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
    
    /** pictureImageViewF */
    CGFloat pictureImageViewX = marginS;
    CGFloat pictureImageViewY = marginS;
    CGFloat pictureImageViewW = 60;
    CGFloat pictureImageViewH = pictureImageViewW;
    _pictureImageViewF = CGRectMake(pictureImageViewX, pictureImageViewY, pictureImageViewW, pictureImageViewH);
    
    /** titleLabelF */
    CGFloat titleLabelX = CGRectGetMaxX(_pictureImageViewF) + marginS;
    CGFloat titleLabelY = pictureImageViewY;
    CGFloat titleLabelW = cellW - titleLabelX - marginS;
    CGFloat titleLabelH = 16;
    _titleLabelF = CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
    
    /** adressLabelF */
    CGFloat adressLabelX = titleLabelX;
    CGFloat adressLabelY = CGRectGetMaxY(_titleLabelF) + marginS;
    CGFloat adressLabelW = titleLabelW;
    CGFloat adressLabelH = 16;
    _adressLabelF = CGRectMake(adressLabelX, adressLabelY, adressLabelW, adressLabelH);
    
    /** 赞的图标 */
    CGFloat likeViewX = titleLabelX;
    CGFloat likeViewY = CGRectGetMaxY(_adressLabelF) + marginS;
    CGFloat likeViewW = 12;
    CGFloat likeViewH = 16;
    _likeViewF = CGRectMake(likeViewX, likeViewY, likeViewW, likeViewH);
    
    /** priseCountLabelF */
    CGFloat priseCountLabelX = CGRectGetMaxX(_likeViewF) + marginS;
    CGFloat priseCountLabelY = likeViewY;
//    CGFloat priseCountLabelW = titleLabelW;
//    CGFloat priseCountLabelH = 16;
    CGSize priseCountLabelS = [[NSString stringWithFormat:@"%ld人很喜欢", vipStatus.firstMaterialInfo.praiseCounts] sizeWithFont:SLVipStatusPraiseCountsFont];
    _priseCountLabelF = (CGRect){{priseCountLabelX, priseCountLabelY}, priseCountLabelS};
}

@end
