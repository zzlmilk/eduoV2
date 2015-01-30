//
//  SLActivityDetailTimeCell.m
//  02-pigBank
//
//  Created by 陆承东 on 15/1/22.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import "SLActivityDetailTimeCell.h"

@interface SLActivityDetailTimeCell ()

@property (nonatomic, weak) UIImageView *iconImageView;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *subTitleLabel;

@end

@implementation SLActivityDetailTimeCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 1.添加status内部所有的子控件
        [self addSubviews];
    }
    return self;
}

#pragma mark -----快速创建cell的方法
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"SLActivityDetailTimeCell";
    
    SLActivityDetailTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[SLActivityDetailTimeCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    return cell;
}

#pragma mark ----- 添加所有子控件
- (void)addSubviews
{
    UIImageView *iconImageView = [[UIImageView alloc] init];
    iconImageView.contentMode = UIViewContentModeCenter;
    self.iconImageView = iconImageView;
    [self.contentView addSubview:iconImageView];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = SLFont12;
    self.titleLabel = titleLabel;
    self.titleLabel.contentMode = UIViewContentModeCenter;
    [self.contentView addSubview:titleLabel];
    
    UILabel *subTitleLabel = [[UILabel alloc] init];
    subTitleLabel.font = SLFont16;
    self.subTitleLabel = subTitleLabel;
    self.subTitleLabel.contentMode = UIViewContentModeCenter;
    [self.contentView addSubview:subTitleLabel];
}

- (void)setActivityDetailFrame:(SLActivityDetailFrame *)activityDetailFrame
{
    _activityDetailFrame = activityDetailFrame;
    
    
    CGFloat iconImageViewX = 2;
    CGFloat iconImageViewY = 2;
    CGFloat iconImageViewW = 40;
    CGFloat iconImageViewH = activityDetailFrame.timeHeight;
    self.iconImageView.frame = CGRectMake(iconImageViewX, iconImageViewY, iconImageViewW, iconImageViewH);
    self.iconImageView.image = [UIImage imageNamed:@"icon_image_time"];
    
    CGFloat titleLabelX = CGRectGetMaxX(self.iconImageView.frame) + smallMargin;
    CGFloat titleLabelY = middleMargin;
    CGFloat titleLabelW = screenW - largeMargin * 3;
    CGFloat titleLabelH = 12;
    self.titleLabel.frame = CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
    self.titleLabel.text = @"活动时间";
    
    CGFloat subTitleLabelX = titleLabelX;
    CGFloat subTitleLabelY = CGRectGetMaxY(self.titleLabel.frame) + smallMargin;
    CGFloat subTitleLabelW = titleLabelW;
    CGFloat subTitleLabelH = activityDetailFrame.timeLabelHeight;
    self.subTitleLabel.frame = CGRectMake(subTitleLabelX, subTitleLabelY, subTitleLabelW, subTitleLabelH);
    self.subTitleLabel.text = [NSString stringWithFormat:@"%@ 至 \n%@", self.activityDetailFrame.activityDetail.startTimeStr, self.activityDetailFrame.activityDetail.endTimeStr];
    self.subTitleLabel.numberOfLines = 0;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
