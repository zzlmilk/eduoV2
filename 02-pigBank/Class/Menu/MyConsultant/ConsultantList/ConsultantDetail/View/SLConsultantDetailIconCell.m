//
//  SLConsultantDetailIconCell.m
//  02-pigBank
//
//  Created by 陆承东 on 15/1/12.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import "SLConsultantDetailIconCell.h"

#import "UIImageView+WebCache.h"

@interface SLConsultantDetailIconCell ()

@property (nonatomic, weak) UIImageView *iconImageView;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UIButton *selectButton;

@end

@implementation SLConsultantDetailIconCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 1.添加status内部所有的子控件
        [self addSubviews];
    }
    return self;
}

#pragma mark ----- addSubviews添加所有子控件
- (void)addSubviews
{
    UIImageView *iconImageView = [[UIImageView alloc] init];
    self.iconImageView = iconImageView;
    [self addSubview:iconImageView];
    
    UILabel *nameLabel = [[UILabel alloc] init];
    self.nameLabel = nameLabel;
    [self addSubview:nameLabel];
    
    UIButton *selectButton = [[UIButton alloc] init];
    self.selectButton = selectButton;
    [self addSubview:selectButton];
}

- (void)setConsultant:(SLConsultant *)consultant
{
    _consultant = consultant;
    
    [self setSubviewsData];
}

#pragma mark ----- setSubviewsData设置子控件数据
- (void)setSubviewsData
{
    CGFloat iconImageViewX = middleMargin;
    CGFloat iconImageViewY = middleMargin;
    CGFloat iconImageViewW = 40;
    CGFloat iconImageViewH = iconImageViewW;
    CGRect iconImageViewF = CGRectMake(iconImageViewX, iconImageViewY, iconImageViewW, iconImageViewH);
    self.iconImageView.frame = iconImageViewF;
    self.iconImageView.layer.cornerRadius = 5;
    self.iconImageView.clipsToBounds = YES;
    [self.iconImageView setImageWithURL:[NSURL URLWithString:self.consultant.pictureUrl] placeholderImage:[UIImage imageNamed:@"moRenTouXiang"]];
    
    CGFloat selectButtonW = 50;
    CGFloat selectButtonH = 25;
    CGFloat selectButtonX = screenW - middleMargin - selectButtonW;
    CGFloat selectButtonY = iconImageViewY + (iconImageViewH - selectButtonH) * 0.5;
    CGRect selectButtonF = CGRectMake(selectButtonX, selectButtonY, selectButtonW, selectButtonH);
    self.selectButton.frame = selectButtonF;
    [self.selectButton setBackgroundImage:[UIImage imageNamed:@"xuanZe"] forState:UIControlStateNormal];
    [self.selectButton setBackgroundImage:[UIImage imageNamed:@"xuanZeJiaoHu"] forState:UIControlStateHighlighted];
    [self.selectButton setTitle:@"选择" forState:UIControlStateNormal];
    self.selectButton.titleLabel.font = SLFont14;
    [self.selectButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.selectButton addTarget:self action:@selector(selectButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat nameLabelX = CGRectGetMaxX(iconImageViewF) + middleMargin;
    CGFloat nameLabelY = iconImageViewY + 10;
    CGFloat nameLabelW = screenW - nameLabelX - selectButtonW - largeMargin;
    CGFloat nameLabelH = 20;
    CGRect nameLabelF = CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    self.nameLabel.frame = nameLabelF;
    self.nameLabel.textColor = [UIColor blackColor];
    self.nameLabel.font = SLFont14;
    self.nameLabel.text = self.consultant.dispName;
}

#pragma mark ----- selectButton的点击事件
- (void)selectButtonClicked:(UIButton *)selectButton
{
    if ([self.delegate respondsToSelector:@selector(consultantDetailIconCell:didClickSelectButton:)]) {
        [self.delegate consultantDetailIconCell:self didClickSelectButton:selectButton];
    }
}

#pragma mark ----- cell创建的便利方法
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"MyConsultantIconCell";
    
    SLConsultantDetailIconCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[SLConsultantDetailIconCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    return cell;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
