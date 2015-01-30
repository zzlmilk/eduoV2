//
//  SLSubscribeListCell.m
//  02-pigBank
//
//  Created by 陆承东 on 15/1/23.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import "SLSubscribeListCell.h"

#import "UIImage+S_LINE.h"

#import "UIImageView+WebCache.h"

@interface SLSubscribeListCell ()

@property (nonatomic, weak) UIImageView *iconImageView;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *classNameLabel;

@end

@implementation SLSubscribeListCell

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
    static NSString *ID = @"SLActivityListCell";
    
    SLSubscribeListCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[SLSubscribeListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    return cell;
}

#pragma mark ----- 添加所有子控件
- (void)addSubviews
{
    UIImageView *iconImageView = [[UIImageView alloc] init];
    self.iconImageView = iconImageView;
    [self.contentView addSubview:iconImageView];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    self.titleLabel = titleLabel;
    [self.contentView addSubview:titleLabel];
    
    UILabel *classNameLabel = [[UILabel alloc] init];
    self.classNameLabel = classNameLabel;
    [self.contentView addSubview:classNameLabel];
}

- (void)setSubscribeList:(SLSubscribeList *)subscribeList
{
    _subscribeList = subscribeList;
    
    CGFloat iconImageViewX = middleMargin;
    CGFloat iconImageViewY = middleMargin;
    CGFloat iconImageViewW = 80;
    CGFloat iconImageViewH = 60;
    CGRect iconImageViewF = CGRectMake(iconImageViewX, iconImageViewY, iconImageViewW, iconImageViewH);
    self.iconImageView.frame = iconImageViewF;
    self.iconImageView.layer.cornerRadius = 5;
    self.iconImageView.clipsToBounds = YES;
    [self.iconImageView setImageWithURL:[NSURL URLWithString:subscribeList.pictureUrl] placeholderImage:[UIImage imageNamed:@"icon_image_placehold"]];
    
    CGFloat titleLabelX = CGRectGetMaxX(iconImageViewF) + smallMargin;
    CGFloat titleLabelY = iconImageViewY + 4;
    CGFloat titleLabelW = screenW - middleMargin - titleLabelX;
    CGFloat titleLabelH = 35;
    CGRect titleLabelF = CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
    self.titleLabel.font = SLBoldFont14;
    self.titleLabel.numberOfLines = 2;
    self.titleLabel.contentMode = UIViewContentModeCenter;
    self.titleLabel.frame = titleLabelF;
    self.titleLabel.text = subscribeList.title;
    
    CGFloat classNameLabelX = titleLabelX;
    CGFloat classNameLabelY = CGRectGetMaxY(titleLabelF) + smallMargin;
    CGFloat classNameLabelW = titleLabelW;
    CGFloat classNameLabelH = 12;
    CGRect classNameLabelF = CGRectMake(classNameLabelX, classNameLabelY, classNameLabelW, classNameLabelH);
    self.classNameLabel.numberOfLines = 1;
    self.classNameLabel.font = SLFont12;
    self.classNameLabel.contentMode = UIViewContentModeCenter;
    self.classNameLabel.frame = classNameLabelF;
    self.classNameLabel.text = subscribeList.labelName;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
