//
//  SLFinancialProductListCell.m
//  02-pigBank
//
//  Created by 陆承东 on 14-9-27.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLFinancialProductListCell.h"

#import "SLFinancialLabel.h"
#import "SLFinanceProduct.h"
#import "SLFinancialProductsDetail.h"

@interface SLFinancialProductListCell()

/** extRiskLevelLabel */
@property (nonatomic, weak) SLFinancialLabel *extRiskLevelLabel;
/** title */
@property (nonatomic, weak) SLFinancialLabel *titleLabel;
/** deadlineLabel */
@property (nonatomic, weak) SLFinancialLabel *deadlineLabel;
/** deadlineDataLabel */
@property (nonatomic, weak) SLFinancialLabel *deadlineDataLabel;
/** leftTimeLabel */
@property (nonatomic, weak) SLFinancialLabel *leftTimeLabel;
/** leftTimeDataLabel */
@property (nonatomic, weak) SLFinancialLabel *leftTimeDataLabel;
/** expectedYieldLabel */
@property (nonatomic, weak) SLFinancialLabel *expectedYieldLabel;
/** expectedYieldDataLabel */
@property (nonatomic, weak) SLFinancialLabel *expectedYieldDataLabel;

@property (nonatomic, strong) SLFinanceProduct *financeProduct;

@end

@implementation SLFinancialProductListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 1.添加status内部所有的子控件
        [self setupStatusSubviews];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

/**
 *  快速创建cell的方法
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"financialStatusCell";
    
    SLFinancialProductListCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[SLFinancialProductListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    return cell;
}

// 添加status内部所有的子控件
- (void)setupStatusSubviews
{
    /** extRiskLevelLabel */
    SLFinancialLabel *extRiskLevelLabel = [[SLFinancialLabel alloc] init];
    extRiskLevelLabel.font = SLFont11;
    [self.contentView addSubview:extRiskLevelLabel];
    self.extRiskLevelLabel = extRiskLevelLabel;
    
    /** titleLabel */
    SLFinancialLabel *titleLabel = [[SLFinancialLabel alloc] init];
    titleLabel.font = SLFont14;
    [self.contentView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    /** deadlineLabel */
    SLFinancialLabel *deadlineLabel = [[SLFinancialLabel alloc] init];
    [self.contentView addSubview:deadlineLabel];
    self.deadlineLabel = deadlineLabel;
    
    /** deadlineDataLabel */
    SLFinancialLabel *deadlineDataLabel = [[SLFinancialLabel alloc] init];
    [self.contentView addSubview:deadlineDataLabel];
    self.deadlineDataLabel = deadlineDataLabel;
    
    /** leftTimeLabel */
    SLFinancialLabel *leftTimeLabel = [[SLFinancialLabel alloc] init];
    [self.contentView addSubview:leftTimeLabel];
    self.leftTimeLabel = leftTimeLabel;
    
    /** leftTimeDataLabel */
    SLFinancialLabel *leftTimeDataLabel = [[SLFinancialLabel alloc] init];
    [self.contentView addSubview:leftTimeDataLabel];
    self.leftTimeDataLabel = leftTimeDataLabel;
    
    /** expectedYieldLabel */
    SLFinancialLabel *expectedYieldLabel = [[SLFinancialLabel alloc] init];
    [self.contentView addSubview:expectedYieldLabel];
    self.expectedYieldLabel = expectedYieldLabel;
    
    /** expectedYieldDataLabel */
    SLFinancialLabel *expectedYieldDataLabel = [[SLFinancialLabel alloc] init];
    expectedYieldDataLabel.font = SLFont18;
    expectedYieldDataLabel.textColor = [UIColor orangeColor];
    [self.contentView addSubview:expectedYieldDataLabel];
    self.expectedYieldDataLabel = expectedYieldDataLabel;
}

- (void)setFinancialStatusFrame:(SLFinancialStatusFrame *)financialStatusFrame
{
    _financialStatusFrame = financialStatusFrame;
    
//    SLFinanceProduct *financeProduct = financialStatusFrame.financeProduct;
    
    self.financeProduct = financialStatusFrame.financeProduct;
    
    // 设置所有子控件的尺寸和数据
    [self setupSubviewsData];
}

// 设置所有子控件的尺寸和数据
- (void)setupSubviewsData
{
    /** extRiskLevelLabel */
    // frame
    self.extRiskLevelLabel.frame = self.financialStatusFrame.extRiskLevelLabelF;
    self.extRiskLevelLabel.layer.cornerRadius = 3;
    self.extRiskLevelLabel.clipsToBounds = YES;
    // text
    self.extRiskLevelLabel.text = self.financeProduct.financialProductsDetail.extRiskLevel;
    self.extRiskLevelLabel.textAlignment = NSTextAlignmentCenter;
    self.extRiskLevelLabel.textColor = [UIColor whiteColor];
    if ([self.extRiskLevelLabel.text isEqualToString:@"高风险"]) {
        self.extRiskLevelLabel.backgroundColor = [UIColor orangeColor];
    } else if ([self.extRiskLevelLabel.text isEqualToString:@"中风险"]) {
        self.extRiskLevelLabel.backgroundColor = [UIColor yellowColor];
    } else if ([self.extRiskLevelLabel.text isEqualToString:@"低风险"]) {
        self.extRiskLevelLabel.backgroundColor = [UIColor greenColor];
    }
    
    /** titleLabel */
    // frame
    self.titleLabel.frame = self.financialStatusFrame.titleLabelF;
    // text
    self.titleLabel.text = self.financeProduct.title;
    self.titleLabel.textColor = [UIColor blackColor];
    
    /** deadlineLabel */
    // frame
    self.deadlineLabel.frame = self.financialStatusFrame.deadlineLabelF;
    // text
    self.deadlineLabel.text = @"期限:";
    self.deadlineLabel.textColor = [UIColor grayColor];
    
    /** deadlineDataLabel */
    // frame
    self.deadlineDataLabel.frame = self.financialStatusFrame.deadlineDataLabelF;
    // title
    long long deadline = ([self.financeProduct.financialProductsDetail.valueDateTo longLongValue] - [self.financeProduct.financialProductsDetail.valueDateFrom longLongValue]) / 1000 / 60 / 60 / 24;
    self.deadlineDataLabel.text = [NSString stringWithFormat:@"%lld天", deadline];
    self.deadlineDataLabel.textColor = [UIColor grayColor];
    
    /** leftTimeLabelF */
    // frame
    self.leftTimeLabel.frame = self.financialStatusFrame.leftTimeLabelF;
    // title
    self.leftTimeLabel.text = @"认购时间剩余:";
    self.leftTimeLabel.textColor = [UIColor grayColor];
    
    /** leftTimeDataLabelF */
    // frame
    self.leftTimeDataLabel.frame = self.financialStatusFrame.leftTimeDataLabelF;
    // title
//    long long leftTime = (self.financeProduct.financialProductsDetail.subscribeEnd - self.financeProduct.financialProductsDetail.subscribeStart) / 1000 / 60 / 60 / 24;
    // 获取当前时间
    NSDate *now = [NSDate date];
    NSTimeInterval nowTimeInterval = [now timeIntervalSince1970];
    long long leftTime = ([self.financeProduct.financialProductsDetail.subscribeEnd longLongValue] / 1000 - nowTimeInterval) / 60 / 60 / 24;
    if (leftTime <= 0) {
        self.leftTimeDataLabel.text = [NSString stringWithFormat:@"已结束"];
    } else {
        self.leftTimeDataLabel.text = [NSString stringWithFormat:@"%lld天", leftTime];
    }
    self.leftTimeDataLabel.textColor = [UIColor grayColor];
    
    /** expectedYieldLabelF */
    // frame
    self.expectedYieldLabel.frame = self.financialStatusFrame.expectedYieldLabelF;
    // title
    self.expectedYieldLabel.text = @"预期年化收益率";
    self.expectedYieldLabel.textAlignment = NSTextAlignmentCenter;
    self.expectedYieldLabel.textColor = [UIColor blackColor];
    
    /** expectedYieldDataLabelF */
    // frame
    self.expectedYieldDataLabel.frame = self.financialStatusFrame.expectedYieldDataLabelF;
    // title
    self.expectedYieldDataLabel.textAlignment = NSTextAlignmentCenter;
    self.expectedYieldDataLabel.text = [NSString stringWithFormat:@"%@%%", self.financeProduct.financialProductsDetail.expectedYield];
    self.expectedYieldDataLabel.font = SLFont25;
    self.expectedYieldDataLabel.textColor = [UIColor orangeColor];
}

@end
