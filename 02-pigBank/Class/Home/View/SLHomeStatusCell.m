//
//  SLHomeStatusCell.m
//  02-pigBank
//
//  Created by 陆承东 on 14-9-18.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLHomeStatusCell.h"
#import "SLHomeStatusFrame.h"
#import "SLHomeStatus.h"
#import "UIImageView+WebCache.h"

@interface SLHomeStatusCell ()

/** dateLabel */
@property (nonatomic, weak) UILabel *dateLabel;
/** extPicture 图标 */
@property (nonatomic, weak) UIImageView *extPictureView;
/** title */
@property (nonatomic, weak) UILabel *titleLabel;
/** 赞的图标 */
@property (nonatomic, weak) UIImageView *likeView;
/** praiseCounts */
@property (nonatomic, weak) UILabel *praiseCountsLabel;

@end

@implementation SLHomeStatusCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"homeStatusCell";
    
    SLHomeStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[SLHomeStatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
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

- (void)setupStatusSubviews
{
    /** dateLabel */
    UILabel *dateLabel = [[UILabel alloc] init];
    [self.contentView addSubview:dateLabel];
    self.dateLabel = dateLabel;
    
    /** extPicture 图标 */
    UIImageView *extPictureView = [[UIImageView alloc] init];
    extPictureView.layer.cornerRadius = 10;
    extPictureView.clipsToBounds = YES;
    [self.contentView addSubview:extPictureView];
    self.extPictureView = extPictureView;
    
    /** title */
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = SLHomeStatusTitleFont;
    titleLabel.numberOfLines = 0;
    [self.contentView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    /** 赞的图标 */
    UIImageView *likeView = [[UIImageView alloc] init];
    likeView.contentMode = UIViewContentModeCenter;
    [self.contentView addSubview:likeView];
    self.likeView = likeView;
    
    /** praiseCounts */
    UILabel *praiseCountsLabel = [[UILabel alloc] init];
    praiseCountsLabel.font = SLHomeStatusPraiseCountsFont;
    [self.contentView addSubview:praiseCountsLabel];
    self.praiseCountsLabel = praiseCountsLabel;
}

- (void)setHomeStatusFrame:(SLHomeStatusFrame *)homeStatusFrame
{
    _homeStatusFrame = homeStatusFrame;
    
    // 设置所有子控件的尺寸和数据
    [self setupSubviewsData];
}

// 设置所有子控件的尺寸和数据
- (void)setupSubviewsData
{
    SLHomeStatus *homeStatus = self.homeStatusFrame.homeStatus;
    
    /** dateLabel */
    // frame
//    self.dateLabel.frame = self.homeStatusFrame.dateLabelF;
//    // data
//    NSDate *date = [NSDate dateWithTimeIntervalSince1970:self.homeStatusFrame.homeStatus.verifyTime];
//    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
//    [dateFormat setDateFormat:@"dd日MM月"];
//    NSString *dateStr = [dateFormat stringFromDate:date];
//    self.dateLabel.text = dateStr;
//    self.dateLabel.backgroundColor = SLColor(226, 231, 235);
//    self.dateLabel.font = SLBoldFont18;
    
    /** extPicture标 */
    // frame
    self.extPictureView.frame = self.homeStatusFrame.extPictureViewF;
    // image
    [self.extPictureView setImageWithURL:[NSURL URLWithString:homeStatus.extPictureUrl] placeholderImage:[UIImage imageNamed:@"app_bg_default_home_img_normal"]];
    
    /** title */
    // frame
    self.titleLabel.frame = self.homeStatusFrame.titleLabelF;
    // title
    if (homeStatus.templetType == 3) {
        self.titleLabel.text = [NSString stringWithFormat:@"【尊享理财】%@", homeStatus.title];
    } else {
        self.titleLabel.text = [NSString stringWithFormat:@"【VIP特权】%@", homeStatus.title];
    }
    
    
    /** 赞的图标 */
    // frame
    self.likeView.frame = self.homeStatusFrame.likeViewF;
    // image
    self.likeView.image = [UIImage imageNamed:@"xiaoZan"];
    
    /** praiseCounts */
    // frame
    self.praiseCountsLabel.frame = self.homeStatusFrame.praiseCountsLabelF;
    // praiseCounts
    self.praiseCountsLabel.text = [NSString stringWithFormat:@"%ld人很喜欢", homeStatus.praiseCounts];
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
