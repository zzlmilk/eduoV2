//
//  SLVipProductHeadView.m
//  02-pigBank
//
//  Created by 陆承东 on 14-9-24.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLVipProductHeadView.h"
#import "UIImageView+WebCache.h"

#define margin 10

@interface SLVipProductHeadView()

/** topImageView */
@property (nonatomic, weak) UIImageView *topImageView;

/** coverView */
@property (nonatomic, weak) UIView *coverView;

/** titleLabel */
@property (nonatomic, weak) UILabel *titleLabel;

/** scoreLabel */
@property (nonatomic, weak) UILabel *scoreLabel;

/** scoreValueLabel */
@property (nonatomic, weak) UILabel *scoreValueLabel;

@end

@implementation SLVipProductHeadView

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
    UIImageView *topImageView = [[UIImageView alloc] init];
    [self addSubview:topImageView];
    self.topImageView = topImageView;
    
    /** coverView */
    UIView *coverView = [[UIView alloc] init];
    [self.topImageView addSubview:coverView];
    self.coverView = coverView;
    
    /** titleLabel */
    UILabel *titleLabel = [[UILabel alloc] init];
    [self.coverView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    /** scoreLabel */
    UILabel *scoreLabel = [[UILabel alloc] init];
    [self.coverView addSubview:scoreLabel];
    self.scoreLabel = scoreLabel;
    
    /** scoreValueLabel */
    UILabel *scoreValueLabel = [[UILabel alloc] init];
    [self.coverView addSubview:scoreValueLabel];
    self.scoreValueLabel = scoreValueLabel;
}

- (void)setPrivilegeProduct:(SLPrivilegeProduct *)privilegeProduct
{
    _privilegeProduct = privilegeProduct;
    
    [self setupAllSubviews];
}
/**
 *  设置子控件的所有属性
 */
- (void)setupAllSubviews
{
    
    /** topImageView */
    // frame
    CGFloat topImageViewX = 0;
    CGFloat topImageViewY = 0;
    CGFloat topImageViewW = [UIScreen mainScreen].bounds.size.width;
    CGFloat topImageViewH = 200;
    self.topImageView.frame = CGRectMake(topImageViewX, topImageViewY, topImageViewW, topImageViewH);
    // data
    [self.topImageView setImageWithURL:[NSURL URLWithString:self.privilegeProduct.privilegeDetail.pictureUrl] placeholderImage:[UIImage imageNamed:@"app_bg_default_home_img_normal"]];
    
    /** coverView */
    // frame
    CGFloat coverViewW = topImageViewW;
    CGFloat coverViewH = 30;
    CGFloat coverViewX = 0;
    CGFloat coverViewY = topImageViewH - coverViewH;
    self.coverView.frame = CGRectMake(coverViewX, coverViewY, coverViewW, coverViewH);
    // data
    self.coverView.backgroundColor = [UIColor blackColor];
    self.coverView.alpha = 0.8;
    
    /** titleLabel */
    CGFloat titleLabelW = 230;
    CGFloat titleLabelH = 30;
    CGFloat titleLabelX = margin;
    CGFloat titleLabelY = 0;
    self.titleLabel.frame = CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
    // data
    self.titleLabel.numberOfLines = 1;
    self.titleLabel.font = SLBoldFont14;
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.text = self.privilegeProduct.title;
    
    /** scoreLabel */
    CGFloat scoreLabelX = CGRectGetMaxX(self.titleLabel.frame) + margin;
    CGFloat scoreLabelY = 0;
    CGFloat scoreLabelW = 35;
    CGFloat scoreLabelH = 30;
    self.scoreLabel.frame = CGRectMake(scoreLabelX, scoreLabelY, scoreLabelW, scoreLabelH);
    // data
    self.scoreLabel.numberOfLines = 1;
    self.scoreLabel.textColor = [UIColor whiteColor];
    self.scoreLabel.font = SLBoldFont14;
    self.scoreLabel.text = @"评分:";
    
    /** scoreValueLabel */
    CGFloat scoreValueLabelX = CGRectGetMaxX(self.scoreLabel.frame);
    CGFloat scoreValueLabelY = 0;
    CGFloat scoreValueLabelW = 35;
    CGFloat scoreValueLabelH = 30;
    self.scoreValueLabel.frame = CGRectMake(scoreValueLabelX, scoreValueLabelY, scoreValueLabelW, scoreValueLabelH);
    // data
    self.scoreValueLabel.numberOfLines = 1;
    self.scoreValueLabel.textColor = [UIColor orangeColor];
    self.scoreValueLabel.font = SLBoldFont14;
    NSNumber *greadScore = self.privilegeProduct.privilegeDetail.merchantDetail.gradeScore;
    self.scoreValueLabel.text = [NSString stringWithFormat:@"%.1f", [greadScore doubleValue]];
}

@end
