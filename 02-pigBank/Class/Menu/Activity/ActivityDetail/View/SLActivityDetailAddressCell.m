//
//  SLActivityDetailAddressCell.m
//  02-pigBank
//
//  Created by 陆承东 on 15/1/22.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import "SLActivityDetailAddressCell.h"

@interface SLActivityDetailAddressCell ()

@property (nonatomic, weak) UIImageView *iconImageView;
@property (nonatomic, weak) UILabel *titleLabel;

@end

@implementation SLActivityDetailAddressCell

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
    static NSString *ID = @"SLActivityDetailAddressCell";
    
    SLActivityDetailAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[SLActivityDetailAddressCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    return cell;
}

#pragma mark ----- 添加所有子控件
- (void)addSubviews
{
    UIImageView *iconImageView = [[UIImageView alloc] init];
    iconImageView.contentMode = UIViewContentModeCenter;
    self.iconImageView = iconImageView;
    [self.contentView addSubview:iconImageView];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = SLFont16;
    self.titleLabel = titleLabel;
    self.titleLabel.contentMode = UIViewContentModeCenter;
    [self.contentView addSubview:titleLabel];
}

- (void)setActivityDetailFrame:(SLActivityDetailFrame *)activityDetailFrame
{
    _activityDetailFrame = activityDetailFrame;
    
    CGFloat iconImageViewX = 2;
    CGFloat iconImageViewY = 2;
    CGFloat iconImageViewW = 40;
    CGFloat iconImageViewH = activityDetailFrame.addressHeight;
    self.iconImageView.frame = CGRectMake(iconImageViewX, iconImageViewY, iconImageViewW, iconImageViewH);
    self.iconImageView.image = [UIImage imageNamed:@"icon_image_location"];
    
    CGFloat titleLabelX = CGRectGetMaxX(self.iconImageView.frame) + smallMargin;
    CGFloat titleLabelY = 0;
    CGFloat titleLabelW = screenW - largeMargin * 3;
    CGFloat titleLabelH = activityDetailFrame.addressHeight;
    self.titleLabel.frame = CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
    self.titleLabel.contentMode = UIViewContentModeCenter;
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.text = activityDetailFrame.activityDetail.address;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
