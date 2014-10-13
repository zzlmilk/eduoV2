//
//  SLFinanceProductChartView.m
//  02-pigBank
//
//  Created by 陆承东 on 14-9-29.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLFinanceProductChartView.h"
#import "SLLabelView.h"

@interface SLFinanceProductChartView()

/** currentInterestButton */
@property (nonatomic, weak) SLLabelView *currentInterestView;
/** expEarningButton */
@property (nonatomic, weak) SLLabelView *expEarningView;
/** multipleLabel */
@property (nonatomic, weak) UILabel *multipleLabel;

/** 收益对比图 */
@property (nonatomic, weak) UITableView *comparisonView;
/** 期限按钮 */
@property (nonatomic, weak) UIButton *deadlineButton;
/** 期限数据按钮 */
@property (nonatomic, weak) UIButton *deadlineDataButton;
/** 风险按钮 */
@property (nonatomic, weak) UIButton *riskButton;
/** 风险数据按钮 */
@property (nonatomic, weak) UIButton *riskDataButton;
/** 起购额按钮 */
@property (nonatomic, weak) UIButton *minBuyLimitButton;
/** 起购额数据按钮 */
@property (nonatomic, weak) UIButton *minBuyLimitDataButton;
/** 手续费按钮 */
@property (nonatomic, weak) UIButton *feeButton;
/** 手续费数据按钮 */
@property (nonatomic, weak) UIButton *feeDataButton;

@end

@implementation SLFinanceProductChartView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

//- (void)addAllSubviews
//{
//    /** currentInterestView */
//    SLLabelView *currentInterestView = [[SLLabelView alloc] init];
//    //    currentInterestView.colorView.backgroundColor = SLColor(125, 36, 126);
//    //    currentInterestView.label.text = @"活期银行利息";
//    currentInterestView.label.font = SLFinanceProductContentFont;
//    [self addSubview:currentInterestView];
//    self.currentInterestView = currentInterestView ;
//    
//    /** expEarningView */
//    SLLabelView *expEarningView = [[SLLabelView alloc] init];
//    expEarningView.label.font = SLFinanceProductContentFont;
//    [self addSubview:expEarningView];
//    self.expEarningView = expEarningView;
//    
//    /** multipleLabel */
//    UILabel *multipleLabel = [[UILabel alloc] init];
//    multipleLabel.font = SLFinanceProductContentFont;
//    [self addSubview:multipleLabel];
//    self.multipleLabel = multipleLabel;
//    
//    
//    /** 收益对比图 */
//    UITableView *comparisonView = [[UITableView alloc] init];
//    comparisonView.backgroundColor = [UIColor redColor];
//    comparisonView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    comparisonView.delegate = self.superview;
//    comparisonView.dataSource = self.superview;
//    comparisonView.rowHeight = 26;
//    comparisonView.userInteractionEnabled = NO;
//    [self addSubview:comparisonView];
//    self.comparisonView = comparisonView;
//    
//    /** 期限按钮 */
//    UIButton *deadlineButton = [[UIButton alloc] init];
//    [self addSubview:deadlineButton];
//    [deadlineButton setBackgroundImage:[UIImage imageNamed:@"zuoLan"] forState:UIControlStateNormal];
//    deadlineButton.titleLabel.font = SLFinanceProductContentFont;
//    self.deadlineButton = deadlineButton;
//    
//    /** 期限数据按钮 */
//    UIButton *deadlineDataButton = [[UIButton alloc] init];
//    [deadlineDataButton setBackgroundImage:[UIImage imageNamed:@"youLan"] forState:UIControlStateNormal];
//    deadlineDataButton.titleLabel.font = SLFinanceProductContentFont;
//    [self addSubview:deadlineDataButton];
//    self.deadlineDataButton = deadlineDataButton;
//    
//    /** 风险按钮 */
//    UIButton *riskButton = [[UIButton alloc] init];
//    [riskButton setBackgroundImage:[UIImage imageNamed:@"zuo"] forState:UIControlStateNormal];
//    riskButton.titleLabel.font = SLFinanceProductContentFont;
//    [self addSubview:riskButton];
//    self.riskButton = riskButton;
//    
//    /** 风险数据按钮 */
//    UIButton *riskDataButton = [[UIButton alloc] init];
//    [riskDataButton setBackgroundImage:[UIImage imageNamed:@"you"] forState:UIControlStateNormal];
//    riskDataButton.titleLabel.font = SLFinanceProductContentFont;
//    [self addSubview:riskDataButton];
//    self.riskDataButton = riskDataButton;
//    
//    /** 起购额按钮 */
//    UIButton *minBuyLimitButton = [[UIButton alloc] init];
//    [minBuyLimitButton setBackgroundImage:[UIImage imageNamed:@"zuoLan"] forState:UIControlStateNormal];
//    minBuyLimitButton.titleLabel.font = SLFinanceProductContentFont;
//    [self addSubview:minBuyLimitButton];
//    self.minBuyLimitButton = minBuyLimitButton;
//    
//    /** 起购额数据按钮 */
//    UIButton *minBuyLimitDataButton = [[UIButton alloc] init];
//    [minBuyLimitDataButton setBackgroundImage:[UIImage imageNamed:@"youLan"] forState:UIControlStateNormal];
//    minBuyLimitDataButton.titleLabel.font = SLFinanceProductContentFont;
//    [self addSubview:minBuyLimitDataButton];
//    self.minBuyLimitDataButton = minBuyLimitDataButton;
//    
//    /** 手续费按钮 */
//    UIButton *feeButton = [[UIButton alloc] init];
//    [feeButton setBackgroundImage:[UIImage imageNamed:@"zuo"] forState:UIControlStateNormal];
//    feeButton.titleLabel.font = SLFinanceProductContentFont;
//    [self addSubview:feeButton];
//    self.feeButton = feeButton;
//    
//    /** 手续费数据按钮 */
//    UIButton *feeDataButton = [[UIButton alloc] init];
//    [feeDataButton setBackgroundImage:[UIImage imageNamed:@"you"] forState:UIControlStateNormal];
//    feeDataButton.titleLabel.font = SLFinanceProductContentFont;
//    [self addSubview:feeDataButton];
//    self.feeDataButton = feeDataButton;
//    
//    
//    
//    /** currentInterestButton */
//    self.currentInterestView.frame = self.financeProductFrame.currentInterestViewF;
//    self.currentInterestView.colorView.backgroundColor = SLColor(125, 36, 126);
//    self.currentInterestView.label.text = @"活期银行利息";
//    
//    /** expEarningButton */
//    self.expEarningView.frame = self.financeProductFrame.expEarningViewF;
//    self.expEarningView.colorView.backgroundColor = SLColor(60, 115, 211);
//    self.expEarningView.label.text = @"预期年化收益";
//    
//    /** multipleLabel */
//    self.multipleLabel.frame = self.financeProductFrame.multipleLabelF;
//    NSString *expectedYield = [NSString stringWithFormat:@"%@", self.financeProductFrame.financeProduct.financialProductsDetail.expectedYield];
//    self.expectedYield = expectedYield;
//    double expextedEarnRatio = [self.expectedYield doubleValue];
//    double multiple = expextedEarnRatio / 0.35;
//    self.multipleLabel.text = [NSString stringWithFormat:@"倍数:%.1f", multiple];
//}
//
//- (void)setFinanceProductFrame:(SLFinanceProductFrame *)financeProductFrame
//{
//    /** 收益对比图 */
//    self.comparisonView.frame = self.financeProductFrame.comparisonViewF;
//    
//    
//    /** 期限按钮 */
//    self.deadlineButton.frame = self.financeProductFrame.deadlineButtonF;
//    [self.deadlineButton setTitle:@"期限" forState:UIControlStateNormal];
//    
//    /** 期限数据按钮 */
//    self.deadlineDataButton.frame = self.financeProductFrame.deadlineDataButtonF;
//    self.valueDateFrom = financialProductDetain.valueDateFrom;
//    self.valueDateTo = financialProductDetain.valueDateTo;
//    long long deadline = (self.valueDateTo - self.valueDateFrom) / 1000 / 60 / 60 / 24;
//    [self.deadlineDataButton setTitle:[NSString stringWithFormat:@"%lld", deadline] forState:UIControlStateNormal];
//    
//    
//    /** 风险按钮 */
//    self.riskButton.frame = self.financeProductFrame.riskButtonF;
//    [self.riskButton setTitle:@"风险" forState:UIControlStateNormal];
//    
//    /** 风险数据按钮 */
//    self.riskDataButton.frame = self.financeProductFrame.riskDataButtonF;
//    [self.riskDataButton setTitle:financialProductDetain.extRiskLevel forState:UIControlStateNormal];
//    
//    /** 起购额按钮 */
//    self.minBuyLimitButton.frame = self.financeProductFrame.minBuyLimitButtonF;
//    [self.minBuyLimitButton setTitle:@"起购额" forState:UIControlStateNormal];
//    
//    /** 起购额数据按钮 */
//    self.minBuyLimitDataButton.frame = self.financeProductFrame.minBuyLimitDataButtonF;
//    [self.minBuyLimitDataButton setTitle:[NSString stringWithFormat:@"%ld", financialProductDetain.minAmount] forState:UIControlStateNormal];
//    
//    /** 手续费按钮 */
//    self.feeButton.frame = self.financeProductFrame.feeButtonF;
//    [self.feeButton setTitle:@"手续费" forState:UIControlStateNormal];
//    
//    /** 手续费数据按钮 */
//    self.feeDataButton.frame = self.financeProductFrame.feeDataButtonF;
//    [self.feeDataButton setTitle:[NSString stringWithFormat:@"%.2f%%", financialProductDetain.managerRite] forState:UIControlStateNormal];
//}

@end
