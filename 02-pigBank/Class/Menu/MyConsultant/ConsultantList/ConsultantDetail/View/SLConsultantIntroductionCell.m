//
//  SLConsultantIntroductionCell.m
//  02-pigBank
//
//  Created by 陆承东 on 15/1/12.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import "SLConsultantIntroductionCell.h"

#import "NSString+S_LINE.h"

@interface SLConsultantIntroductionCell ()

@property (nonatomic, weak) UILabel *introductionLabel;

@end

@implementation SLConsultantIntroductionCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 1.添加status内部所有的子控件
        [self addSubviews];
    }
    return self;
}

#pragma mark ----- addSubviews添加所有子控件
- (void)addSubviews
{
    UILabel *introductionLabel = [[UILabel alloc] init];
    self.introductionLabel = introductionLabel;
    [self addSubview:introductionLabel];
}

- (void)setConsultant:(SLConsultant *)consultant
{
    _consultant = consultant;
    
    [self setSubviewsData];
}

#pragma mark ----- setSubviewsData设置子控件数据
- (void)setSubviewsData
{
    CGFloat introductionLabelX = middleMargin;
    CGFloat introductionLabelY = middleMargin;
    CGSize introductionLabelS = [self.consultant.introduction sizeWithFont:SLFont14 maxSize:CGSizeMake(screenW - largeMargin, CGFLOAT_MAX)];
    CGRect introductionLabelF = CGRectMake(introductionLabelX, introductionLabelY, screenW - largeMargin, introductionLabelS.height);
    self.introductionLabel.frame = introductionLabelF;
    self.introductionLabel.textColor = [UIColor blackColor];
    if (self.consultant.introduction == nil) {
        self.introductionLabel.text = [NSString stringWithFormat:@"简介：暂无简介%@", self.consultant.introduction];
    } else {
        self.introductionLabel.text = [NSString stringWithFormat:@"简介：%@", self.consultant.introduction];
    }
    self.introductionLabel.font = SLFont14;
}

#pragma mark ----- cell创建的便利方法
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"SLConsultantIntroductionCell";
    
    SLConsultantIntroductionCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[SLConsultantIntroductionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    return cell;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
