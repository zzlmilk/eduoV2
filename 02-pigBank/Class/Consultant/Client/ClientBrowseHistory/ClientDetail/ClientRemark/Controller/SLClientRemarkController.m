//
//  SLClientRemarkController.m
//  02-pigBank
//
//  Created by 陆承东 on 15/1/24.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import "SLClientRemarkController.h"

#import "SLClientTool.h"

#import "MBProgressHUD+MJ.h"

@interface SLClientRemarkController ()

@property (nonatomic, weak) UITextField *remarkNameTextField;
@property (nonatomic, weak) UITextView *remarkContentTextView;
@property (nonatomic, weak) UILabel *hintLabel;

@end

@implementation SLClientRemarkController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setNavBar];
}

#pragma mark ----- setNavBar设置导航栏
- (void)setNavBar
{
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 18, 18)];
    [backButton setImage:[UIImage imageNamed:@"icon_nav_left_dismiss"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backItem;
    
    UIButton *commitButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 24, 16)];
    [commitButton setImage:[UIImage imageNamed:@"icon_nav_right_commit"] forState:UIControlStateNormal];
    [commitButton addTarget:self action:@selector(commitButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *commitItem = [[UIBarButtonItem alloc] initWithCustomView:commitButton];
    self.navigationItem.rightBarButtonItem = commitItem;
}

#pragma mark ----- backButtonClicked返回按钮点击事件
- (void)backButtonClicked:(UIButton *)backButton
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark ----- 确定按钮的点击事件
- (void)commitButtonClicked:(UIButton *)commitButton
{
    SLModifyClientRemarkParameters *parameters = [SLModifyClientRemarkParameters parameters];
    parameters.userId = self.client.userId;
    parameters.remarkName = self.remarkNameTextField.text;
    parameters.remark = self.remarkContentTextView.text;
    
    [SLClientTool clientModifyClientRemarkWithParameters:parameters success:^(SLResult *result) {
        if ([result.code isEqualToString:@"0000"]) {
            [MBProgressHUD showSuccess:@"用户备注修改成功"];
            
            [self.navigationController dismissViewControllerAnimated:YES completion:^{
                
            }];
        }
    } failure:^(NSError *error) {
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addSubviews];
    
    [self addObserver];
}

#pragma mark ----- 添加监听方法
- (void)addObserver
{
    // 监听文本框文字改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged) name:UITextFieldTextDidChangeNotification object:self.remarkNameTextField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged) name:UITextViewTextDidChangeNotification object:self.remarkContentTextView];
}

#pragma mark ----- 添加子控件
- (void)addSubviews
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat remarkNameTextFieldX = middleMargin;
    CGFloat remarkNameTextFieldY = largeMargin + 64;
    CGFloat remarkNameTextFieldW = screenW - largeMargin;
    CGFloat remarkNameTextFieldH = 30;
    UITextField *remarkNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(remarkNameTextFieldX, remarkNameTextFieldY, remarkNameTextFieldW, remarkNameTextFieldH)];
    remarkNameTextField.placeholder = @"备注名";
    remarkNameTextField.font = SLFont14;
    remarkNameTextField.backgroundColor = SLLightGray;
    remarkNameTextField.layer.cornerRadius = 5;
    remarkNameTextField.clipsToBounds = YES;
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 30)];
    remarkNameTextField.leftView = paddingView;
    remarkNameTextField.leftViewMode = UITextFieldViewModeAlways;
    self.remarkNameTextField = remarkNameTextField;
    [self.view addSubview:remarkNameTextField];
    
    CGFloat remarkContentTextViewX = remarkNameTextFieldX;
    CGFloat remarkContentTextViewY = CGRectGetMaxY(remarkNameTextField.frame) + largeMargin;
    CGFloat remarkContentTextViewW = remarkNameTextFieldW;
    CGFloat remarkContentTextViewH = 150;
    UITextView *remarkContentTextView = [[UITextView alloc] initWithFrame:CGRectMake(remarkContentTextViewX, remarkContentTextViewY, remarkContentTextViewW, remarkContentTextViewH)];
    remarkContentTextView.font = SLFont14;
    remarkContentTextView.layer.cornerRadius = 5;
    remarkContentTextView.clipsToBounds = YES;
    remarkContentTextView.backgroundColor = SLLightGray;
    self.remarkContentTextView = remarkContentTextView;
    [self.view addSubview:remarkContentTextView];
    
    CGFloat hintLabelX = remarkNameTextFieldX + smallMargin;
    CGFloat hintLabelY = remarkContentTextViewY;
    CGFloat hintLabelW = remarkContentTextViewW;
    CGFloat hintLabelH = 30;
    UILabel *hintLabel = [[UILabel alloc] initWithFrame:CGRectMake(hintLabelX, hintLabelY, hintLabelW, hintLabelH)];
    hintLabel.font = SLFont14;
    hintLabel.textColor = [UIColor grayColor];
    hintLabel.contentMode = UIViewContentModeCenter;
    hintLabel.text = @"备注信息";
    self.hintLabel = hintLabel;
    [self.view addSubview:hintLabel];
}

#pragma mark ----- 输入框文字改变监听方法
- (void)textChanged
{
    if (self.remarkContentTextView.text.length == 0) {
        self.hintLabel.hidden = NO;
    } else {
        self.hintLabel.hidden = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
