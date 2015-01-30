//
//  SLClientBrowseHistoryCell.m
//  02-pigBank
//
//  Created by 陆承东 on 15/1/21.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import "SLClientBrowseHistoryCell.h"

#import "UIImageView+WebCache.h"
#import "UIImageView+MJWebCache.h"

@interface SLClientBrowseHistoryCell ()

@property (nonatomic, weak) UIImageView *iconImageView;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UIImageView *priseImageView;
@property (nonatomic, weak) UIImageView *collectImageView;
@property (nonatomic, weak) UILabel *timeLabel;

@end

@implementation SLClientBrowseHistoryCell

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
    static NSString *ID = @"SLClientBrowseHistoryCell";
    
    SLClientBrowseHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[SLClientBrowseHistoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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
    
    UIImageView *priseImageView = [[UIImageView alloc] init];
    priseImageView.hidden = YES;
    self.priseImageView = priseImageView;
    [self.contentView addSubview:priseImageView];
    
    UIImageView *collectImageView = [[UIImageView alloc] init];
    collectImageView.hidden = YES;
    self.collectImageView = collectImageView;
    [self.contentView addSubview:collectImageView];
    
    UILabel *timeLabel = [[UILabel alloc] init];
    self.timeLabel = timeLabel;
    [self.contentView addSubview:timeLabel];
}

- (void)setMaterialBrowseHistoryFrame:(SLMaterialBrowseHistoryFrame *)materialBrowseHistoryFrame
{
    _materialBrowseHistoryFrame = materialBrowseHistoryFrame;
    SLMaterial *material = materialBrowseHistoryFrame.material;
    
    self.iconImageView.frame = materialBrowseHistoryFrame.iconImageViewF;
    [self.iconImageView setImageWithURL:[NSURL URLWithString:material.materialInfo.extPictureUrl] placeholderImage:[UIImage imageNamed:@"icon_image_placehold"]];
    self.iconImageView.layer.cornerRadius = 5;
    self.iconImageView.clipsToBounds = YES;
    
    self.titleLabel.frame = materialBrowseHistoryFrame.titleLabelF;
    self.titleLabel.font = SLBoldFont14;
    self.titleLabel.text = material.materialInfo.title;
    self.titleLabel.numberOfLines = 2;
    self.titleLabel.contentMode = UIViewContentModeCenter;
    
    if ([material.praiseFlag intValue] != 0) {
        self.priseImageView.hidden = NO;
        self.priseImageView.frame = materialBrowseHistoryFrame.priseImageViewF;
        self.priseImageView.image = [UIImage imageNamed:@"icon_image_praise_small_select"];
        if ([material.collectFlag intValue] != 0) {
            self.collectImageView.hidden = NO;
            self.collectImageView.frame = materialBrowseHistoryFrame.collectImageViewF;
            self.collectImageView.image = [UIImage imageNamed:@"icon_image_collect_small_select"];
        } else {
            self.collectImageView.hidden = YES;
        }
    } else {
        self.priseImageView.hidden = YES;
        if ([material.collectFlag intValue] != 0) {
            self.collectImageView.hidden = NO;
            self.collectImageView.frame = materialBrowseHistoryFrame.priseImageViewF;
            self.collectImageView.image = [UIImage imageNamed:@"icon_image_collect_small_select"];
        } else {
            self.collectImageView.hidden = YES;
        }
    }
    
    self.timeLabel.frame = materialBrowseHistoryFrame.timeLabelF;
    self.timeLabel.font = SLFont12;
    self.timeLabel.text = material.lastReadTimeStr;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
