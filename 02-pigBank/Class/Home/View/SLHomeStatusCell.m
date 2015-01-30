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

@property (nonatomic, weak) UIView *DataView;
/** dateLabel */
@property (nonatomic, weak) UILabel *dateLabel;
@property (nonatomic, weak) UILabel *monthLabel;
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
    UIView *DataView = [[UIView alloc] init];
    self.DataView = DataView;
    [self.contentView addSubview:DataView];
    
    UILabel *dateLabel = [[UILabel alloc] init];
    [DataView addSubview:dateLabel];
    self.dateLabel = dateLabel;
    UILabel *monthLabel = [[UILabel alloc] init];
    [DataView addSubview:monthLabel];
    self.monthLabel = monthLabel;
    
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
    self.DataView.frame = self.homeStatusFrame.dateLabelF;
    self.DataView.backgroundColor = SLLightGray;
    
    // data
    CGRect dataLabelF = self.homeStatusFrame.dateLabelF;
    dataLabelF.size.width = 26;
    dataLabelF.origin.x = middleMargin;
    self.dateLabel.frame = dataLabelF;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[self.homeStatusFrame.homeStatus.verifyTime longLongValue]/1000];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd"];
    NSString *dateStr = [dateFormat stringFromDate:date];
//    self.dateLabel.textColor = SLWhite;
    self.dateLabel.font = SLBoldFont22;
    self.dateLabel.text = dateStr;
    
    CGRect monthLabelF = self.homeStatusFrame.dateLabelF;
    monthLabelF.origin.x = CGRectGetMaxX(dataLabelF);
    monthLabelF.origin.y += 8;
    monthLabelF.size.height -= 8;
    NSDateFormatter *dateFormatMonth = [[NSDateFormatter alloc] init];
    [dateFormatMonth setDateFormat:@"MM"];
    NSString *monthStr = [dateFormatMonth stringFromDate:date];
    if ([monthStr isEqualToString:@"01"]) {
        monthStr = @"一月";
    } else if ([monthStr isEqualToString:@"02"]) {
        monthStr = @"二月";
    } else if ([monthStr isEqualToString:@"03"]) {
        monthStr = @"三月";
    } else if ([monthStr isEqualToString:@"04"]) {
        monthStr = @"四月";
    } else if ([monthStr isEqualToString:@"05"]) {
        monthStr = @"五月";
    } else if ([monthStr isEqualToString:@"06"]) {
        monthStr = @"六月";
    } else if ([monthStr isEqualToString:@"07"]) {
        monthStr = @"七月";
    } else if ([monthStr isEqualToString:@"08"]) {
        monthStr = @"八月";
    } else if ([monthStr isEqualToString:@"09"]) {
        monthStr = @"九月";
    } else if ([monthStr isEqualToString:@"10"]) {
        monthStr = @"十月";
    } else if ([monthStr isEqualToString:@"11"]) {
        monthStr = @"十一月";
    } else if ([monthStr isEqualToString:@"12"]) {
        monthStr = @"十二月";
    }
    NSString *monthString;
    NSDate *nowData = [NSDate date];
    NSDateFormatter *dateFormat1 = [[NSDateFormatter alloc] init];
    [dateFormat1 setDateFormat:@"ddMM"];
    NSString *nowString = [dateFormat1 stringFromDate:nowData];
    NSString *timeString = [dateFormat1 stringFromDate:date];
    if ([nowString isEqualToString:timeString]) {
        monthString = [monthStr stringByAppendingString:@"  今天"];
    } else {
        monthString = monthStr;
    }
    self.monthLabel.frame = monthLabelF;
    self.monthLabel.font = SLFont12;
    self.monthLabel.contentMode = UIViewContentModeBottomLeft;
    self.monthLabel.text = monthString;
    
    /** extPicture标 */
    // frame
    self.extPictureView.frame = self.homeStatusFrame.extPictureViewF;
    // image
    [self.extPictureView setImageWithURL:[NSURL URLWithString:homeStatus.extPictureUrl] placeholderImage:[UIImage imageNamed:@"app_bg_default_home_img_normal"]];
    
    /** title */
    // frame
    self.titleLabel.frame = self.homeStatusFrame.titleLabelF;
    
    // title
    if ([homeStatus.templetType intValue] == 3) {
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
    self.praiseCountsLabel.text = [NSString stringWithFormat:@"%@人很喜欢", homeStatus.praiseCounts];
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
