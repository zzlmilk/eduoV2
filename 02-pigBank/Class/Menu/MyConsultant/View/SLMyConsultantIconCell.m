//
//  SLMyConsultantIconCell.m
//  02-pigBank
//
//  Created by 陆承东 on 15/1/10.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import "SLMyConsultantIconCell.h"

#import "UIImageView+WebCache.h"

@interface SLMyConsultantIconCell ()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation SLMyConsultantIconCell

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
    [self addSubview:iconImageView];
    self.iconImageView = iconImageView;
    
    UILabel *nameLabel = [[UILabel alloc] init];
    [self addSubview:nameLabel];
    self.nameLabel = nameLabel;
}

- (void)setMyConsultant:(SLConsultant *)myConsultant
{
    _myConsultant = myConsultant;
    
    [self setSubviewsData];
}

#pragma mark ----- setSubviewsData设置子控件数据
- (void)setSubviewsData
{
    CGFloat iconImageViewX = middleMargin;
    CGFloat iconImageViewY = middleMargin;
    CGFloat iconImageViewW = 60;
    CGFloat iconImageViewH = iconImageViewW;
    CGRect iconImageViewF = CGRectMake(iconImageViewX, iconImageViewY, iconImageViewW, iconImageViewH);
    self.iconImageView.frame = iconImageViewF;
    self.iconImageView.layer.cornerRadius = 5;
    self.iconImageView.clipsToBounds = YES;
    [self.iconImageView setImageWithURL:[NSURL URLWithString:self.myConsultant.pictureUrl] placeholderImage:[UIImage imageNamed:@"moRenTouXiang"]];
    
    CGFloat nameLabelX = CGRectGetMaxX(iconImageViewF) + middleMargin;
    CGFloat nameLabelY = iconImageViewY;
    CGFloat nameLabelW = screenW - nameLabelX - middleMargin;
    CGFloat nameLabelH = 20;
    CGRect nameLabelF = CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    self.nameLabel.frame = nameLabelF;
    self.nameLabel.textColor = [UIColor blackColor];
    self.nameLabel.font = SLBoldFont17;
    self.nameLabel.text = self.myConsultant.dispName;
}

#pragma mark ----- cell创建的便利方法
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"MyConsultantIconCell";
    
    SLMyConsultantIconCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[SLMyConsultantIconCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    return cell;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
