//
//  SLMyCommentSectionFootView.m
//  02-pigBank
//
//  Created by 陆承东 on 14/12/20.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLMyCommentSectionFootView.h"

@interface SLMyCommentSectionFootView ()

@property (nonatomic, weak) UITextView *myCommentLabel;

@property (nonatomic, strong) NSMutableArray *scoreImageViews;

@property (nonatomic, weak) UILabel *dateLabel;

@property (nonatomic, weak) UIView *separator;

@end

@implementation SLMyCommentSectionFootView

- (NSMutableArray *)scoreImageViews
{
    if (_scoreImageViews == nil) {
        _scoreImageViews = [NSMutableArray array];
    }
    return _scoreImageViews;
}

#pragma mark ----- initWithFrame
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UITextView *myCommentLabel = [[UITextView alloc] init];
        [self addSubview:myCommentLabel];
        self.myCommentLabel = myCommentLabel;

        for (int i = 0; i < 5; i++) {
            UIImageView *scoreImageView = [[UIImageView alloc] init];
            [self addSubview:scoreImageView];
            [self.scoreImageViews addObject:scoreImageView];
        }

        UILabel *dateLabel = [[UILabel alloc] init];
        [self addSubview:dateLabel];
        self.dateLabel = dateLabel;
        
        UIView *separator = [[UIView alloc] init];
        [self addSubview:separator];
        self.separator = separator;
    }
    return self;
}

#pragma mark ----- myCommentStatusFrame的set方法
- (void)setMyCommentStatusFrame:(SLMyCommentStatusFrame *)myCommentStatusFrame
{
    _myCommentStatusFrame = myCommentStatusFrame;
    
    [self setSubviewsData];
}

#pragma mark ----- setSubviewsData设置所有子控件的数据
- (void)setSubviewsData
{
    SLMyCommentStatus *myCommentStatus = self.myCommentStatusFrame.myCommentStatus;
    
    self.myCommentLabel.frame = self.myCommentStatusFrame.myCommentLabelF;
    self.myCommentLabel.font = SLFont12;
    self.myCommentLabel.bounces = NO;
    self.myCommentLabel.editable = NO;
    self.myCommentLabel.textContainerInset = UIEdgeInsetsZero;
    self.myCommentLabel.text = myCommentStatus.commentText;
    
    CGFloat scoreImageViewsW = 16;
    CGFloat scoreImageViewsH = 16;
    CGFloat scoreImageViewsY = self.myCommentStatusFrame.dateLabelF.origin.y;
    for (int i = 0; i < 5; i++) {
        int j = 5 - i;
        CGFloat scoreImageViewsX = CGRectGetMinX(self.myCommentStatusFrame.dateLabelF) - middleMargin - (j * scoreImageViewsW);
        CGRect scoreImageViewF = CGRectMake(scoreImageViewsX, scoreImageViewsY, scoreImageViewsW, scoreImageViewsH);
        UIImageView *scoreImageView = self.scoreImageViews[i];
        scoreImageView.frame = scoreImageViewF;
        if ((i + 1) <= [myCommentStatus.score intValue]) {
            scoreImageView.image = [UIImage imageNamed:@"pingFenXinJiaoHu"];
        } else {
            scoreImageView.image = [UIImage imageNamed:@"pingFenXin"];
        }
    }
//    for (int i = 0; i < self.scoreImageViews.count; i++) {
//        UIImageView *scoreImageView = self.scoreImageViews[i];
//        CGRect scoreImageViewF = CGRectFromString(self.myCommentStatusFrame.scoreImageViewFs[i]);
//        SLLog(@"%@", self.myCommentStatusFrame.scoreImageViewFs[i]);
//        scoreImageView.frame = scoreImageViewF;
//        if (i <= [myCommentStatus.score intValue]) {
//            scoreImageView.image = [UIImage imageNamed:@"pingFenXinJiaoHu"];
//        } else {
//            scoreImageView.image = [UIImage imageNamed:@"pingFenXin"];
//        }
//    }
    
    /** dateLabel */
    self.dateLabel.frame = self.myCommentStatusFrame.dateLabelF;
    self.dateLabel.font = SLFont12;
    // 转换时间
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[myCommentStatus.commentTime longLongValue]/1000];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy/MM/dd"];
    NSString *dateStr = [dateFormat stringFromDate: date];
    self.dateLabel.text = dateStr;
    
    self.separator.frame = self.myCommentStatusFrame.separatorF;
    self.separator.backgroundColor = [UIColor lightGrayColor];
}

@end
