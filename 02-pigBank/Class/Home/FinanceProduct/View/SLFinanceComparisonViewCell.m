//
//  SLFinanceComparisonViewCell.m
//  02-pigBank
//
//  Created by 陆承东 on 14-9-22.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLFinanceComparisonViewCell.h"
#define labelW 40

@interface SLFinanceComparisonViewCell()

/** 收益率 */
@property (nonatomic, weak) UILabel *incomeLabel;
/** 横线 */
@property (nonatomic, weak) UIView *lineView;

@end

@implementation SLFinanceComparisonViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"financeComparisonViewCell";
    
    SLFinanceComparisonViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[SLFinanceComparisonViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
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
    /** 收益率 */
    UILabel *incomeLabel = [[UILabel alloc] init];
    incomeLabel.frame = CGRectMake(0, 0, labelW, 11);
    incomeLabel.contentMode = UIViewContentModeTop;
    incomeLabel.textAlignment = NSTextAlignmentCenter;
    incomeLabel.font = SLFinanceComparisonViewCellFont;
    incomeLabel.textColor = [UIColor blackColor];
    incomeLabel.numberOfLines = 0;
    [self.contentView addSubview:incomeLabel];
    self.incomeLabel = incomeLabel;
    
    /** 线 */
    UIView *lineView = [[UIImageView alloc] init];
    lineView.frame = CGRectMake(labelW, 5.5, self.frame.size.width - labelW, 0.5);
    lineView.alpha = 0.5;
    lineView.contentMode = UIViewContentModeTop;
    lineView.backgroundColor = [UIColor blackColor];
    [self.contentView addSubview:lineView];
    self.lineView = lineView;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setIncomeRatio:(double)incomeRatio
{
    _incomeRatio = incomeRatio;
    
    self.incomeLabel.text = [NSString stringWithFormat:@"%.2f%%", self.incomeRatio];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
