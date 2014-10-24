//
//  SLCommentCell.m
//  02-pigBank
//
//  Created by 陆承东 on 14/10/24.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLCommentCell.h"

#import "SLScoreView.h"

@interface SLCommentCell ()

@property (nonatomic, weak) UILabel *commentLabel;

@property (nonatomic, weak) UIView *separator;

//@property (nonatomic, weak) SLScoreView *scoreView;

@property (nonatomic, weak) UIView *scoreView;

@property (nonatomic, weak) UILabel *timeLabel;

@property (nonatomic, strong) NSMutableArray *scoreImageViewArray;

@end

@implementation SLCommentCell

- (NSMutableArray *)scoreImageViewArray
{
    if (_scoreImageViewArray == nil) {
        _scoreImageViewArray = [NSMutableArray array];
    }
    return _scoreImageViewArray;
}

#pragma mark - 初始化
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"SLCommentCell";
    SLCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[SLCommentCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addContentView];
        self.backgroundColor = [UIColor whiteColor];
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)addContentView
{
    UILabel *commentLabel = [[UILabel alloc] init];
    [self.contentView addSubview:commentLabel];
    self.commentLabel = commentLabel;
    
    UIView *separator = [[UIView alloc] init];
    self.separator = separator;
    separator.backgroundColor = SLColorRGBA(0, 0, 0, 0.2);
    [self.contentView addSubview:separator];
    
    UIView *scoreView = [[UIView alloc] init];
    for (int i = 0; i < 5; i++) {
        UIImageView *scoreImageView = [[UIImageView alloc] initWithFrame:CGRectMake(16 * i, 0, 16, 16)];
        scoreImageView.tag = i;
        scoreImageView.image = [UIImage imageNamed:@"pingFenXin"];
        [self.scoreImageViewArray addObject:scoreImageView];
        [scoreView addSubview:scoreImageView];
    }
    [self.contentView addSubview:scoreView];
    self.scoreView = scoreView;
    
    UILabel *timeLabel = [[UILabel alloc] init];
    self.timeLabel = timeLabel;
    [self.contentView addSubview:timeLabel];
}

- (void)setItem:(SLMerchantDetailItem *)item
{
    self.commentLabel.frame = item.merchantDetailFrame.merchantCommentFrame.commentLabelF;
    self.commentLabel.textColor = [UIColor blackColor];
    self.commentLabel.font = SLFont14;
    self.commentLabel.numberOfLines = 0;
    
    self.scoreView.frame = item.merchantDetailFrame.merchantCommentFrame.scoreViewF;
    
    self.timeLabel.frame = item.merchantDetailFrame.merchantCommentFrame.timeLabelF;
    self.timeLabel.textColor = [UIColor blackColor];
    self.timeLabel.font = SLFont13;
    
    if (item.merchantDetailFrame.merchantCommentFrame.myComment) {
        SLMyComment *myComment = item.merchantDetailFrame.merchantCommentFrame.myComment;
        self.commentLabel.text = [NSString stringWithFormat:@"%@评论:%@", myComment.userPartName, myComment.commentText];
        
        for (int i = 0; i < myComment.score; i++) {
            for (UIImageView *imageView in self.scoreImageViewArray) {
                if (imageView.tag == i) {
                    imageView.image = [UIImage imageNamed:@"pingFenXinJiaoHu"];
                }
            }
        }
        
        NSDate *commentTime = [NSDate dateWithTimeIntervalSince1970: [myComment.commentTime longLongValue] / 1000];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy/MM/dd"];
        NSString *commentTimeStr = [dateFormat stringFromDate: commentTime];
        self.timeLabel.text = commentTimeStr;
    } else {
        SLOthersComment *otherComment = item.merchantDetailFrame.merchantCommentFrame.otherComment;
        self.commentLabel.text = [NSString stringWithFormat:@"%@评论:%@", otherComment.userPartName, otherComment.commentText];
        
        for (int i = 0; i < otherComment.score; i++) {
            for (UIImageView *imageView in self.scoreImageViewArray) {
                if (imageView.tag == i) {
                    imageView.image = [UIImage imageNamed:@"pingFenXinJiaoHu"];
                }
            }
        }
        
        NSDate *commentTime = [NSDate dateWithTimeIntervalSince1970: [otherComment.commentTime longLongValue] / 1000];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy/MM/dd"];
        NSString *commentTimeStr = [dateFormat stringFromDate: commentTime];
        self.timeLabel.text = commentTimeStr;
    }
    
    self.separator.frame = CGRectMake(0, item.merchantDetailFrame.merchantCommentFrame.cellHeight - 0.5, screenW, 0.5);
}

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
