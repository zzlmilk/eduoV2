//
//  SLVipStatusCell.m
//  02-pigBank
//
//  Created by 陆承东 on 14-9-23.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLVipStatusCell.h"
#import "SLVipStatusFrame.h"
#import "SLVipStatus.h"
#import "UIImageView+WebCache.h"

#define SLVipTitleFont [UIFont systemFont]

@interface SLVipStatusCell()

/** pictureImageView */
@property (nonatomic, weak) UIImageView *pictureImageView;

/** titleLabel */
@property (nonatomic, weak) UILabel *titleLabel;

/** 赞的图标 */
@property (nonatomic, weak) UIImageView *likeView;

/** adressLabel */
@property (nonatomic, weak) UILabel *adressLabel;

/** priseCountLabel */
@property (nonatomic, weak) UILabel *priseCountLabel;

@end

@implementation SLVipStatusCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"vipStatusCell";
    
    SLVipStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[SLVipStatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        // 1.添加status内部所有的子控件
        [self setupStatusSubviews];
    }
    return self;
}

/**
 *  setupStatusSubviews ----- 添加status内部所有的子控件
 */
- (void)setupStatusSubviews
{
    /** pictureImageView */
    UIImageView *pictureImageView = [[UIImageView alloc] init];
    pictureImageView.layer.cornerRadius = 10;
    pictureImageView.clipsToBounds = YES;
    [self.contentView addSubview:pictureImageView];
    self.pictureImageView = pictureImageView;
    
    /** titleLabel */
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = SLVipStatusTitleFont;
    titleLabel.numberOfLines = 1;
    [self.contentView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    /** adressLabel */
    UILabel *adressLabel = [[UILabel alloc] init];
    adressLabel.font = SLVipStatusPraiseCountsFont;
    [self.contentView addSubview:adressLabel];
    self.adressLabel = adressLabel;
    
    /** 赞的图标 */
    UIImageView *likeView = [[UIImageView alloc] init];
    likeView.contentMode = UIViewContentModeCenter;
    [self.contentView addSubview:likeView];
    self.likeView = likeView;
    
    /** priseCountLabel */
    UILabel *priseCountLabel = [[UILabel alloc] init];
    priseCountLabel.font = SLVipStatusPraiseCountsFont;
    [self.contentView addSubview:priseCountLabel];
    self.priseCountLabel = priseCountLabel;
}

/**
 *  setVipStatusFrame ----- 设置内部子控件的frame
 */
- (void)setVipStatusFrame:(SLVipStatusFrame *)vipStatusFrame
{
    _vipStatusFrame = vipStatusFrame;
    
    // 设置所有子控件的尺寸和数据
    [self setupSubviewsData];
}

/**
 *  setupSubviewsData ----- 设置所有子控件的尺寸和数据
 */
- (void)setupSubviewsData
{
    SLVipStatus *vipStatus = self.vipStatusFrame.vipStatus;
    
    /** pictureImageView */
    // frame
    self.pictureImageView.frame = self.vipStatusFrame.pictureImageViewF;
    // image
    [self.pictureImageView setImageWithURL:[NSURL URLWithString:vipStatus.firstMaterialInfo.privilegeDetail.pictureUrl] placeholderImage:[UIImage imageNamed:@"app_bg_default_home_img_normal"]];
    
    /** titleLabel */
    // frame
    self.titleLabel.frame = self.vipStatusFrame.titleLabelF;
    // title
    self.titleLabel.text = vipStatus.firstMaterialInfo.title;
    
    /** adressLabel */
    // frame
    self.adressLabel.frame = self.vipStatusFrame.adressLabelF;
    // image
    self.adressLabel.text = vipStatus.firstMaterialInfo.privilegeDetail.merchantDetail.address;
    
    /** 赞的图标 */
    // frame
    self.likeView.frame = self.vipStatusFrame.likeViewF;
    // image
    self.likeView.image = [UIImage imageNamed:@"zan"];
    
    /** priseCountLabel */
    // frame
    self.priseCountLabel.frame = self.vipStatusFrame.priseCountLabelF;
    // praiseCounts
    self.priseCountLabel.text = [NSString stringWithFormat:@"%ld人很喜欢", vipStatus.firstMaterialInfo.praiseCounts];
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
