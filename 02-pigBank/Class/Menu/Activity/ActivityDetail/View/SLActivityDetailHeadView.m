//
//  SLActivityDetailHeadView.m
//  02-pigBank
//
//  Created by 陆承东 on 15/1/21.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import "SLActivityDetailHeadView.h"

#import "UIImageView+WebCache.h"

@interface SLActivityDetailHeadView ()

@property (nonatomic, weak) UIImageView *topImageView;
@property (nonatomic, weak) UIView *coverView;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *scoreLabel;
@property (nonatomic, weak) UILabel *scoreValueLabel;

@end

@implementation SLActivityDetailHeadView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 添加所有子控件
        [self addAllSubViews];
    }
    return self;
}

/**
 *  添加所有子控件
 */
- (void)addAllSubViews
{
    /** topImageView */
    CGFloat topImageViewX = 0;
    CGFloat topImageViewY = 0;
    CGFloat topImageViewW = screenW;
    CGFloat topImageViewH = 200;
    UIImageView *topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(topImageViewX, topImageViewY, topImageViewW, topImageViewH)];
    [self addSubview:topImageView];
    self.topImageView = topImageView;
    
    /** coverView */
    CGFloat coverViewW = topImageViewW;
    CGFloat coverViewH = 30;
    CGFloat coverViewX = 0;
    CGFloat coverViewY = topImageViewH - coverViewH;
    UIView *coverView = [[UIView alloc] initWithFrame:CGRectMake(coverViewX, coverViewY, coverViewW, coverViewH)];
    [self.topImageView addSubview:coverView];
    self.coverView = coverView;
    
    /** titleLabel */
    CGFloat titleLabelW = screenW - largeMargin;
    CGFloat titleLabelH = 30;
    CGFloat titleLabelX = middleMargin;
    CGFloat titleLabelY = 0;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH)];
    [self.coverView addSubview:titleLabel];
    self.titleLabel = titleLabel;
}

- (void)setActivityDetail:(SLActivityDetail *)activityDetail
{
    _activityDetail = activityDetail;
    
    [self setAllSubviews];
}

- (void)setAllSubviews
{
    
    /** topImageView */
    // frame
    
    // data
    [self.topImageView setImageWithURL:[NSURL URLWithString:self.activityDetail.pictureUrl] placeholderImage:[UIImage imageNamed:@"app_bg_default_home_img_normal"]];
    
    /** coverView */
    // frame
    // data
    self.coverView.backgroundColor = [UIColor blackColor];
    self.coverView.alpha = 0.8;
    
    /** titleLabel */
    // data
    self.titleLabel.numberOfLines = 1;
    self.titleLabel.font = SLBoldFont16;
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.text = self.activityDetail.title;
}

@end
