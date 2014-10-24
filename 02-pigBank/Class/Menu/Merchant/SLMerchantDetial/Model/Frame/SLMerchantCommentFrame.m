//
//  SLMerchantCommentFrame.m
//  02-pigBank
//
//  Created by 陆承东 on 14/10/24.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLMerchantCommentFrame.h"

@implementation SLMerchantCommentFrame

- (id)init
{
    if (self = [super init]) {
        self.cellHeight = 0;
    }
    return self;
}

- (void)setMyComment:(SLMyComment *)myComment
{
    _myComment = myComment;
    
    CGFloat commentLabelX = middleMargin;
    CGFloat commentLabelY = middleMargin;
    CGSize commentLabelS = [[NSString stringWithFormat:@"%@评论:%@", myComment.userPartName, myComment.commentText] sizeWithFont:SLFont14 constrainedToSize:CGSizeMake((screenW - 2 * middleMargin), CGFLOAT_MAX)];
    _commentLabelF = (CGRect){{commentLabelX, commentLabelY}, commentLabelS};
    
    // 转换时间
    NSDate *commentTime = [NSDate dateWithTimeIntervalSince1970: [myComment.commentTime longLongValue] / 1000];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy/MM/dd"];
    NSString *commentTimeStr = [dateFormat stringFromDate: commentTime];
    CGFloat timeLabelY = CGRectGetMaxY(_commentLabelF) + middleMargin;
    CGSize timeLabelS = [commentTimeStr sizeWithFont:SLFont11];
    CGFloat timeLabelX = screenW - middleMargin - timeLabelS.width;
    _timeLabelF = (CGRect){{timeLabelX, timeLabelY}, timeLabelS};
    
    CGFloat scoreViewY = timeLabelY;
    CGFloat scoreViewW = 16 * 5;
    CGFloat scoreViewH = 16;
    CGFloat scoreViewX = timeLabelX - middleMargin - scoreViewW;
    _scoreViewF = CGRectMake(scoreViewX, scoreViewY, scoreViewW, scoreViewH);
    
    _cellHeight = CGRectGetMaxY(_scoreViewF) + middleMargin;
}

- (void)setOtherComment:(SLOthersComment *)otherComment
{
    _otherComment = otherComment;
    
    CGFloat commentLabelX = middleMargin;
    CGFloat commentLabelY = middleMargin;
    CGSize commentLabelS = [[NSString stringWithFormat:@"%@评论:%@", otherComment.userPartName, otherComment.commentText] sizeWithFont:SLFont14 constrainedToSize:CGSizeMake((screenW - 2 * middleMargin), CGFLOAT_MAX)];
    _commentLabelF = (CGRect){{commentLabelX, commentLabelY}, commentLabelS};
    
    // 转换时间
    NSDate *commentTime = [NSDate dateWithTimeIntervalSince1970: [otherComment.commentTime longLongValue] / 1000];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy/MM/dd"];
    NSString *commentTimeStr = [dateFormat stringFromDate: commentTime];
    CGFloat timeLabelY = CGRectGetMaxY(_commentLabelF) + middleMargin;
    CGSize timeLabelS = [commentTimeStr sizeWithFont:SLFont13];
    CGFloat timeLabelX = screenW - middleMargin - timeLabelS.width;
    _timeLabelF = (CGRect){{timeLabelX, timeLabelY}, timeLabelS};
    
    CGFloat scoreViewY = timeLabelY;
    CGFloat scoreViewW = 16 * 5;
    CGFloat scoreViewH = 16;
    CGFloat scoreViewX = timeLabelX - middleMargin - scoreViewW;
    _scoreViewF = CGRectMake(scoreViewX, scoreViewY, scoreViewW, scoreViewH);
    
    _cellHeight = CGRectGetMaxY(_scoreViewF) + middleMargin;
}

@end
