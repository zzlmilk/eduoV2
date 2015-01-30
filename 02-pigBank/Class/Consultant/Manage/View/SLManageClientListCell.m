//
//  SLManageClientListCell.m
//  02-pigBank
//
//  Created by 陆承东 on 15/1/28.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import "SLManageClientListCell.h"

#import "UIImageView+WebCache.h"

@interface SLManageClientListCell ()

@property (nonatomic, weak) UIImageView *iconImageView;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UIImageView *priseImageView;
@property (nonatomic, weak) UIImageView *collectImageView;

@end

@implementation SLManageClientListCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"SLManageClientListCell";
    
    SLManageClientListCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[SLManageClientListCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
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
    [self.contentView addSubview:iconImageView];
    
    UILabel *nameLabel = [[UILabel alloc] init];
    self.nameLabel = nameLabel;
    [self.contentView addSubview:nameLabel];
    
    UIImageView *priseImageView = [[UIImageView alloc] init];
    priseImageView.hidden = YES;
    self.priseImageView = priseImageView;
    [self.contentView addSubview:priseImageView];
    
    UIImageView *collectImageView = [[UIImageView alloc] init];
    collectImageView.hidden = YES;
    self.collectImageView = collectImageView;
    [self.contentView addSubview:collectImageView];
}

- (void)setManageClientFrame:(SLManageClientFrame *)manageClientFrame
{
    _manageClientFrame = manageClientFrame;
    
    [self setSubviewsData];
}

#pragma mark ----- 设置子控件数据
- (void)setSubviewsData
{
    SLClient *client = self.manageClientFrame.client;
    
    self.iconImageView.frame = self.manageClientFrame.iconImageViewF;
    [self.iconImageView setImageWithURL:[NSURL URLWithString:self.manageClientFrame.client.pictureUrl] placeholderImage:[UIImage imageNamed:@"moRenTouXiang"]];
    self.iconImageView.layer.cornerRadius = 5;
    self.iconImageView.clipsToBounds = YES;
    
    self.nameLabel.frame = self.manageClientFrame.nameLabelF;
    self.nameLabel.font = SLFont14;
    self.nameLabel.text = self.manageClientFrame.client.dispName;
    
    if (client.materialUser) {
        if ([client.materialUser.praiseFlag intValue] != 0) {
            self.priseImageView.hidden = NO;
            self.priseImageView.frame = self.manageClientFrame.priseImageViewF;
            self.priseImageView.image = [UIImage imageNamed:@"icon_image_praise_small_select"];
            if ([client.materialUser.collectFlag intValue] != 0) {
                self.collectImageView.hidden = NO;
                self.collectImageView.frame = self.manageClientFrame.collectImageViewF;
                self.collectImageView.image = [UIImage imageNamed:@"icon_image_collect_small_select"];
            } else {
                self.collectImageView.hidden = YES;
            }
        } else {
            self.priseImageView.hidden = YES;
            if ([client.materialUser.collectFlag intValue] != 0) {
                self.collectImageView.hidden = NO;
                self.collectImageView.frame = self.manageClientFrame.priseImageViewF;
                self.collectImageView.image = [UIImage imageNamed:@"icon_image_collect_small_select"];
            } else {
                self.collectImageView.hidden = YES;
            }
        }
    } else {
        self.priseImageView.hidden = YES;
        self.collectImageView.hidden = YES;
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
