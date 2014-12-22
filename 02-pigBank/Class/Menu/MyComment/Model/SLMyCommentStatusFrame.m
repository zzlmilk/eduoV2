//
//  SLMyCommentStatusFrame.m
//  02-pigBank
//
//  Created by 陆承东 on 14/12/13.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLMyCommentStatusFrame.h"

@implementation SLMyCommentStatusFrame

- (void)setMyCommentStatus:(SLMyCommentStatus *)myCommentStatus
{
    _myCommentStatus = myCommentStatus;
    
    CGFloat iconImageViewX = middleMargin + 6;
    CGFloat iconImageViewY = smallMargin;
    CGFloat iconImageViewW = 20;
    CGFloat iconImageViewH = 20;
    _iconImageViewF = CGRectMake(iconImageViewX, iconImageViewY, iconImageViewW, iconImageViewH);
    
    CGFloat merchantNameLabelX = CGRectGetMaxX(_iconImageViewF) + middleMargin;
    CGFloat merchantNameLabelY = iconImageViewY;
    CGFloat merchantNameLabelW = screenW - merchantNameLabelX - 7 - largeMargin;
    CGFloat merchantNameLabelH = iconImageViewH;
    _merchantNameLabelF = CGRectMake(merchantNameLabelX, merchantNameLabelY, merchantNameLabelW, merchantNameLabelH);
    
    CGFloat accessoryImageViewX = CGRectGetMaxX(_merchantNameLabelF) + middleMargin;
    CGFloat accessoryImageViewY = merchantNameLabelY;
    CGFloat accessoryImageViewW = 7;
    CGFloat accessoryImageViewH = merchantNameLabelH;
    _accessoryImageViewF = CGRectMake(accessoryImageViewX, accessoryImageViewY, accessoryImageViewW, accessoryImageViewH);
    
    CGFloat separatorImageViewX = 0;
    CGFloat separatorImageViewY = CGRectGetMaxY(_iconImageViewF) + smallMargin;
    CGFloat separatorImageViewW = screenW;
    CGFloat separatorImageViewH = 7;
    _separatorImageViewF = CGRectMake(separatorImageViewX, separatorImageViewY, separatorImageViewW, separatorImageViewH);
    
    _cellHeight = CGRectGetMaxY(_separatorImageViewF);
    
    CGFloat myCommentLabelX = middleMargin;
    CGFloat myCommentLabelY = middleMargin;
    CGFloat myCommentLabelW = screenW - largeMargin;
    if ([myCommentStatus.commentText respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSDictionary *attributes = @{NSFontAttributeName:SLFont12, NSParagraphStyleAttributeName:[[NSMutableParagraphStyle alloc]init]};
        CGRect myCommentLabelSF = [myCommentStatus.commentText boundingRectWithSize:CGSizeMake( screenW - largeMargin, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
        _myCommentLabelF = CGRectMake(myCommentLabelX, myCommentLabelY, myCommentLabelW, myCommentLabelSF.size.height);
    } else {
        CGSize myCommentLabelS = [myCommentStatus.commentText sizeWithFont:SLFont12 constrainedToSize:CGSizeMake( screenW - largeMargin, CGFLOAT_MAX)];
        _myCommentLabelF = CGRectMake(myCommentLabelX, myCommentLabelY, myCommentLabelW, myCommentLabelS.height);
    }
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[myCommentStatus.commentTime longLongValue]/1000];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy/MM/dd"];
    NSString *dateStr = [dateFormat stringFromDate: date];
    CGFloat dateLabelW;
    if ([dateStr respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSDictionary *attributes = @{NSFontAttributeName:SLFont12, NSParagraphStyleAttributeName:[[NSMutableParagraphStyle alloc]init]};
        CGRect dataLabelSF = [dateStr boundingRectWithSize:CGSizeMake( CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
        dateLabelW = dataLabelSF.size.width;
    } else {
        CGSize dataLabelS = [dateStr sizeWithFont:SLFont12 constrainedToSize:CGSizeMake( CGFLOAT_MAX, CGFLOAT_MAX)];
        dateLabelW = dataLabelS.width;
    }
    CGFloat dateLabelX = screenW - dateLabelW - middleMargin;
    CGFloat dateLabelY = CGRectGetMaxY(_myCommentLabelF) + middleMargin;
    CGFloat dateLabelH = 16;
    _dateLabelF = CGRectMake(dateLabelX, dateLabelY, dateLabelW, dateLabelH);
    
    CGFloat scoreImageViewsW = 16;
    CGFloat scoreImageViewsH = 16;
    CGFloat scoreImageViewsY = dateLabelY;
    for (int i = 0; i < 5; i++) {
        int j = 5 - i;
        CGFloat scoreImageViewsX = CGRectGetMinX(_dateLabelF) - middleMargin - (j * scoreImageViewsW);
        CGRect scoreImageViewF = CGRectMake(scoreImageViewsX, scoreImageViewsY, scoreImageViewsW, scoreImageViewsH);
        NSString *scoreImageViewFStr = NSStringFromCGRect(scoreImageViewF);
        [_scoreImageViewFs addObject:scoreImageViewFStr];
    }
    
    CGFloat sectionFootViewX = 0;
    CGFloat sectionFootViewY = 0;
    CGFloat sectionFootViewW = screenW;
    CGFloat sectionFootViewH = CGRectGetMaxY(_dateLabelF) + middleMargin;
    _sectionFootViewF = CGRectMake(sectionFootViewX, sectionFootViewY, sectionFootViewW, sectionFootViewH);
    
    CGFloat separatorX = 0;
    CGFloat separatorY = CGRectGetMaxY(_dateLabelF) + middleMargin;
    CGFloat separatorW = screenW;
    CGFloat separatorH = 0.5;
    _separatorF = CGRectMake(separatorX, separatorY, separatorW, separatorH);
    
    _sectionHeight = sectionFootViewH;
}

@end
