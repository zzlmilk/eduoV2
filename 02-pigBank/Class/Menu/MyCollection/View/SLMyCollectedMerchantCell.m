//
//  SLMyCollectedMerchantCell.m
//  02-pigBank
//
//  Created by 陆承东 on 15/1/7.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import "SLMyCollectedMerchantCell.h"

#import "UIImageView+WebCache.h"

@interface SLMyCollectedMerchantCell ()

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

/** distabceLabel */
@property (nonatomic, weak) UILabel *distabceLabel;

@end

@implementation SLMyCollectedMerchantCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"myCollectedMerchantCell";
    
    SLMyCollectedMerchantCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[SLMyCollectedMerchantCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 1.添加status内部所有的子控件
        [self setupStatusSubviews];
    }
    return self;
}

#pragma mark ----- setupStatusSubviews ----- 添加status内部所有的子控件
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
    titleLabel.font = SLBoldFont14;
    titleLabel.numberOfLines = 1;
    [self.contentView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    /** adressLabel */
    UILabel *adressLabel = [[UILabel alloc] init];
    adressLabel.font = SLFont12;
    [self.contentView addSubview:adressLabel];
    self.adressLabel = adressLabel;
    
    /** 赞的图标 */
    UIImageView *likeView = [[UIImageView alloc] init];
    likeView.contentMode = UIViewContentModeCenter;
    [self.contentView addSubview:likeView];
    self.likeView = likeView;
    
    /** priseCountLabel */
    UILabel *priseCountLabel = [[UILabel alloc] init];
    priseCountLabel.font = SLFont12;
    [self.contentView addSubview:priseCountLabel];
    self.priseCountLabel = priseCountLabel;
    
    /** distabceLabel */
    UILabel *distabceLabel = [[UILabel alloc] init];
    distabceLabel.font = SLFont12;
    [self.contentView addSubview:distabceLabel];
    self.distabceLabel = distabceLabel;
}

- (void)setMerchantStatusFrame:(SLMyMerchantCellFrame *)merchantStatusFrame
{
    _merchantStatusFrame = merchantStatusFrame;
    
    // 设置所有子控件的尺寸和数据
    [self setupSubviewsData];
}

- (void)setupSubviewsData
{
    SLMerchantStatus *merchantDetail = self.merchantStatusFrame.merchantDetial;
    
    /** pictureImageView */
    // frame
    self.pictureImageView.frame = self.merchantStatusFrame.pictureImageViewF;
    // image
    [self.pictureImageView setImageWithURL:[NSURL URLWithString:merchantDetail.merchantUserInfo.pictureUrl] placeholderImage:[UIImage imageNamed:@"app_bg_default_home_img_normal"]];
    
    /** titleLabel */
    // frame
    self.titleLabel.frame = self.merchantStatusFrame.titleLabelF;
    // title
    self.titleLabel.text = merchantDetail.fullName;
    
    /** adressLabel */
    // frame
    self.adressLabel.frame = self.merchantStatusFrame.adressLabelF;
    // image
    self.adressLabel.text = merchantDetail.address;
    
    /** 赞的图标 */
    // frame
    self.likeView.frame = self.merchantStatusFrame.likeViewF;
    // image
    self.likeView.image = [UIImage imageNamed:@"xiaoZan"];
    
    /** priseCountLabel */
    // frame
    self.priseCountLabel.frame = self.merchantStatusFrame.priseCountLabelF;
    // praiseCounts
    self.priseCountLabel.text = [NSString stringWithFormat:@"%@人很喜欢", merchantDetail.praiseCounts];
    
    /** distabceLabel */
    // frame
    self.distabceLabel.frame = self.merchantStatusFrame.distanceLabelF;
    // data
    if ([merchantDetail.distanceToMe doubleValue] == 0) {
        self.distabceLabel.hidden = YES;
    } else if ([merchantDetail.distanceToMe doubleValue] > 5.0) {
        self.distabceLabel.text = @">5千米";
    } else {
        self.distabceLabel.text = [NSString stringWithFormat:@"%.2f千米", [merchantDetail.distanceToMe doubleValue]];
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
