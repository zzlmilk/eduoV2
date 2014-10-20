//
//  SLFinanceProductController.m
//  02-pigBank
//
//  Created by 陆承东 on 14-9-18.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLFinanceProductController.h"

#import "SLAccount.h"
#import "SLAccountTool.h"
#import "SLHomeStatus.h"
#import "SLFinanceProduct.h"
#import "SLFinanceProductFrame.h"
#import "MJExtension.h"
#import "SLLabelView.h"
#import "SLFinanceComparisonViewCell.h"
#import "UIImage+S_LINE.h"
#import "SLDetailGrayLabel.h"
#import "SLDetailBlackLabel.h"

#import "SLUserOperateParameters.h"
#import "SLUserOperateTool.h"

#import "MBProgressHUD+MJ.h"

#define SLFont13 [UIFont systemFontOfSize:13]

@interface SLFinanceProductController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (nonatomic, weak) UIButton *testView;

/** scrollView */
@property (nonatomic, weak) UIScrollView *scrollView;

/** titleLabel */
@property (nonatomic, weak) UIView *headView;
/** titleLabel */
@property (nonatomic, weak) UILabel *titleLabel;
/** dateLabel */
@property (nonatomic, weak) UILabel *dateLabel;
/** leftTimeLabel */
@property (nonatomic, weak) UILabel *leftTimeLabel;

/** 图表区域整体的view */
@property (nonatomic, weak) UIView *chartView;
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

/** 基本信息区域的View */
@property (nonatomic, weak) UIView *segView;
/** basicInfoButton */
@property (nonatomic, weak) UIButton *basicInfoButton;
/** basicInfoButtonView */
@property (nonatomic, weak) UIView *basicInfoView;
/** arriveTimeLabel */
@property (nonatomic, weak) SLDetailGrayLabel *arriveTimeLabel;
/** arriveTimeInfoLabel */
@property (nonatomic, weak) SLDetailBlackLabel *arriveTimeInfoLabel;
/** assetManagerLabel */
@property (nonatomic, weak) SLDetailGrayLabel *assetManagerLabel;
/** assetManagerInfoLabel */
@property (nonatomic, weak) SLDetailBlackLabel *assetManagerInfoLabel;
/** subscriptionTimeLabel */
@property (nonatomic, weak) SLDetailGrayLabel *subscriptionTimeLabel;
/** subscriptionTimeInfoLabel */
@property (nonatomic, weak) SLDetailBlackLabel *subscriptionTimeInfoLabel;
/** earningTimeLabel */
@property (nonatomic, weak) SLDetailGrayLabel *earningTimeLabel;
/** earningTimeInfoLabel */
@property (nonatomic, weak) SLDetailBlackLabel *earningTimeInfoLabel;

/** expEarningCulButton */
@property (nonatomic, weak) UIButton *expEarningCulButton;
/** expEarningCulView */
@property (nonatomic, weak) UIView *expEarningCulView;
/** moneyAmountTextField */
@property (nonatomic, weak) UITextField *moneyAmountTextField;
/** moneyYuanLabel */
@property (nonatomic, weak) SLDetailBlackLabel *moneyYuanLabel;
/** middleLabel */
@property (nonatomic, weak) SLDetailBlackLabel *middleLabel;
/** equalLabel */
@property (nonatomic, weak) SLDetailBlackLabel *equalLabel;
/** resultLabel */
@property (nonatomic, weak) SLDetailBlackLabel *resultLabel;
/** yuanLabel */
@property (nonatomic, weak) SLDetailBlackLabel *resultYuanLabel;
/** calculateButton */
@property (nonatomic, weak) UIButton *calculateButton;
/** attentionLabel */
@property (nonatomic, weak) SLDetailBlackLabel *attentionLabel;

/** detailInfoLabel */
@property (nonatomic, weak) SLDetailGrayLabel *detailInfoLabel;
/** detailInfoLabelContent */
@property (nonatomic, weak) SLDetailBlackLabel *detailInfoContentLabel;
@property (nonatomic, weak) UIWebView *detailInfoContentWebView;

/** expectedYield 预期收益率 */
@property (nonatomic, copy) NSString *expectedYield;
/** valueDateFrom 起息日 */
@property (nonatomic, assign) long long valueDateFrom;
/** valueDateTo 到息日 */
@property (nonatomic, assign) long long valueDateTo;

@property (nonatomic, strong) NSArray *rightBarButtonItems;

@property (nonatomic, copy) NSString *priseOperateValue;
@property (nonatomic, copy) NSString *collectOperateValue;

@end

@implementation SLFinanceProductController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

#pragma mark setupSubviewsData
/**
 *  设置所有子控件的frame属性和Data
 */
- (void)setupSubviewsData
{
    SLFinancialProductsDetail *financialProductDetain = self.financeProductFrame.financeProduct.financialProductsDetail;
    
    SLLog(@"%ld", self.financeProductFrame.financeProduct.praiseCounts);
    
    CGFloat contentH = CGRectGetMaxY(self.financeProductFrame.chartViewF) + 64 + 10;
    self.scrollView.contentSize = CGSizeMake(0, contentH);
//    // 增加额外的滚动区域(在顶部增加64的区域,在底部增加44的区域)
//    self.scrollView.contentInset = UIEdgeInsetsMake(64, 0, 44, 0);
//    // 设置一开始的滚动位置(往下滚动64)
//    self.scrollView.contentOffset = CGPointMake(0, -64);
    
    
    /** titleLabel */
    self.titleLabel.frame = self.financeProductFrame.titleLabelF;
    self.titleLabel.text = self.financeProductFrame.financeProduct.title;
    
    /** dateLabel */
    self.dateLabel.frame = self.financeProductFrame.dateLabelF;
    // 转换时间
    NSDate *date = [NSDate dateWithTimeIntervalSince1970: self.financeProductFrame.financeProduct.verifyTime/1000];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy/MM/dd"];
    NSString *dateStr = [dateFormat stringFromDate: date];
    self.dateLabel.text = dateStr;
    
    /** leftTimeLabel */
    self.leftTimeLabel.frame = self.financeProductFrame.leftTimeLabelF;
    // 获取当前时间
    NSDate *now = [NSDate date];
    NSTimeInterval nowTimeInterval = [now timeIntervalSince1970];
    SLLog(@"%f", nowTimeInterval);
    long long leftTime = (long long)(self.financeProductFrame.financeProduct.financialProductsDetail.subscribeEnd / 1000 - nowTimeInterval) / 60 / 60 / 24;
    self.leftTimeLabel.text = [NSString stringWithFormat:@"剩余时间:%lld天", leftTime];
    
    /** 图表区域整体的view */
    self.chartView.frame = self.financeProductFrame.chartViewF;
    
    /** currentInterestButton */
    self.currentInterestView.frame = self.financeProductFrame.currentInterestViewF;
    self.currentInterestView.colorView.backgroundColor = SLColor(125, 36, 126);
    self.currentInterestView.label.text = @"活期银行利息";
    
    /** expEarningButton */
    self.expEarningView.frame = self.financeProductFrame.expEarningViewF;
    self.expEarningView.colorView.backgroundColor = SLColor(60, 115, 211);
    self.expEarningView.label.text = @"预期年化收益";
    
    /** multipleLabel */
    self.multipleLabel.frame = self.financeProductFrame.multipleLabelF;
    NSString *expectedYield = [NSString stringWithFormat:@"%@", self.financeProductFrame.financeProduct.financialProductsDetail.expectedYield];
    self.expectedYield = expectedYield;
    double expextedEarnRatio = [self.expectedYield doubleValue];
    double multiple = expextedEarnRatio / 0.35;
    self.multipleLabel.text = [NSString stringWithFormat:@"倍数:%.1f", multiple];
    
    
    
    /** 收益对比图 */
    self.comparisonView.frame = self.financeProductFrame.comparisonViewF;
    
    
    /** 期限按钮 */
    self.deadlineButton.frame = self.financeProductFrame.deadlineButtonF;
    [self.deadlineButton setTitle:@"期限" forState:UIControlStateNormal];
    
    /** 期限数据按钮 */
    self.deadlineDataButton.frame = self.financeProductFrame.deadlineDataButtonF;
    self.valueDateFrom = financialProductDetain.valueDateFrom;
    self.valueDateTo = financialProductDetain.valueDateTo;
    long long deadline = (self.valueDateTo - self.valueDateFrom) / 1000 / 60 / 60 / 24;
    [self.deadlineDataButton setTitle:[NSString stringWithFormat:@"%lld", deadline] forState:UIControlStateNormal];
    
    
    /** 风险按钮 */
    self.riskButton.frame = self.financeProductFrame.riskButtonF;
    [self.riskButton setTitle:@"风险" forState:UIControlStateNormal];
    
    /** 风险数据按钮 */
    self.riskDataButton.frame = self.financeProductFrame.riskDataButtonF;
    [self.riskDataButton setTitle:financialProductDetain.extRiskLevel forState:UIControlStateNormal];
    
    /** 起购额按钮 */
    self.minBuyLimitButton.frame = self.financeProductFrame.minBuyLimitButtonF;
    [self.minBuyLimitButton setTitle:@"起购额" forState:UIControlStateNormal];
    
    /** 起购额数据按钮 */
    self.minBuyLimitDataButton.frame = self.financeProductFrame.minBuyLimitDataButtonF;
    [self.minBuyLimitDataButton setTitle:[NSString stringWithFormat:@"%ld元", financialProductDetain.minAmount] forState:UIControlStateNormal];
    
    /** 手续费按钮 */
    self.feeButton.frame = self.financeProductFrame.feeButtonF;
    [self.feeButton setTitle:@"手续费" forState:UIControlStateNormal];
    
    /** 手续费数据按钮 */
    self.feeDataButton.frame = self.financeProductFrame.feeDataButtonF;
    [self.feeDataButton setTitle:[NSString stringWithFormat:@"%.2f%%", financialProductDetain.managerRite] forState:UIControlStateNormal];
    
    /** basicInfoButton */
    self.basicInfoButton.frame = self.financeProductFrame.basicInfoButtonF;
    
    /** basicInfoButtonView */
    self.basicInfoView.frame = self.financeProductFrame.basicInfoViewF;
    
    
    /** arriveTimeLabel */
    self.arriveTimeLabel.frame = self.financeProductFrame.arriveTimeLabelF;
    
    /** arriveTimeInfoLabel */
    self.arriveTimeInfoLabel.frame = self.financeProductFrame.arriveTimeInfoLabelF;
    self.arriveTimeInfoLabel.text = self.financeProductFrame.financeProduct.financialProductsDetail.extReceiptTimeType;
    
    /** assetManagerLabel */
    self.assetManagerLabel.frame = self.financeProductFrame.assetManagerLabelF;
    
    /** assetManagerInfoLabel */
    self.assetManagerInfoLabel.frame = self.financeProductFrame.assetManagerInfoLabelF;
    self.assetManagerInfoLabel.text = self.financeProductFrame.financeProduct.financialProductsDetail.assetManager;
    
    /** subscriptionTimeLabel */
    self.subscriptionTimeLabel.frame = self.financeProductFrame.subscriptionTimeLabelF;
    
    /** subscriptionTimeInfoLabel */
    self.subscriptionTimeInfoLabel.frame = self.financeProductFrame.subscriptionTimeInfoLabelF;
    // 转换时间
    NSDate *subscriptionDateStart = [NSDate dateWithTimeIntervalSince1970: self.financeProductFrame.financeProduct.financialProductsDetail.subscribeStart / 1000];
    NSString *subscribeStart = [dateFormat stringFromDate: subscriptionDateStart];
    // 转换时间
    NSDate *subscriptionDateEnd = [NSDate dateWithTimeIntervalSince1970: self.financeProductFrame.financeProduct.financialProductsDetail.subscribeEnd / 1000];
    NSString *subscribeEnd = [dateFormat stringFromDate: subscriptionDateEnd];
    NSString *subscriptionTime = [NSString stringWithFormat:@"%@ 至 %@", subscribeStart, subscribeEnd];
    self.subscriptionTimeInfoLabel.text = subscriptionTime;
    
    /** earningTimeLabel */
    self.earningTimeLabel.frame = self.financeProductFrame.earningTimeLabelF;
    
    /** earningTimeInfoLabel */
    self.earningTimeInfoLabel.frame = self.financeProductFrame.earningTimeInfoLabelF;
    // 转换时间
    NSDate *earnDateStart = [NSDate dateWithTimeIntervalSince1970: self.financeProductFrame.financeProduct.financialProductsDetail.valueDateFrom / 1000];
    NSString *earnStart = [dateFormat stringFromDate: earnDateStart];
    // 转换时间
    NSDate *earnDateEnd = [NSDate dateWithTimeIntervalSince1970: self.financeProductFrame.financeProduct.financialProductsDetail.valueDateTo / 1000];
    NSString *earnEnd = [dateFormat stringFromDate: earnDateEnd];
    NSString *earningTime = [NSString stringWithFormat:@"%@ 至 %@", earnStart, earnEnd];
    self.earningTimeInfoLabel.text = earningTime;
    
    /** expEarningCulButton */
    self.expEarningCulButton.frame = self.financeProductFrame.expEarningCulButtonF;
    
    /** expEarningCulView */
    self.expEarningCulView.frame = self.financeProductFrame.expEarningCulViewF;
    
    /** moneyAmountTextField */
    self.moneyAmountTextField.placeholder = @"理财金额";
    self.moneyAmountTextField.textAlignment = NSTextAlignmentRight;
    self.moneyAmountTextField.contentMode = UIViewContentModeCenter;
    self.moneyAmountTextField.frame = self.financeProductFrame.moneyAmountTextFieldF;
    
    /** moneyYuanLabel */
    self.moneyYuanLabel.frame = self.financeProductFrame.moneyYuanLabelF;
    self.moneyYuanLabel.text = @"元";
    
    /** middleLabel */
    self.middleLabel.frame = self.financeProductFrame.middleLabelF;
    long long days = (self.financeProductFrame.financeProduct.financialProductsDetail.valueDateTo - self.financeProductFrame.financeProduct.financialProductsDetail.valueDateFrom) / 1000 / 60 / 60 / 24;
    self.middleLabel.text = [NSString stringWithFormat:@"%lld天", days];
    
    /** equalLabel */
    self.equalLabel.frame = self.financeProductFrame.equalLabelF;
    self.equalLabel.text = @"=";
    
    /** resultLabel */
    self.resultLabel.frame = self.financeProductFrame.resultLabelF;

    
    /** resultYuanLabel */
    self.resultYuanLabel.frame = self.financeProductFrame.resultYuanLabelF;
    self.resultYuanLabel.text = @"元";
    
    /** calculateButton */
    self.calculateButton.frame = self.financeProductFrame.calculateButtonF;
    [self.calculateButton setTitle:@"计算收益" forState:UIControlStateNormal];
    [self.calculateButton setBackgroundColor:SLColor(213, 43, 41)];
    [self.calculateButton addTarget:self action:@selector(calculateButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    /** attentionLabel */
    self.attentionLabel.frame = self.financeProductFrame.attentionLabelF;
    self.attentionLabel.text = @"注:此预期非实际收益,未到期提前取现会有损失";
    
    /** detailInfoLabel */
    self.detailInfoLabel.frame = self.financeProductFrame.detailInfoLabelF;
    
    /** detailInfoContentLabel */
    self.detailInfoContentLabel.frame = self.financeProductFrame.detailInfoContentLabelF;
//    NSString *str = [NSString]
    self.detailInfoContentLabel.text = self.financeProductFrame.financeProduct.content;
}

/**
 *  点击开始计算按钮
 */
- (void)calculateButtonClick:(UIButton *)calculateButton
{
    double expextedEarnRatio = [self.expectedYield doubleValue];
    
    long long days = (self.valueDateTo - self.valueDateFrom) / 1000 / 60 / 60 / 24;
    
    double result = expextedEarnRatio * [self.moneyAmountTextField.text longLongValue] * days / 365 / 100;
    
    self.resultLabel.text = [NSString stringWithFormat:@"%.2f", result];
}


#pragma mark --- tableview的代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 创建cell
    SLFinanceComparisonViewCell *cell = [SLFinanceComparisonViewCell cellWithTableView:tableView];
    
    // 传递数据
    double expectedYield = [self.expectedYield doubleValue];
    double incomeBase = expectedYield / 3;
    cell.incomeRatio = incomeBase * (4 - indexPath.row);
    
    return cell;
}

#pragma mark addAllSubviews
/**
 *  添加所有子控件
 */
- (void)addAllSubviews
{
    /** scrollView */
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.delegate = self;
    scrollView.frame = [UIScreen mainScreen].bounds;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    /** titleLabel */
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = SLFinanceProductTitleFont;
    titleLabel.numberOfLines = 0;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.scrollView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    /** dateLabel */
    UILabel *dateLabel = [[UILabel alloc] init];
    dateLabel.textAlignment = NSTextAlignmentLeft;
    dateLabel.font = SLFont11;
    [self.scrollView addSubview:dateLabel];
    self.dateLabel = dateLabel;
    
    /** leftTimeLabel */
    UILabel *leftTimeLabel = [[UILabel alloc] init];
    leftTimeLabel.textAlignment = NSTextAlignmentRight;
    leftTimeLabel.font = SLFont11;
    [self.scrollView addSubview:leftTimeLabel];
    self.leftTimeLabel = leftTimeLabel;
    
    
    /** 图表区域整体的view */
    UIView *chartView = [[UIView alloc] init];
    [self.scrollView addSubview:chartView];
    self.chartView = chartView;
    
    /** currentInterestView */
    SLLabelView *currentInterestView = [[SLLabelView alloc] init];
//    currentInterestView.colorView.backgroundColor = SLColor(125, 36, 126);
//    currentInterestView.label.text = @"活期银行利息";
    currentInterestView.label.font = SLFinanceProductContentFont;
    [self.chartView addSubview:currentInterestView];
    self.currentInterestView = currentInterestView ;
    
    /** expEarningView */
    SLLabelView *expEarningView = [[SLLabelView alloc] init];
    expEarningView.label.font = SLFinanceProductContentFont;
    [self.chartView addSubview:expEarningView];
    self.expEarningView = expEarningView;
    
    /** multipleLabel */
    UILabel *multipleLabel = [[UILabel alloc] init];
    multipleLabel.font = SLFinanceProductContentFont;
    [self.chartView addSubview:multipleLabel];
    self.multipleLabel = multipleLabel;
    
    
    /** 收益对比图 */
    UITableView *comparisonView = [[UITableView alloc] init];
    comparisonView.backgroundColor = [UIColor redColor];
    comparisonView.separatorStyle = UITableViewCellSeparatorStyleNone;
    comparisonView.delegate = self;
    comparisonView.dataSource = self;
    comparisonView.rowHeight = 26;
    comparisonView.userInteractionEnabled = NO;
    [self.chartView addSubview:comparisonView];
    self.comparisonView = comparisonView;
    
    /** 期限按钮 */
    UIButton *deadlineButton = [[UIButton alloc] init];
    [self.chartView addSubview:deadlineButton];
    [deadlineButton setBackgroundImage:[UIImage imageNamed:@"zuoLan"] forState:UIControlStateNormal];
    deadlineButton.titleLabel.font = SLFinanceProductContentFont;
    self.deadlineButton = deadlineButton;
    
    /** 期限数据按钮 */
    UIButton *deadlineDataButton = [[UIButton alloc] init];
    [deadlineDataButton setBackgroundImage:[UIImage imageNamed:@"youLan"] forState:UIControlStateNormal];
    deadlineDataButton.titleLabel.font = SLFinanceProductContentFont;
    [self.chartView addSubview:deadlineDataButton];
    self.deadlineDataButton = deadlineDataButton;
    
    /** 风险按钮 */
    UIButton *riskButton = [[UIButton alloc] init];
    [riskButton setBackgroundImage:[UIImage imageNamed:@"zuo"] forState:UIControlStateNormal];
    riskButton.titleLabel.font = SLFinanceProductContentFont;
    [self.chartView addSubview:riskButton];
    self.riskButton = riskButton;
    
    /** 风险数据按钮 */
    UIButton *riskDataButton = [[UIButton alloc] init];
    [riskDataButton setBackgroundImage:[UIImage imageNamed:@"you"] forState:UIControlStateNormal];
    riskDataButton.titleLabel.font = SLFinanceProductContentFont;
    [self.chartView addSubview:riskDataButton];
    self.riskDataButton = riskDataButton;
    
    /** 起购额按钮 */
    UIButton *minBuyLimitButton = [[UIButton alloc] init];
    [minBuyLimitButton setBackgroundImage:[UIImage imageNamed:@"zuoLan"] forState:UIControlStateNormal];
    minBuyLimitButton.titleLabel.font = SLFinanceProductContentFont;
    [self.chartView addSubview:minBuyLimitButton];
    self.minBuyLimitButton = minBuyLimitButton;
    
    /** 起购额数据按钮 */
    UIButton *minBuyLimitDataButton = [[UIButton alloc] init];
    [minBuyLimitDataButton setBackgroundImage:[UIImage imageNamed:@"youLan"] forState:UIControlStateNormal];
    minBuyLimitDataButton.titleLabel.font = SLFinanceProductContentFont;
    [self.chartView addSubview:minBuyLimitDataButton];
    self.minBuyLimitDataButton = minBuyLimitDataButton;
    
    /** 手续费按钮 */
    UIButton *feeButton = [[UIButton alloc] init];
    [feeButton setBackgroundImage:[UIImage imageNamed:@"zuo"] forState:UIControlStateNormal];
    feeButton.titleLabel.font = SLFinanceProductContentFont;
    [self.chartView addSubview:feeButton];
    self.feeButton = feeButton;
    
    /** 手续费数据按钮 */
    UIButton *feeDataButton = [[UIButton alloc] init];
    [feeDataButton setBackgroundImage:[UIImage imageNamed:@"you"] forState:UIControlStateNormal];
    feeDataButton.titleLabel.font = SLFinanceProductContentFont;
    [self.chartView addSubview:feeDataButton];
    self.feeDataButton = feeDataButton;
    
    /** basicInfoButton */
    UIButton *basicInfoButton = [[UIButton alloc] init];
    [basicInfoButton setTitle:@"基本信息" forState:UIControlStateNormal];
    [basicInfoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [basicInfoButton setBackgroundImage:[UIImage resizableImageWithImageName:@"zuoKuang"] forState:UIControlStateNormal];
    [basicInfoButton setBackgroundImage:[UIImage resizableImageWithImageName:@"zuoKuangJiaoHu"] forState:UIControlStateSelected];
    [basicInfoButton addTarget:self action:@selector(basicInfoButtonClick:) forControlEvents:UIControlEventTouchDown];
    [self.chartView addSubview:basicInfoButton];
    self.basicInfoButton = basicInfoButton;
    
    
    /** basicInfoButtonView */
    UIView *basicInfoView = [[UIView alloc] init];

        /** arriveTimeInfoLabel */
        SLDetailGrayLabel *arriveTimeLabel = [[SLDetailGrayLabel alloc] init];
        arriveTimeLabel.text = @"到账时间:";
        [basicInfoView addSubview:arriveTimeLabel];
        self.arriveTimeLabel = arriveTimeLabel;
        
        /** arriveTimeInfoLabel */
        SLDetailBlackLabel *arriveTimeInfoLabel = [[SLDetailBlackLabel alloc] init];
        [basicInfoView addSubview:arriveTimeInfoLabel];
        self.arriveTimeInfoLabel = arriveTimeInfoLabel;
        
        /** assetManagerLabel */
        SLDetailGrayLabel *assetManagerLabel = [[SLDetailGrayLabel alloc] init];
        assetManagerLabel.text = @"资产管理人:";
        [basicInfoView addSubview:assetManagerLabel];
        self.assetManagerLabel = assetManagerLabel;
        
        /** assetManagerInfoLabel */
        SLDetailBlackLabel *assetManagerInfoLabel = [[SLDetailBlackLabel alloc] init];
        [basicInfoView addSubview:assetManagerInfoLabel];
        self.assetManagerInfoLabel = assetManagerInfoLabel;
        
        /** subscriptionTimeLabel */
        SLDetailGrayLabel *subscriptionTimeLabel = [[SLDetailGrayLabel alloc] init];
        subscriptionTimeLabel.text = @"认购时间:";
        [basicInfoView addSubview:subscriptionTimeLabel];
        self.subscriptionTimeLabel = subscriptionTimeLabel;
        
        /** subscriptionTimeInfoLabel */
        SLDetailBlackLabel *subscriptionTimeInfoLabel = [[SLDetailBlackLabel alloc] init];
        [basicInfoView addSubview:subscriptionTimeInfoLabel];
        self.subscriptionTimeInfoLabel = subscriptionTimeInfoLabel;
        
        /** arriveTimeInfoLabel */
        SLDetailGrayLabel *earningTimeLabel = [[SLDetailGrayLabel alloc] init];
        earningTimeLabel.text = @"收益时间:";
        [basicInfoView addSubview:earningTimeLabel];
        self.earningTimeLabel = earningTimeLabel;
        
        /** earningTimeInfoLabel */
        SLDetailBlackLabel *earningTimeInfoLabel = [[SLDetailBlackLabel alloc] init];
        [basicInfoView addSubview:earningTimeInfoLabel];
        self.earningTimeInfoLabel = earningTimeInfoLabel;
    
    [self.chartView addSubview:basicInfoView];
    self.basicInfoView = basicInfoView;
    
    /** expEarningCulButton */
    UIButton *expEarningCulButton = [[UIButton alloc] init];
    [expEarningCulButton setTitle:@"预期收益计算" forState:UIControlStateNormal];
    [expEarningCulButton setBackgroundImage:[UIImage resizableImageWithImageName:@"youKuang"] forState:UIControlStateNormal];
    [expEarningCulButton setBackgroundImage:[UIImage resizableImageWithImageName:@"youKuangJiaoHu"] forState:UIControlStateSelected];
    [expEarningCulButton addTarget:self action:@selector(expEarningCulButtonClick:) forControlEvents:UIControlEventTouchDown];
    [self.chartView addSubview:expEarningCulButton];
    self.expEarningCulButton = expEarningCulButton;
    
    /** basicInfoButtonView */
    UIView *expEarningCulView = [[UIView alloc] init];
    
        /** moneyAmountTextField */
        UITextField *moneyAmountTextField = [[UITextField alloc] init];
        moneyAmountTextField.font = SLFont13;
        moneyAmountTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        moneyAmountTextField.delegate = self;
        [expEarningCulView addSubview:moneyAmountTextField];
        self.moneyAmountTextField = moneyAmountTextField;
        
        /** resultLabel */
        SLDetailBlackLabel *resultLabel = [[SLDetailBlackLabel alloc] init];
    resultLabel.textAlignment = NSTextAlignmentRight;
        [expEarningCulView addSubview:resultLabel];
        self.resultLabel = resultLabel;
    
        /** moneyYuanLabel */
        SLDetailBlackLabel *moneyYuanLabel = [[SLDetailBlackLabel alloc] init];
        [expEarningCulView addSubview:moneyYuanLabel];
        self.moneyYuanLabel = moneyYuanLabel;
    
        /** middleLabel */
        SLDetailBlackLabel *middleLabel = [[SLDetailBlackLabel alloc] init];
        [expEarningCulView addSubview:middleLabel];
        self.middleLabel = middleLabel;
    
        /** equalLabel */
        SLDetailBlackLabel *equalLabel = [[SLDetailBlackLabel alloc] init];
        [expEarningCulView addSubview:equalLabel];
        self.equalLabel = equalLabel;
        
        /** yuanLabel */
        SLDetailBlackLabel *resultYuanLabel = [[SLDetailBlackLabel alloc] init];
        [expEarningCulView addSubview:resultYuanLabel];
        self.resultYuanLabel = resultYuanLabel;
        
        /** calculateButton */
        UIButton *calculateButton = [[UIButton alloc] init];
        [expEarningCulView addSubview:calculateButton];
        self.calculateButton = calculateButton;
        
        /** attentionLabel */
        SLDetailBlackLabel *attentionLabel = [[SLDetailBlackLabel alloc] init];
    attentionLabel.textAlignment = NSTextAlignmentCenter;
        [expEarningCulView addSubview:attentionLabel];
        self.attentionLabel = attentionLabel;
    
    [self.chartView addSubview:expEarningCulView];
    self.expEarningCulView = expEarningCulView;
    
    /** detailInfoLabel */
    SLDetailGrayLabel *detailInfoLabel = [[SLDetailGrayLabel alloc] init];
    detailInfoLabel.text = @"详细信息:";
    [self.chartView addSubview:detailInfoLabel];
    self.detailInfoLabel = detailInfoLabel;
    
    /** detailInfoLabelContent */
    SLDetailBlackLabel *detailInfoContentLabel = [[SLDetailBlackLabel alloc] init];
    detailInfoContentLabel.numberOfLines = 0;
    [self.chartView addSubview:detailInfoContentLabel];
    self.detailInfoContentLabel = detailInfoContentLabel;
    
    UIWebView *detailInfoContentWebView = [[UIWebView alloc] init];
    [detailInfoContentWebView stringByEvaluatingJavaScriptFromString:self.financeProductFrame.financeProduct.content];
    [self.chartView addSubview:detailInfoContentWebView];
    self.detailInfoContentWebView = detailInfoContentWebView;
}

/**
 *  预期收益计算按钮点击事件
 */
- (void)expEarningCulButtonClick:(UIButton *)expEarningCulButton
{
    self.basicInfoButton.selected = NO;
    self.basicInfoView.hidden = YES;
    [self.basicInfoButton setTitleColor:SLColor(126, 33, 128) forState:UIControlStateNormal];
    self.expEarningCulButton.selected = YES;
    self.expEarningCulView.hidden = NO;
    [self.expEarningCulButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
}
/**
 *  基本信息按钮点击事件
 */
- (void)basicInfoButtonClick:(UIButton *)basicInfoButton
{
    self.expEarningCulButton.selected = NO;
    self.expEarningCulView.hidden = YES;
    [self.expEarningCulButton setTitleColor:SLColor(126, 33, 128) forState:UIControlStateNormal];
    self.basicInfoButton.selected = YES;
    self.basicInfoView.hidden = NO;
    [self.basicInfoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.window.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 添加所有的子控件
    [self addAllSubviews];
    
    [self setupSubviewsData];
    
    [self basicInfoButtonClick:self.basicInfoButton];
    
    // 监听键盘的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

/**
 *  设置导航栏
 */
- (void)setupNavBar
{
    UINavigationBar *navBar = self.navigationController.navigationBar;
    // 设置背景
    [navBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    
//    NSMutableDictionary *attri = [NSMutableDictionary dictionary];
//    attri[UITextAttributeTextColor] = [UIColor whiteColor];
//    [navBar setTitleTextAttributes:attri];
    
#warning ----- 可以封装
    // 设置右上角的barButton
    UIButton *zanButton = [[UIButton alloc] init];
    zanButton.bounds = CGRectMake(0, 0, 40, 42);
    [zanButton setImage:[UIImage imageNamed:@"zan"] forState:UIControlStateNormal];
    [zanButton setImage:[UIImage imageNamed:@"zanPress@2x"] forState:UIControlStateSelected];
    [zanButton setTitle:[NSString stringWithFormat:@"%ld", self.financeProductFrame.financeProduct.praiseCounts] forState:UIControlStateNormal];
    [zanButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    zanButton.titleLabel.font = SLFont14;
    zanButton.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [zanButton addTarget:self action:@selector(zanButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    int praiseFlag = self.financeProductFrame.financeProduct.materialUser.praiseFlag;
    if (praiseFlag == 1) {
        zanButton.selected = YES;
    } else {
        zanButton.selected = NO;
    }
    UIBarButtonItem *zanItem = [[UIBarButtonItem alloc] initWithCustomView:zanButton];
    
    UIButton *shoucangButton = [[UIButton alloc] init];
    shoucangButton.bounds = CGRectMake(0, 0, 40, 42);
    [shoucangButton setImage:[UIImage imageNamed:@"shouCang"] forState:UIControlStateNormal];
    [shoucangButton setImage:[UIImage imageNamed:@"shouCangJiaoHu"] forState:UIControlStateSelected];
    [shoucangButton setTitle:[NSString stringWithFormat:@"%ld", self.financeProductFrame.financeProduct.collectCounts] forState:UIControlStateNormal];
    [shoucangButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    shoucangButton.titleLabel.font = SLFont14;
    shoucangButton.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [shoucangButton addTarget:self action:@selector(shoucangButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    int collectFlag = self.financeProductFrame.financeProduct.materialUser.collectFlag;
    if (collectFlag == 1) {
        shoucangButton.selected = YES;
    } else {
        shoucangButton.selected = NO;
    }
    UIBarButtonItem *shoucangItem = [[UIBarButtonItem alloc] initWithCustomView:shoucangButton];
//    UIBarButtonItem *callItem = [UIBarButtonItem itemWithImage:@"dianHua" highlightImage:@"dianHua" target:self action:@selector(call)];
    self.rightBarButtonItems = @[shoucangItem, zanItem];
    self.navigationItem.rightBarButtonItems = self.rightBarButtonItems;
}


- (void)shoucangButtonClick:(UIButton *)shoucangButton
{
    // 创建网络参数
    SLUserOperateParameters *parameters = [SLUserOperateParameters parameters];
    parameters.operateType = @"collect";
    parameters.materialId = self.financeProductFrame.financeProduct.financialProductsDetail.materialId;

    if (shoucangButton.selected == YES) {
        shoucangButton.selected = NO;
        [shoucangButton setTitle:[NSString stringWithFormat:@"%ld", self.financeProductFrame.financeProduct.collectCounts] forState:UIControlStateNormal];
        
        parameters.operateValue = @"0";
        [SLUserOperateTool userOperateWithParameters:parameters success:^(NSArray *vipStatusFrameArray) {
            [MBProgressHUD showSuccess:@"取消收藏成功"];
        } failure:^(NSError *error) {
            [MBProgressHUD showError:@"取消收藏失败"];
        }];
        
    } else {
        shoucangButton.selected = YES;
        [shoucangButton setTitle:[NSString stringWithFormat:@"%ld", self.financeProductFrame.financeProduct.collectCounts + 1] forState:UIControlStateSelected];
        
        parameters.operateValue = @"1";
        [SLUserOperateTool userOperateWithParameters:parameters success:^(NSArray *vipStatusFrameArray) {
            [MBProgressHUD showSuccess:@"收藏成功"];
        } failure:^(NSError *error) {
            [MBProgressHUD showError:@"收藏失败"];
        }];
    }
}
- (void)zanButtonClick:(UIButton *)zanButton
{
    // 创建网络参数
    SLUserOperateParameters *parameters = [SLUserOperateParameters parameters];
    parameters.operateType = @"praise";

    if (zanButton.selected == YES) {
        zanButton.selected = NO;
        [zanButton setTitle:[NSString stringWithFormat:@"%ld", self.financeProductFrame.financeProduct.praiseCounts] forState:UIControlStateNormal];
        
        parameters.operateValue = @"0";
        [SLUserOperateTool userOperateWithParameters:parameters success:^(NSArray *vipStatusFrameArray) {
            [MBProgressHUD showSuccess:@"取消赞成功"];
        } failure:^(NSError *error) {
            [MBProgressHUD showError:@"取消赞失败"];
        }];
    } else {
        zanButton.selected = YES;
        [zanButton setTitle:[NSString stringWithFormat:@"%ld", self.financeProductFrame.financeProduct.praiseCounts + 1] forState:UIControlStateSelected];
        
        parameters.operateValue = @"1";
        [SLUserOperateTool userOperateWithParameters:parameters success:^(NSArray *vipStatusFrameArray) {
            [MBProgressHUD showSuccess:@"赞成功"];
        } failure:^(NSError *error) {
            [MBProgressHUD showError:@"赞失败"];
        }];
    }
}


/**
 *  调出键盘时的处理事件
 */
- (void)keyboardWillChangeFrame:(NSNotification *)note
{
    // 0.取出键盘动画的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 1.取得键盘最后的frame
    CGRect keyboardFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect keyboardFrame1 = [note.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    
    // 3.执行动画
    [UIView animateWithDuration:duration animations:^{
        
        CGPoint center = self.scrollView.center;
        center.y = center.y - (keyboardFrame1.origin.y - keyboardFrame.origin.y) * 0.55;
        self.scrollView.center = center;
        
//        self.scrollView.transform = CGAffineTransformMakeTranslation(0, transformY);
    }];
}

#pragma mark ----- 数据传输在viewDidLoad之后进行
- (void)setFinanceProductFrame:(SLFinanceProductFrame *)financeProductFrame
{
    _financeProductFrame = financeProductFrame;
    
    [self setupSubviewsData];
    
    [self setupNavBar];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ---- textField代理方法
/**
 *  点击了return按钮(键盘最右下角的按钮)就会调用
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

@end
