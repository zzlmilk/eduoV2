//
//  SLActivityDetailSignCell.m
//  02-pigBank
//
//  Created by 陆承东 on 15/1/21.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import "SLActivityDetailSignCell.h"

#import "UIImageView+WebCache.h"

@interface SLActivityDetailSignCell ()

@property (nonatomic, weak) UIImageView *iconImageView;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UIButton *signButton;

@end

@implementation SLActivityDetailSignCell

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
    static NSString *ID = @"SLActivityDetailSignCell";
    
    SLActivityDetailSignCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[SLActivityDetailSignCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    return cell;
}

#pragma mark ----- 添加所有子控件
- (void)addSubviews
{
    CGFloat iconImageViewX = 2;
    CGFloat iconImageViewY = 2;
    CGFloat iconImageViewW = 40;
    CGFloat iconImageViewH = 40;
    UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(iconImageViewX, iconImageViewY, iconImageViewW, iconImageViewH)];
    iconImageView.contentMode = UIViewContentModeCenter;
    self.iconImageView = iconImageView;
    [self.contentView addSubview:iconImageView];
    
    CGFloat signButtonW = 80;
    CGFloat signButtonH = 30;
    CGFloat signButtonX = screenW - middleMargin - signButtonW;
    CGFloat signButtonY = 7;
    UIButton *signButton = [[UIButton alloc] initWithFrame:CGRectMake(signButtonX, signButtonY, signButtonW, signButtonH)];
    [signButton setTitle:@"立即报名" forState:UIControlStateNormal];
    [signButton setTitle:@"已报名" forState:UIControlStateDisabled];
    [signButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    signButton.titleLabel.font = SLFont14;
    [signButton setBackgroundImage:[UIImage imageNamed:@"activity_button_normal"] forState:UIControlStateNormal];
    [signButton setBackgroundImage:[UIImage imageNamed:@"activity_button_disable"] forState:UIControlStateDisabled];
    signButton.layer.cornerRadius = 3;
    signButton.clipsToBounds = YES;
    [signButton addTarget:self action:@selector(signButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.signButton = signButton;
    [self.contentView addSubview:signButton];
    
    CGFloat titleLabelX = CGRectGetMaxX(iconImageView.frame) + smallMargin;
    CGFloat titleLabelY = iconImageViewY;
    CGFloat titleLabelW = signButtonX - titleLabelX - middleMargin;
    CGFloat titleLabelH = iconImageViewH;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH)];
    titleLabel.font = SLFont16;
    self.titleLabel = titleLabel;
    self.titleLabel.contentMode = UIViewContentModeCenter;
    [self.contentView addSubview:titleLabel];
}

#pragma mark ----- signButton点击事件
- (void)signButtonClick:(UIButton *)signButton
{
    if ([self.delegate respondsToSelector:@selector(activityDetailSignCell:didClickedSignButton:)]) {
        [self.delegate activityDetailSignCell:self didClickedSignButton:signButton];
    }
}

- (void)setActivityDetail:(SLActivityDetail *)activityDetail
{
    _activityDetail = activityDetail;
    
    self.iconImageView.image = [UIImage imageNamed:@"icon_image_person"];
    
    self.titleLabel.text = [NSString stringWithFormat:@"已报名  %@人", activityDetail.signCount];
    
    self.signButton.enabled = ![activityDetail.isSign intValue];
}

#pragma mark ----- 设置按钮为已报名状态
- (void)setButtonDisable
{
    self.signButton.enabled = NO;
    
    long long signCount = [self.activityDetail.signCount longLongValue];
    NSString *addSignCount = [NSString stringWithFormat:@"%lld", (signCount + 1)];
    self.titleLabel.text = [NSString stringWithFormat:@"已报名  %@人", addSignCount];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
