//
//  SLFinanceProductController.m
//  02-pigBank
//
//  Created by 陆承东 on 14-9-18.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLFinanceProductController.h"

#import "SLHomeStatus.h"
#import "SLFinanceProduct.h"
#import "SLFinanceProductFrame.h"

#import "SLLabelView.h"
#import "SLFinanceComparisonViewCell.h"
#import "SLDetailGrayLabel.h"
#import "SLDetailBlackLabel.h"
#import "SLPraiseButton.h"
#import "SLCollectButton.h"
#import "SLBackButton.h"
#import "SLClientToolBar.h"

#import "SLMessageListController.h"
#import "SLMessageViewController.h"
#import "SLClientListTableViewController.h"
#import "SLManageViewController.h"

#import "SLUserOperateParameters.h"
#import "SLUserOperateTool.h"
#import "SLMeterialDetialTool.h"
#import "SLAccountTool.h"
#import "SLConsultantTool.h"

#import "UIImage+S_LINE.h"

#import "MJExtension.h"

@interface SLFinanceProductController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UIWebViewDelegate, UIAlertViewDelegate, UIActionSheetDelegate, SLClientToolBarDelegate>

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

@property (nonatomic, weak) UIView *currentInterestBarView;
@property (nonatomic, weak) UILabel *currentInterestLabel;
@property (nonatomic, weak) UIView *expEarningBarView;
@property (nonatomic, weak) UILabel *expEarningLabel;
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

@property (nonatomic, weak) UIView *hintView;

/** expectedYield 预期收益率 */
@property (nonatomic, copy) NSString *expectedYield;
/** valueDateFrom 起息日 */
@property (nonatomic, assign) long long valueDateFrom;
/** valueDateTo 到息日 */
@property (nonatomic, assign) long long valueDateTo;

@property (nonatomic, copy) NSString *priseOperateValue;
@property (nonatomic, copy) NSString *collectOperateValue;

@property (nonatomic, strong) SLFinanceProductFrame *financeProductFrame;

@property (nonatomic, copy) NSString *userType;
@property (nonatomic, strong) SLConsultant *consultant;

@end

@implementation SLFinanceProductController

- (NSString *)userType
{
    if (_userType == nil) {
        _userType = [SLAccountTool getAccount].accountInfo.userType;
    }
    return _userType;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setNavBar];
}

#pragma mark ----- 设置导航栏样式
- (void)setNavBar
{
    UINavigationBar *navBar = self.navigationController.navigationBar;
    // 设置背景
    [navBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [navBar setBarTintColor:SLColor(246, 246, 246)];
    
    SLBackButton *backButton = [SLBackButton button];
    [backButton addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backItem;
    
    NSMutableDictionary *attri = [NSMutableDictionary dictionary];
    attri[UITextAttributeTextColor] = [UIColor blackColor];
    [navBar setTitleTextAttributes:attri];
}

#pragma mark ----- backButtonClicked返回按钮点击事件
- (void)backButtonClicked:(SLBackButton *)backButton
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark ----- setupSubviewsData设置所有子控件的frame属性和Data
- (void)setupSubviewsData
{
    SLFinancialProductsDetail *financialProductDetain = self.financeProductFrame.financeProduct.financialProductsDetail;
    
    CGFloat contentH = CGRectGetMaxY(self.financeProductFrame.chartViewF) + 20;
    self.scrollView.contentSize = CGSizeMake(0, contentH);
    
    
    /** titleLabel */
    self.titleLabel.frame = self.financeProductFrame.titleLabelF;
    self.titleLabel.text = self.financeProductFrame.financeProduct.title;
    
    /** dateLabel */
    self.dateLabel.frame = self.financeProductFrame.dateLabelF;
    // 转换时间
    NSDate *date = [NSDate dateWithTimeIntervalSince1970: [self.financeProductFrame.financeProduct.verifyTime longLongValue]/1000];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy/MM/dd"];
    NSString *dateStr = [dateFormat stringFromDate: date];
    self.dateLabel.text = dateStr;
    
    /** leftTimeLabel */
    self.leftTimeLabel.frame = self.financeProductFrame.leftTimeLabelF;
    // 获取当前时间
    NSDate *now = [NSDate date];
    NSTimeInterval nowTimeInterval = [now timeIntervalSince1970];
    long long leftTime = ([self.financeProductFrame.financeProduct.financialProductsDetail.subscribeEnd longLongValue] / 1000 - nowTimeInterval) / 60 / 60 / 24;
    if (leftTime <= 0) {
        self.leftTimeLabel.text = [NSString stringWithFormat:@"剩余时间:已结束"];
    } else {
        self.leftTimeLabel.text = [NSString stringWithFormat:@"剩余时间:%lld天", leftTime];
    }
    
    /** 图表区域整体的view */
    self.chartView.frame = self.financeProductFrame.chartViewF;
    
    /** currentInterestButton */
    self.currentInterestView.frame = self.financeProductFrame.currentInterestViewF;
    self.currentInterestView.colorView.backgroundColor = SLRed;
    self.currentInterestView.label.text = @"活期银行利息";
    
    /** expEarningButton */
    self.expEarningView.frame = self.financeProductFrame.expEarningViewF;
    self.expEarningView.colorView.backgroundColor = SLBlue;
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
    
    self.currentInterestBarView.frame = self.financeProductFrame.currentInterestBarViewF;
    self.currentInterestBarView.backgroundColor = SLRed;
    
    self.currentInterestLabel.frame = self.financeProductFrame.currentInterestLabelF;
    self.currentInterestLabel.font = SLFont12;
    self.currentInterestLabel.textColor = SLRed;
    self.currentInterestLabel.textAlignment = NSTextAlignmentCenter;
    self.currentInterestLabel.text = [NSString stringWithFormat:@"%@%%", self.financeProductFrame.financeProduct.financialProductsDetail.compareValue];
    
    self.expEarningBarView.frame = self.financeProductFrame.expEarningBarViewF;
    self.expEarningBarView.backgroundColor = SLBlue;
    
    self.expEarningLabel.frame = self.financeProductFrame.expEarningLabelF;
    self.expEarningLabel.font = SLFont12;
    self.expEarningLabel.textColor = SLBlue;
    self.expEarningLabel.textAlignment = NSTextAlignmentCenter;
    self.expEarningLabel.text = [NSString stringWithFormat:@"%@%%", self.financeProductFrame.financeProduct.financialProductsDetail.expectedYield];
    
    /** 期限按钮 */
    self.deadlineButton.userInteractionEnabled = NO;
    self.deadlineButton.frame = self.financeProductFrame.deadlineButtonF;
    [self.deadlineButton setTitle:@"期限" forState:UIControlStateNormal];
    
    /** 期限数据按钮 */
    self.deadlineDataButton.userInteractionEnabled = NO;
    self.deadlineDataButton.frame = self.financeProductFrame.deadlineDataButtonF;
    self.valueDateFrom = [financialProductDetain.valueDateFrom longLongValue];
    self.valueDateTo = [financialProductDetain.valueDateTo longLongValue];
    long long deadline = (self.valueDateTo - self.valueDateFrom) / 1000 / 60 / 60 / 24;
    [self.deadlineDataButton setTitle:[NSString stringWithFormat:@"%lld", deadline] forState:UIControlStateNormal];
    
    /** 风险按钮 */
    self.riskButton.userInteractionEnabled = NO;
    self.riskButton.frame = self.financeProductFrame.riskButtonF;
    [self.riskButton setTitle:@"风险" forState:UIControlStateNormal];
    
    /** 风险数据按钮 */
    self.riskDataButton.userInteractionEnabled = NO;
    self.riskDataButton.frame = self.financeProductFrame.riskDataButtonF;
    [self.riskDataButton setTitle:financialProductDetain.extRiskLevel forState:UIControlStateNormal];
    
    /** 起购额按钮 */
    self.minBuyLimitButton.userInteractionEnabled = NO;
    self.minBuyLimitButton.frame = self.financeProductFrame.minBuyLimitButtonF;
    [self.minBuyLimitButton setTitle:@"起购额" forState:UIControlStateNormal];
    
    /** 起购额数据按钮 */
    self.minBuyLimitDataButton.userInteractionEnabled = NO;
    self.minBuyLimitDataButton.frame = self.financeProductFrame.minBuyLimitDataButtonF;
    [self.minBuyLimitDataButton setTitle:[NSString stringWithFormat:@"%@元", financialProductDetain.minAmount] forState:UIControlStateNormal];
    
    /** 手续费按钮 */
    self.feeButton.userInteractionEnabled = NO;
    self.feeButton.frame = self.financeProductFrame.feeButtonF;
    [self.feeButton setTitle:@"手续费" forState:UIControlStateNormal];
    
    /** 手续费数据按钮 */
    self.feeDataButton.userInteractionEnabled = NO;
    self.feeDataButton.frame = self.financeProductFrame.feeDataButtonF;
    [self.feeDataButton setTitle:[NSString stringWithFormat:@"%.2f%%", [financialProductDetain.managerRite doubleValue]] forState:UIControlStateNormal];
    
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
    NSDate *subscriptionDateStart = [NSDate dateWithTimeIntervalSince1970: [self.financeProductFrame.financeProduct.financialProductsDetail.subscribeStart longLongValue] / 1000];
    NSString *subscribeStart = [dateFormat stringFromDate: subscriptionDateStart];
    // 转换时间
    NSDate *subscriptionDateEnd = [NSDate dateWithTimeIntervalSince1970: [self.financeProductFrame.financeProduct.financialProductsDetail.subscribeEnd longLongValue] / 1000];
    NSString *subscribeEnd = [dateFormat stringFromDate: subscriptionDateEnd];
    NSString *subscriptionTime = [NSString stringWithFormat:@"%@ 至 %@", subscribeStart, subscribeEnd];
    self.subscriptionTimeInfoLabel.text = subscriptionTime;
    
    /** earningTimeLabel */
    self.earningTimeLabel.frame = self.financeProductFrame.earningTimeLabelF;
    
    /** earningTimeInfoLabel */
    self.earningTimeInfoLabel.frame = self.financeProductFrame.earningTimeInfoLabelF;
    // 转换时间
    NSDate *earnDateStart = [NSDate dateWithTimeIntervalSince1970: [self.financeProductFrame.financeProduct.financialProductsDetail.valueDateFrom longLongValue] / 1000];
    NSString *earnStart = [dateFormat stringFromDate: earnDateStart];
    // 转换时间
    NSDate *earnDateEnd = [NSDate dateWithTimeIntervalSince1970: [self.financeProductFrame.financeProduct.financialProductsDetail.valueDateTo longLongValue] / 1000];
    NSString *earnEnd = [dateFormat stringFromDate: earnDateEnd];
    NSString *earningTime = [NSString stringWithFormat:@"%@ 至 %@", earnStart, earnEnd];
    self.earningTimeInfoLabel.text = earningTime;
    
    /** expEarningCulButton */
    self.expEarningCulButton.frame = self.financeProductFrame.expEarningCulButtonF;
    
    /** expEarningCulView */
    self.expEarningCulView.frame = self.financeProductFrame.expEarningCulViewF;
    
    /** moneyAmountTextField */
    self.moneyAmountTextField.placeholder = @"理财金额";
    self.moneyAmountTextField.backgroundColor = SLLightGray;
    self.moneyAmountTextField.layer.cornerRadius = 5;
    self.moneyAmountTextField.clipsToBounds = YES;
    self.moneyAmountTextField.textAlignment = NSTextAlignmentCenter;
    self.moneyAmountTextField.contentMode = UIViewContentModeCenter;
    self.moneyAmountTextField.frame = self.financeProductFrame.moneyAmountTextFieldF;
    
    /** moneyYuanLabel */
    self.moneyYuanLabel.frame = self.financeProductFrame.moneyYuanLabelF;
    self.moneyYuanLabel.text = @"元";
    
    /** middleLabel */
    self.middleLabel.frame = self.financeProductFrame.middleLabelF;
    long long days = ([self.financeProductFrame.financeProduct.financialProductsDetail.valueDateTo longLongValue] - [self.financeProductFrame.financeProduct.financialProductsDetail.valueDateFrom longLongValue]) / 1000 / 60 / 60 / 24;
    self.middleLabel.text = [NSString stringWithFormat:@"%lld天", days];
    
    /** equalLabel */
    self.equalLabel.frame = self.financeProductFrame.equalLabelF;
    self.equalLabel.text = @"=";
    
    /** resultLabel */
    self.resultLabel.frame = self.financeProductFrame.resultLabelF;
#pragma mark ----- 添加下划线
    CGRect underlineF = self.resultLabel.bounds;
    underlineF.origin.y = underlineF.size.height - 0.5;
    underlineF.size.height = 0.5;
    UIView *underline = [[UIView alloc] initWithFrame:underlineF];
    underline.backgroundColor = SLLightGray;
    [self.resultLabel addSubview:underline];
    
    /** resultYuanLabel */
    self.resultYuanLabel.frame = self.financeProductFrame.resultYuanLabelF;
    self.resultYuanLabel.text = @"元";
    
    /** calculateButton */
    self.calculateButton.frame = self.financeProductFrame.calculateButtonF;
    [self.calculateButton setTitle:@"计算收益" forState:UIControlStateNormal];
#warning 设置颜色
    [self.calculateButton setBackgroundColor:SLRed];
    [self.calculateButton addTarget:self action:@selector(calculateButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    /** attentionLabel */
    self.attentionLabel.frame = self.financeProductFrame.attentionLabelF;
    self.attentionLabel.text = @"注:此预期非实际收益,未到期提前取现会有损失";
    
    /** detailInfoLabel */
    self.detailInfoLabel.frame = self.financeProductFrame.detailInfoLabelF;
    
    /** detailInfoContentLabel */
//    self.detailInfoContentLabel.frame = self.financeProductFrame.detailInfoContentLabelF;
////    NSString *str = [NSString]
//    self.detailInfoContentLabel.text = self.financeProductFrame.financeProduct.content;
    
    self.detailInfoContentWebView.frame = self.financeProductFrame.detailInfoContentWebViewF;
    [self.detailInfoContentWebView loadHTMLString:self.financeProductFrame.financeProduct.content baseURL:nil];
}

#pragma mark ----- calculateButtonClick计算按钮点击事件
- (void)calculateButtonClick:(UIButton *)calculateButton
{
    if ([self.moneyAmountTextField.text longLongValue] < [self.financeProductFrame.financeProduct.financialProductsDetail.minAmount longLongValue]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"输入金额需要大于起购金额" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    } else {
        double expextedEarnRatio = [self.expectedYield doubleValue];
        
        long long days = (self.valueDateTo - self.valueDateFrom) / 1000 / 60 / 60 / 24;
        
        double result = expextedEarnRatio * [self.moneyAmountTextField.text longLongValue] * days / 365 / 100;
        
        self.resultLabel.text = [NSString stringWithFormat:@"%.2f", result];
    }
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

#pragma mark ----- addAllSubviews添加所有子控件
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
    
    UIView *currentInterestBarView = [[UIView alloc] init];
    self.currentInterestBarView = currentInterestBarView;
    [comparisonView addSubview:currentInterestBarView];
    
    UILabel *currentInterestLabel = [[UILabel alloc] init];
    self.currentInterestLabel = currentInterestLabel;
    [comparisonView addSubview:currentInterestLabel];
    
    UIView *expEarningBarView = [[UIView alloc] init];
    self.expEarningBarView = expEarningBarView;
    [comparisonView addSubview:expEarningBarView];
    
    UILabel *expEarningLabel = [[UILabel alloc] init];
    self.expEarningLabel = expEarningLabel;
    [comparisonView addSubview:expEarningLabel];
    
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
#warning 设置颜色
    [basicInfoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [basicInfoButton setTitleColor:SLRed forState:UIControlStateNormal];
    [basicInfoButton setBackgroundImage:[UIImage resizableImageWithImageName:@"icon_button_left_normal"] forState:UIControlStateNormal];
    [basicInfoButton setBackgroundImage:[UIImage resizableImageWithImageName:@"icon_button_left_selected"] forState:UIControlStateSelected];
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
#warning 设置颜色
    [expEarningCulButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [expEarningCulButton setTitleColor:SLRed forState:UIControlStateNormal];
    [expEarningCulButton setBackgroundImage:[UIImage resizableImageWithImageName:@"icon_button_right_normal"] forState:UIControlStateNormal];
    [expEarningCulButton setBackgroundImage:[UIImage resizableImageWithImageName:@"icon_button_right_selected"] forState:UIControlStateSelected];
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
    detailInfoContentWebView.delegate = self;
    detailInfoContentWebView.scrollView.bounces = NO;
    [self.chartView addSubview:detailInfoContentWebView];
    self.detailInfoContentWebView = detailInfoContentWebView;
    
    UIView *hintView = [[UIView alloc] init];
    hintView.bounds = CGRectMake(0, 0, 200, 200);
    hintView.center = self.view.center;
    hintView.hidden = YES;
    self.hintView = hintView;
    [self.view addSubview:hintView];
    
    UILabel *hintLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
    hintLabel.text = @"网络不给力哦,请稍后重试";
    hintLabel.font = SLFont12;
    hintLabel.textAlignment = NSTextAlignmentCenter;
    [hintView addSubview:hintLabel];
    
    UIButton *hintButton = [[UIButton alloc] initWithFrame:CGRectMake(50, 100, 100, 25)];
    [hintButton setTitle:@"刷新看看" forState:UIControlStateNormal];
    [hintButton setBackgroundColor:SLLightGray];
    hintButton.titleLabel.font = SLFont12;
    [hintButton addTarget:self action:@selector(hintButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [hintView addSubview:hintButton];
    
    CGFloat toolBarW = screenW;
    CGFloat toolBarH = 49;
    CGFloat toolBarX = 0;
    CGFloat toolBarY = screenH - toolBarH;
    SLClientToolBar *toolBar = [[SLClientToolBar alloc] initWithFrame:CGRectMake(toolBarX, toolBarY, toolBarW, toolBarH)];
    toolBar.delegate = self;
    [self.view addSubview:toolBar];
    
    [self loadInternetData];
}

- (void)clientToolBar:(SLClientToolBar *)clientToolBar didClickedLeftButton:(SLTabBarButton *)leftButton
{
    SLAccount *account = [SLAccountTool getAccount];
    
    if ([account.accountInfo.userType isEqualToString:@"3"]) {
        SLMessageViewController *messagevc = [[SLMessageViewController alloc] init];
        messagevc.from = @"toolBar";
        [self.navigationController pushViewController:messagevc animated:YES];
    } else if ([account.accountInfo.userType isEqualToString:@"2"]) {
        SLMessageListController *mlvc = [[SLMessageListController alloc] init];
        mlvc.from = @"toolBar";
        [self.navigationController pushViewController:mlvc animated:YES];
    }
}

- (void)clientToolBar:(SLClientToolBar *)clientToolBar didClickedRightButton:(SLTabBarButton *)rightButton
{
    SLAccount *account = [SLAccountTool getAccount];
    
    if ([account.accountInfo.userType isEqualToString:@"2"]) {
        SLClientListTableViewController *clvc = [[SLClientListTableViewController alloc] init];
        clvc.from = @"toolBar";
        [self.navigationController pushViewController:clvc animated:YES];
    } else if ([account.accountInfo.userType isEqualToString:@"3"]) {
        [self setActionSheet];
    }
}

#pragma mark ----- 设置actionSheet
- (void)setActionSheet
{
    SLConsultant *consultant = [SLConsultantTool getConsultantAccount];
    
    UIActionSheet *actionSheet;
    if (consultant.mobile) {
        if (consultant.telephone) {
            actionSheet = [[UIActionSheet alloc] initWithTitle:consultant.dispName delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:consultant.mobile, consultant.telephone, nil];
        } else {
            actionSheet = [[UIActionSheet alloc] initWithTitle:consultant.dispName delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:consultant.mobile, nil];
        }
    } else {
        if (consultant.telephone) {
            actionSheet = [[UIActionSheet alloc] initWithTitle:consultant.dispName delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:consultant.telephone, nil];
        } else {
            actionSheet = [[UIActionSheet alloc] initWithTitle:consultant.dispName delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:nil];
        }
    }
    
    [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIWebView *callWebView = [[UIWebView alloc] init];
    [self.view addSubview:callWebView];
    
    SLConsultant *consultant = [SLConsultantTool getConsultantAccount];
    
    if (consultant.mobile) {
        if (consultant.telephone) {
            if (buttonIndex == 0) {
                NSURL *url = [NSURL URLWithString:consultant.mobile];
                [callWebView loadRequest:[NSURLRequest requestWithURL:url]];
            } else if (buttonIndex == 1) {
                NSURL *url = [NSURL URLWithString:consultant.telephone];
                [callWebView loadRequest:[NSURLRequest requestWithURL:url]];
            } else if (buttonIndex == 2) {
            }
        } else {
            if (buttonIndex == 0) {
                NSURL *url = [NSURL URLWithString:consultant.mobile];
                [callWebView loadRequest:[NSURLRequest requestWithURL:url]];
            } else if (buttonIndex == 1) {
            }
        }
    } else {
        if (consultant.telephone) {
            if (buttonIndex == 0) {
                NSURL *url = [NSURL URLWithString:consultant.telephone];
                [callWebView loadRequest:[NSURLRequest requestWithURL:url]];
            } else if (buttonIndex == 1) {
            }
        } else {
            if (buttonIndex == 0) {
            }
        }
    }
}

- (void)hintButtonClick:(UIButton *)hintButton
{
    [self loadInternetData];
}

#pragma mark ----- 预期收益计算按钮点击事件
- (void)expEarningCulButtonClick:(UIButton *)expEarningCulButton
{
    self.basicInfoButton.selected = NO;
    self.basicInfoView.hidden = YES;
    self.expEarningCulButton.selected = YES;
    self.expEarningCulView.hidden = NO;
}
/**
 *  基本信息按钮点击事件
 */
- (void)basicInfoButtonClick:(UIButton *)basicInfoButton
{
    self.expEarningCulButton.selected = NO;
    self.expEarningCulView.hidden = YES;
    self.basicInfoButton.selected = YES;
    self.basicInfoView.hidden = NO;
}

#pragma mark ----- viewDidLoad
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 添加所有的子控件
    [self addAllSubviews];
    
    [self basicInfoButtonClick:self.basicInfoButton];
    
    // 监听键盘的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

#pragma mark ----- 加载网络数据
- (void)loadInternetData
{
    [MBProgressHUD showMessage:@"数据加载中"];
    
    SLMeterialDetialParameters *parameters = [SLMeterialDetialParameters parameters];
    parameters.materialId = self.materialId;
    
    [SLMeterialDetialTool meterialDetialWithParameters:parameters success:^(SLResult *result) {
        
        [MBProgressHUD hideHUD];
        if (result.info.count > 0) {
            NSDictionary *dict = [result.info lastObject];
            SLFinanceProduct *financeProduct = [SLFinanceProduct objectWithKeyValues:dict];
            SLFinanceProductFrame *financeProductFrame = [[SLFinanceProductFrame alloc] init];
            financeProductFrame.financeProduct = financeProduct;
            self.financeProductFrame = financeProductFrame;
            
            [self setCollectAndPrise];
            
            self.hintView.hidden = YES;
        }
        [MBProgressHUD hideHUD];
        
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
        
        self.hintView.hidden = NO;
    }];
}

#pragma mark ----- setCollectAndPrise设置导航栏赞和收藏图标
- (void)setCollectAndPrise
{
    // 设置右上角的barButton
    SLPraiseButton *priseButton = [SLPraiseButton button];
    [priseButton setMaterialId:self.financeProductFrame.financeProduct.financialProductsDetail.materialId praiseCounts:self.financeProductFrame.financeProduct.praiseCounts praiseFlag:self.financeProductFrame.financeProduct.materialUser.praiseFlag];
    UIBarButtonItem *priseItem = [[UIBarButtonItem alloc] initWithCustomView:priseButton];
    
    SLCollectButton *collectButton = [SLCollectButton button];
    [collectButton setMaterialId:self.financeProductFrame.financeProduct.financialProductsDetail.materialId collectFlag:self.financeProductFrame.financeProduct.materialUser.collectFlag];
    UIBarButtonItem *collectItem = [[UIBarButtonItem alloc] initWithCustomView:collectButton];
    
    UIButton *manageButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [manageButton setTitle:@"管理" forState:UIControlStateNormal];
    [manageButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    manageButton.titleLabel.font = SLFont14;
    [manageButton addTarget:self action:@selector(manageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *manageItem = [[UIBarButtonItem alloc] initWithCustomView:manageButton];
    
    SLAccount *account = [SLAccountTool getAccount];
    
    if ([account.accountInfo.userType isEqualToString:@"2"]) {
        NSArray *rightBarButtonItems = @[manageItem, priseItem, collectItem];
        self.navigationItem.rightBarButtonItems = rightBarButtonItems;
    } else if ([account.accountInfo.userType isEqualToString:@"3"]) {
        NSArray *rightBarButtonItems = @[priseItem, collectItem];
        self.navigationItem.rightBarButtonItems = rightBarButtonItems;
    }
}

#pragma mark ----- 管理按钮点击事件
- (void)manageButtonClick:(UIButton *)manageButton
{
    SLManageViewController *mvc = [[SLManageViewController alloc] init];
    mvc.materialId = self.materialId;
    [self.navigationController pushViewController:mvc animated:YES];
}


#pragma mark ----- 调出键盘时的监听方法
- (void)keyboardWillChangeFrame:(NSNotification *)note
{
    // 0.取出键盘动画的时间
//    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 1.取得键盘最后的frame
    CGRect keyboardFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect keyboardFrame1 = [note.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGFloat move = (keyboardFrame1.origin.y - keyboardFrame.origin.y) * 0.5;
    
    if (move > 0) {
        [self.scrollView setContentOffset:CGPointMake(0, 108) animated:YES];
    } else {
        [self.scrollView setContentOffset:CGPointMake(0, -64) animated:YES];
    }
    
}

#pragma mark ----- 数据传输在viewDidLoad之后进行
- (void)setFinanceProductFrame:(SLFinanceProductFrame *)financeProductFrame
{
    _financeProductFrame = financeProductFrame;
    
    [self setupSubviewsData];
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

#pragma mark ----- uiwebview代理方法
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    CGSize actualSize = [webView sizeThatFits:CGSizeZero];
    CGRect newFrame = webView.frame;
    newFrame.size.height = actualSize.height;
    webView.frame = newFrame;
    
    CGRect chartViewFrame = self.chartView.frame;
    chartViewFrame.size.height += actualSize.height;
    self.chartView.frame = chartViewFrame;
    
    CGSize contentSize = self.scrollView.contentSize;
    contentSize.height += actualSize.height;
    self.scrollView.contentSize = contentSize;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
