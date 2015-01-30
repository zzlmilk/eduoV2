//
//  SLConsultantListCell.m
//  02-pigBank
//
//  Created by 陆承东 on 15/1/12.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import "SLConsultantListCell.h"

#import "UIImageView+WebCache.h"

@interface SLConsultantListCell ()

@property (nonatomic, weak) UIView *leftFlagView;
@property (nonatomic, weak) UIImageView *iconImageView;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UIImageView *rightFlagImageView;

@end

@implementation SLConsultantListCell

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
    UIView *leftFlagView = [[UIView alloc] init];
    self.leftFlagView = leftFlagView;
    [self addSubview:leftFlagView];
    
    UIImageView *iconImageView = [[UIImageView alloc] init];
    self.iconImageView = iconImageView;
    [self addSubview:iconImageView];
    
    UILabel *nameLabel = [[UILabel alloc] init];
    self.nameLabel = nameLabel;
    [self addSubview:nameLabel];
    
    UIImageView *rightFlagImageView = [[UIImageView alloc] init];
    self.rightFlagImageView = rightFlagImageView;
    [self addSubview:rightFlagImageView];
}

- (void)setConsultant:(SLConsultant *)consultant
{
    _consultant = consultant;
    
    [self setSubviewsData];
}

#pragma mark ----- setSubviewsData设置子控件数据
- (void)setSubviewsData
{
    CGFloat leftFlagViewX = 0;
    CGFloat leftFlagViewY = 0;
    CGFloat leftFlagViewW = 3;
    CGFloat leftFlagViewH = 60;
    CGRect leftFlagViewF = CGRectMake(leftFlagViewX, leftFlagViewY, leftFlagViewW, leftFlagViewH);
    self.leftFlagView.frame = leftFlagViewF;
    
    CGFloat iconImageViewX = middleMargin;
    CGFloat iconImageViewY = middleMargin;
    CGFloat iconImageViewW = 40;
    CGFloat iconImageViewH = iconImageViewW;
    CGRect iconImageViewF = CGRectMake(iconImageViewX, iconImageViewY, iconImageViewW, iconImageViewH);
    self.iconImageView.frame = iconImageViewF;
    self.iconImageView.layer.cornerRadius = 5;
    self.iconImageView.clipsToBounds = YES;
    [self.iconImageView setImageWithURL:[NSURL URLWithString:self.consultant.pictureUrl] placeholderImage:[UIImage imageNamed:@"moRenTouXiang"]];
    
    CGFloat rightFlagImageViewW = 27;
    CGFloat rightFlagImageViewH = 40;
    CGFloat rightFlagImageViewX = screenW - middleMargin - rightFlagImageViewW;
    CGFloat rightFlagImageViewY = iconImageViewY;
    CGRect rightFlagImageViewF = CGRectMake(rightFlagImageViewX, rightFlagImageViewY, rightFlagImageViewW, rightFlagImageViewH);
    self.rightFlagImageView.frame = rightFlagImageViewF;
    self.rightFlagImageView.contentMode = UIViewContentModeCenter;
    
    if ([self.userId intValue] == [self.consultant.userId intValue]) {
        self.leftFlagView.backgroundColor = SLColor(125, 36, 126);
        self.rightFlagImageView.image = [UIImage imageNamed:@"xuanZhong"];
    } else {
        self.leftFlagView.backgroundColor = [UIColor clearColor];
        self.rightFlagImageView.image = nil;
    }
    
    CGFloat nameLabelX = CGRectGetMaxX(iconImageViewF) + middleMargin;
    CGFloat nameLabelY = iconImageViewY + 10;
    CGFloat nameLabelW = screenW - nameLabelX - rightFlagImageViewW - largeMargin;
    CGFloat nameLabelH = 20;
    CGRect nameLabelF = CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    self.nameLabel.frame = nameLabelF;
    self.nameLabel.textColor = [UIColor blackColor];
    self.nameLabel.font = SLFont14;
    self.nameLabel.text = self.consultant.dispName;
}

#pragma mark ----- cell创建的便利方法
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"MyConsultantIconCell";
    
    SLConsultantListCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[SLConsultantListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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
