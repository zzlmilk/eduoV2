//
//  SLMerchantHeadCell.m
//  02-pigBank
//
//  Created by 陆承东 on 14/10/23.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLMerchantHeadCell.h"

#import "SLMerchantHeadCellFrame.h"

#import "UIImageView+WebCache.h"

@interface SLMerchantHeadCell()

@property (nonatomic, weak) UIImageView *iconImageView;

@property (nonatomic, weak) UILabel *titleLabel;

@property (nonatomic, weak) UILabel *subTitleLabel;

@end

@implementation SLMerchantHeadCell

#pragma mark - 初始化
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"SLMerchantHeadCell";
    SLMerchantHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[SLMerchantHeadCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addContentView];
    }
    return self;
}

// 添加所有子控件
- (void)addContentView
{
    UIImageView *iconImageView = [[UIImageView alloc] init];
    self.iconImageView = iconImageView;
    [self.contentView addSubview:iconImageView];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    self.titleLabel = titleLabel;
    [self.contentView addSubview:titleLabel];
    
    UILabel *subTitleLabel = [[UILabel alloc] init];
    self.subTitleLabel = subTitleLabel;
    [self.contentView addSubview:subTitleLabel];
    
    UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(0, 69, [UIScreen mainScreen].bounds.size.width, 0.5)];
    separator.backgroundColor = SLColorRGBA(0, 0, 0, 0.2);
    [self.contentView addSubview:separator];
}

- (void)setItem:(SLMerchantDetailItem *)item
{
    _item = item;
    
    SLMerchantHeadCellFrame *merchantHeadFrame = item.merchantDetailFrame.merchantHeadCellFrame;
    
    self.iconImageView.frame = merchantHeadFrame.iconImageViewF;
    [self.iconImageView setImageWithURL:[NSURL URLWithString:item.merchantDetailFrame.merchantDetail.certificateUrl] placeholderImage:[UIImage imageNamed:@"app_bg_default_home_img_normal"]];
    
    self.titleLabel.frame = item.merchantDetailFrame.merchantHeadCellFrame.titleLabelF;
    self.titleLabel.text = item.merchantDetailFrame.merchantDetail.fullName;
    self.titleLabel.font = SLFont18;
    self.titleLabel.textColor = [UIColor blackColor];
    
    self.subTitleLabel.frame = item.merchantDetailFrame.merchantHeadCellFrame.subTitleLabelF;
    self.subTitleLabel.text = [NSString stringWithFormat:@"评分: %@", item.merchantDetailFrame.merchantDetail.gradeScore];
    self.subTitleLabel.font = SLFont12;
    self.subTitleLabel.textColor = [UIColor grayColor];
}

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
