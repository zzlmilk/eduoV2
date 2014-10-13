//
//  SLHomeStatusFrame.m
//  02-pigBank
//
//  Created by 陆承东 on 14-9-18.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLHomeStatusFrame.h"
#import "SLHomeStatus.h"

#define margin 10
#define marginSmall 1

@implementation SLHomeStatusFrame

- (void)setHomeStatus:(SLHomeStatus *)homeStatus
{
    _homeStatus = homeStatus;
    
    // cell的宽度
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
    
    // 设置所有子控件的frame值
    /** dateLabelF */
    CGFloat dateLabelX = 0;
    CGFloat dateLabelY = 0;
    CGFloat dateLabelW = cellW;
//    CGFloat dateLabelH = 30;
    CGFloat dateLabelH = 0;
    _dateLabelF = CGRectMake(dateLabelX, dateLabelY, dateLabelW, dateLabelH);
    
    /** extPicture标 */
    CGFloat extPictureViewX = margin;
    CGFloat extPictureViewY = CGRectGetMaxY(_dateLabelF) + margin;
    CGFloat extPictureViewW = 60;
    CGFloat extPictureViewH = extPictureViewW;
    _extPictureViewF = CGRectMake(extPictureViewX, extPictureViewY, extPictureViewW, extPictureViewH);
    
    /** title */
    CGFloat titleLabelX = CGRectGetMaxX(_extPictureViewF) + margin;
    CGFloat titleLabelY = extPictureViewY;
    CGFloat titleLabelMaxW = cellW - titleLabelX - margin;
    CGSize titleLabelS;
    if (homeStatus.templetType == 3) {
        titleLabelS = [[NSString stringWithFormat:@"【尊享理财】%@", homeStatus.title] sizeWithFont:SLHomeStatusTitleFont constrainedToSize:CGSizeMake(titleLabelMaxW, CGFLOAT_MAX)];
    } else {
        titleLabelS = [[NSString stringWithFormat:@"【VIP特权】%@", homeStatus.title] sizeWithFont:SLHomeStatusTitleFont constrainedToSize:CGSizeMake(titleLabelMaxW, CGFLOAT_MAX)];
    }
    _titleLabelF = (CGRect){{titleLabelX, titleLabelY}, titleLabelS};
    
    /** 赞的图标 */
    CGFloat likeViewX = titleLabelX;
    CGFloat likeViewY = CGRectGetMaxY(_titleLabelF) + marginSmall;
    CGFloat likeViewW = 12;
    CGFloat likeViewH = 16;
    _likeViewF = CGRectMake(likeViewX, likeViewY, likeViewW, likeViewH);
    
    /** praiseCounts */
    CGFloat praiseCountsLabelX = CGRectGetMaxX(_likeViewF) + marginSmall;
    CGFloat praiseCountsLabelY = likeViewY;
    CGSize praiseCountsLabelS = [[NSString stringWithFormat:@"%ld人很喜欢",homeStatus.praiseCounts] sizeWithFont:SLHomeStatusPraiseCountsFont];
    _praiseCountsLabelF = (CGRect){{praiseCountsLabelX, praiseCountsLabelY}, praiseCountsLabelS};
    
    /** cellHeight */
    _cellHeight = MAX(CGRectGetMaxY(_extPictureViewF), CGRectGetMaxY(_praiseCountsLabelF)) + margin;
}

@end
