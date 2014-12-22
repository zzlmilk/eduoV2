//
//  SLCommentViewController.m
//  02-pigBank
//
//  Created by 陆承东 on 14/12/12.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLCommentViewController.h"

#import "SLCommitCommentParameters.h"

#import "UIBarButtonItem+SL.h"
#import "SLCommitCommentTool.h"

#import "MBProgressHUD+MJ.h"

#define scoreButtonW 20

@interface SLCommentViewController ()<UITextViewDelegate>

@property (nonatomic, strong) NSMutableArray *scoreButtonArray;

@property (nonatomic, weak) UILabel *tipLabel;

@property (nonatomic, weak) UITextView *commentTextView;

@property (nonatomic, weak) UILabel *placeholdLabel;

@property (nonatomic, assign) int score;

@end

@implementation SLCommentViewController

- (NSMutableArray *)scoreButtonArray
{
    if (_scoreButtonArray == nil) {
        _scoreButtonArray = [NSMutableArray array];
    }
    return _scoreButtonArray;
}

#pragma mark ----- viewDidLoad
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.score = 0;
    
    [self addAllSubviews];
    
    [self setSubviewData];
    
    [self setNavBar];
}

#pragma mark ----- setNavBar设置导航栏
- (void)setNavBar
{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"guanBi" highlightImage:nil target:self action:@selector(leftBarButtonItemClicked:)];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"queDing" highlightImage:nil target:self action:@selector(rightBarButtonItemClicked:)];
}

#pragma mark ----- rightBarButtonItemClicked右侧按钮点击事件
- (void)rightBarButtonItemClicked:(UIBarButtonItem *)rightBarButtonItem
{
    if (self.commentTextView.text.length == 0) {
        [MBProgressHUD showError:@"请输入评论内容"];
    }
    
    SLCommitCommentParameters *parameters = [SLCommitCommentParameters parameters];
    parameters.merchantId = [NSNumber numberWithLong:self.vipMerchantDetail.merchantId];
    parameters.score = [NSNumber numberWithInt:self.score];
    parameters.comment = self.commentTextView.text;
    
    [SLCommitCommentTool commitCommentWithParameters:parameters success:^(NSString *code) {
        if ([code isEqualToString:@"0000"]) {
            
            [MBProgressHUD showSuccess:@"点评成功"];
            
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark ----- leftBarButtonItemClicked左侧按钮点击事件
- (void)leftBarButtonItemClicked:(UIBarButtonItem *)leftBarButtonItem
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark ----- addAllSubviews添加所有子控件
- (void)addAllSubviews
{
    // 评分按钮
    for (int i = 0; i < 5; i++) {
        UIButton *scoreButton = [[UIButton alloc] init];
        [self.scoreButtonArray addObject:scoreButton];
        [self.view addSubview:scoreButton];
    }
    
    // 提示按钮
    UILabel *tipLabel = [[UILabel alloc] init];
    [self.view addSubview:tipLabel];
    self.tipLabel = tipLabel;
    
    // 评论输入框
    UITextView *commentTextView = [[UITextView alloc] init];
    commentTextView.delegate = self;
    [self.view addSubview:commentTextView];
    self.commentTextView = commentTextView;
    
    // placeholder
    UILabel *placeholdLabel = [[UILabel alloc] init];
    [self.commentTextView addSubview:placeholdLabel];
    self.placeholdLabel = placeholdLabel;
}

#pragma mark ----- setSubviewData设置子控件数据
- (void)setSubviewData
{
    // 评分按钮
    for (int i = 0; i < 5; i++) {
        UIButton *scoreButton = self.scoreButtonArray[i];
        CGFloat scoreButtonX = (screenW - (scoreButtonW * 5)) / 2 + scoreButtonW * i;
        CGFloat scoreButtonY = 74;
        scoreButton.frame = CGRectMake(scoreButtonX, scoreButtonY, scoreButtonW, scoreButtonW);
        scoreButton.tag = i;
        [scoreButton addTarget:self action:@selector(scoreButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [scoreButton setImage:[UIImage imageNamed:@"pingFenXin"] forState:UIControlStateNormal];
    }
    
    // 提示按钮
    CGFloat tipLabelX = 0;
    CGFloat tipLabelY = 74 + scoreButtonW + middleMargin;
    CGFloat tipLabelW = screenW;
    CGFloat tipLabelH = 12;
    self.tipLabel.frame = CGRectMake(tipLabelX, tipLabelY, tipLabelW, tipLabelH);
    self.tipLabel.font = SLFont12;
    self.tipLabel.textAlignment = NSTextAlignmentCenter;
    self.tipLabel.text = @"请点击星星评分";
    
    // 评论输入框
    CGFloat commentTextViewX = middleMargin;
    CGFloat commentTextViewY = CGRectGetMaxY(self.tipLabel.frame) + middleMargin;
    CGFloat commentTextViewW = screenW - middleMargin * 2;
    CGFloat commentTextViewH = 100;
    self.commentTextView.frame = CGRectMake(commentTextViewX, commentTextViewY, commentTextViewW, commentTextViewH);
    self.commentTextView.backgroundColor = [UIColor lightGrayColor];
    self.commentTextView.font = SLFont14;
    
    // placeholder
    CGFloat placeholdLabelX = smallMargin;
    CGFloat placeholdLabelY = 5;
    CGFloat placeholdLabelW = 250;
    CGFloat placeholdLabelH = 20;
    self.placeholdLabel.frame = CGRectMake(placeholdLabelX, placeholdLabelY, placeholdLabelW, placeholdLabelH);
    self.placeholdLabel.font = SLFont14;
    self.placeholdLabel.text = @"最多可输入140字的评论";
}

#pragma mark ----- textView代理方法,当textView的文字发生改变时调用
- (void)textViewDidChange:(UITextView *)textView
{
    NSInteger number = [textView.text length];
    if (number >= 140) {
        textView.text = [textView.text substringToIndex:140];
        
        [MBProgressHUD showError:@"字符已达上限"];
    }
    
    if (number == 0) {
        self.placeholdLabel.hidden = NO;
    } else {
        self.placeholdLabel.hidden = YES;
    }
}

#pragma mark ----- scoreButtonClicked评分按钮点击事件
- (void)scoreButtonClicked:(UIButton *)scoreButton
{
    for (int i = 0; i < 5; i++) {
        UIButton *button = self.scoreButtonArray[i];
        self.score = scoreButton.tag + 1;
        if (i <= scoreButton.tag) {
            [button setImage:[UIImage imageNamed:@"pingFenXinJiaoHu"] forState:UIControlStateNormal];
        } else {
            [button setImage:[UIImage imageNamed:@"pingFenXin"] forState:UIControlStateNormal];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
