//
//  SLFindPwdViewController.m
//  02-pigBank
//
//  Created by 陆承东 on 15/1/20.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import "SLFindPwdViewController.h"

#import "SLMessageParameters.h"
#import "SLFindPwdParameters.h"

#import "SLInputTextField.h"
#import "SLLoginButton.h"
#import "SLWhiteBackButton.h"

#import "SLMessageTool.h"
#import "SLFindPwdTool.h"
#import "NSString+S_LINE.h"
#import "UIImage+S_LINE.h"

@interface SLFindPwdViewController ()

@property (nonatomic, weak) SLInputTextField *mobileTextField;
@property (nonatomic, weak) UIButton *confirmButton;
@property (nonatomic, weak) SLInputTextField *securityCodeTextField;
@property (nonatomic, weak) UILabel *yourMobileLabel;
@property (nonatomic, weak) UILabel *hintLabel;
@property (nonatomic, weak) SLInputTextField *passwordTextField;
@property (nonatomic, weak) SLInputTextField *confirmPasswordTextField;
@property (nonatomic, weak) SLLoginButton *commitButton;

@property (nonatomic, assign) int time;

@end

@implementation SLFindPwdViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setNavBar];
}

#pragma mark ----- 设置导航栏
- (void)setNavBar
{
    self.navigationController.navigationBar.hidden = NO;
    
    SLWhiteBackButton *backButton = [SLWhiteBackButton button];
    [backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backItem;
}

#pragma mark ----- 返回按钮点击事件
- (void)backButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addSubviews];
    
    [self addObservers];
}

#pragma mark ----- 添加监听方法
- (void)addObservers
{
    // 监听文本框文字改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged) name:UITextFieldTextDidChangeNotification object:self.mobileTextField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged) name:UITextFieldTextDidChangeNotification object:self.securityCodeTextField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged) name:UITextFieldTextDidChangeNotification object:self.passwordTextField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged) name:UITextFieldTextDidChangeNotification object:self.confirmPasswordTextField];
}

#pragma mark ----- addSubviews添加所有子控件
- (void)addSubviews
{
    self.view.backgroundColor = [UIColor whiteColor];
    UITapGestureRecognizer *tapView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
    [self.view addGestureRecognizer:tapView];
    
    SLInputTextField *mobileTextField = [SLInputTextField inputTextFieldWithLeftViewImage:@"icon_mobile"];
    self.mobileTextField = mobileTextField;
    [self.view addSubview:mobileTextField];
    
    UIButton *confirmButton = [[UIButton alloc] init];
    self.confirmButton = confirmButton;
    mobileTextField.rightView = confirmButton;
    mobileTextField.rightViewMode = UITextFieldViewModeAlways;
    
    SLInputTextField *securityCodeTextField = [SLInputTextField inputTextFieldWithLeftViewImage:@"icon_securityCode"];
    self.securityCodeTextField = securityCodeTextField;
    [self.view addSubview:securityCodeTextField];
    
    UILabel *yourMobileLabel = [[UILabel alloc] init];
    self.yourMobileLabel = yourMobileLabel;
    [self.view addSubview:yourMobileLabel];
    
    UILabel *hintLabel = [[UILabel alloc] init];
    self.hintLabel = hintLabel;
    [self.view addSubview:hintLabel];
    
    SLInputTextField *passwordTextField = [SLInputTextField inputTextFieldWithLeftViewImage:@"icon_password"];
    self.passwordTextField = passwordTextField;
    [self.view addSubview:passwordTextField];
    
    SLInputTextField *confirmPasswordTextField = [SLInputTextField inputTextFieldWithLeftViewImage:@"icon_ confirmPassword"];
    self.confirmPasswordTextField = confirmPasswordTextField;
    [self.view addSubview:confirmPasswordTextField];
    
    SLLoginButton *commitButton = [SLLoginButton buttonWithTitle:@"确定" backgroundImage:@"login_loginButtonBg_normal" highlightBackgroundImage:@"login_loginButtonBg_highlight"];
    self.commitButton = commitButton;
    [self.view addSubview: commitButton];
    
    [self setSubviewsData];
}

#pragma mark ----- view的点击后退出键盘
- (void)tapView:(UITapGestureRecognizer *)tapView
{
    [self.view endEditing:YES];
}

#pragma mark ----- 设置子控件数据
- (void)setSubviewsData
{
    CGFloat mobileTextFieldX = middleMargin;
    CGFloat mobileTextFieldY = 64 + largeMargin;
    CGFloat mobileTextFieldW = screenW - largeMargin;
    CGFloat mobileTextFieldH = 30;
    self.mobileTextField.frame = CGRectMake(mobileTextFieldX, mobileTextFieldY, mobileTextFieldW, mobileTextFieldH);
    self.mobileTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.mobileTextField.placeholder = @"手机号";
    self.mobileTextField.font = SLFont14;
    
    CGFloat confirmButtonW = 80;
    CGFloat confirmButtonH = 30;
    self.confirmButton.bounds = CGRectMake(0, 0, confirmButtonW, confirmButtonH);
    [self.confirmButton setBackgroundImage:[UIImage resizableImageWithImageName:@"icon_button_redBg_normal"] forState:UIControlStateNormal];
    [self.confirmButton setBackgroundImage:[UIImage resizableImageWithImageName:@"icon_button_bg_disable"] forState:UIControlStateDisabled];
    [self.confirmButton setTitle:@"验证码" forState:UIControlStateNormal];
    self.confirmButton.titleLabel.font = SLFont14;
    [self.confirmButton addTarget:self action:@selector(confirmButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.confirmButton.layer.cornerRadius = 5;
    self.confirmButton.clipsToBounds = YES;
    
    
    CGFloat securityCodeTextFieldX = mobileTextFieldX;
    CGFloat securityCodeTextFieldY = CGRectGetMaxY(self.mobileTextField.frame) + middleMargin;
    CGFloat securityCodeTextFieldW = mobileTextFieldW;
    CGFloat securityCodeTextFieldH = mobileTextFieldH;
    self.securityCodeTextField.frame = CGRectMake(securityCodeTextFieldX, securityCodeTextFieldY, securityCodeTextFieldW, securityCodeTextFieldH);
    self.securityCodeTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.securityCodeTextField.placeholder = @"验证码";
    self.securityCodeTextField.font = SLFont14;
    
    CGFloat yourMobileLabelX = securityCodeTextFieldX + middleMargin;
    CGFloat yourMobileLabelY = CGRectGetMaxY(self.securityCodeTextField.frame) + middleMargin;
    CGFloat yourMobileLabelW = screenW - yourMobileLabelX - middleMargin;
    CGFloat yourMobileLabelH = 12;
    self.yourMobileLabel.frame = CGRectMake(yourMobileLabelX, yourMobileLabelY, yourMobileLabelW, yourMobileLabelH);
    self.yourMobileLabel.font = SLFont12;
    self.yourMobileLabel.textColor = [UIColor grayColor];
    self.yourMobileLabel.hidden = YES;
    
    CGFloat hintLabelX = yourMobileLabelX;
    CGFloat hintLabelY = CGRectGetMaxY(self.yourMobileLabel.frame) + smallMargin;
    CGFloat hintLabelW = yourMobileLabelW;
    CGFloat hintLabelH = yourMobileLabelH;
    self.hintLabel.frame = CGRectMake(hintLabelX, hintLabelY, hintLabelW, hintLabelH);
    self.hintLabel.font = SLFont12;
    self.hintLabel.textColor = [UIColor grayColor];
    self.hintLabel.hidden = YES;
    
    CGFloat passwordTextFieldX = securityCodeTextFieldX;
    CGFloat passwordTextFieldY = CGRectGetMaxY(self.securityCodeTextField.frame) + middleMargin;
    CGFloat passwordTextFieldW = securityCodeTextFieldW;
    CGFloat passwordTextFieldH = securityCodeTextFieldH;
    self.passwordTextField.frame = CGRectMake(passwordTextFieldX, passwordTextFieldY, passwordTextFieldW, passwordTextFieldH);
    self.passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.passwordTextField.secureTextEntry = YES;
    self.passwordTextField.placeholder = @"密码";
    self.passwordTextField.font = SLFont14;
    
    CGFloat confirmPasswordTextFieldX = securityCodeTextFieldX;
    CGFloat confirmPasswordTextFieldY = CGRectGetMaxY(self.passwordTextField.frame) + middleMargin;
    CGFloat confirmPasswordTextFieldW = securityCodeTextFieldW;
    CGFloat confirmPasswordTextFieldH = securityCodeTextFieldH;
    self.confirmPasswordTextField.frame = CGRectMake(confirmPasswordTextFieldX, confirmPasswordTextFieldY, confirmPasswordTextFieldW, confirmPasswordTextFieldH);
    self.confirmPasswordTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.confirmPasswordTextField.secureTextEntry = YES;
    self.confirmPasswordTextField.placeholder = @"确认密码";
    self.confirmPasswordTextField.font = SLFont14;
    
    self.commitButton.center = CGPointMake(self.confirmPasswordTextField.center.x, CGRectGetMaxY(self.confirmPasswordTextField.frame) + middleMargin + self.commitButton.frame.size.height * 0.5);
    [self.commitButton addTarget:self action:@selector(commitButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.commitButton.enabled = NO;
}

#pragma mark ----- textField的监听方法
- (void)textChanged
{
    self.commitButton.enabled = (self.mobileTextField.text.length && self.securityCodeTextField.text.length && self.passwordTextField.text.length && self.confirmPasswordTextField.text.length);
}

#pragma mark ----- 验证码按钮点击事件
- (void)confirmButtonClick:(UIButton *)confirmButton
{
    if (self.mobileTextField.text.length != 11) {
        [MBProgressHUD showError:@"请检查输入的手机号"];
    } else {
        SLMessageParameters *parameters = [SLMessageParameters parameters];
        parameters.mobile = self.mobileTextField.text;
        
        [SLMessageTool messageWithParameters:parameters success:^(SLResult *result) {
            if ([result.code isEqualToString:@"0000"]) {
                
                self.time = 60;
                
                [MBProgressHUD showSuccess:@"成功下发验证码..."];
                
                CADisplayLink *countdown = [CADisplayLink displayLinkWithTarget:self selector:@selector(countdown:)];
                countdown.frameInterval = 60;
                [countdown addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
                
                if (self.yourMobileLabel.hidden == YES) {
                    
                    CGFloat move = CGRectGetMaxY(self.hintLabel.frame) - CGRectGetMaxY(self.securityCodeTextField.frame);
                    
                    self.yourMobileLabel.alpha = 0;
                    self.yourMobileLabel.hidden = NO;
                    self.hintLabel.alpha = 0;
                    self.hintLabel.hidden = NO;
                    
                    CGRect passwordTextFieldF = self.passwordTextField.frame;
                    CGRect confirmPasswordTextFielF = self.confirmPasswordTextField.frame;
                    CGRect commitButtonF = self.commitButton.frame;
                    passwordTextFieldF.origin.y += move;
                    confirmPasswordTextFielF.origin.y += move;
                    commitButtonF.origin.y += move;
                    
                    NSString *mobile = [self.mobileTextField.text stringByReplacingCharactersInRange:NSMakeRange(self.mobileTextField.text.length - 8, 6) withString:@"******"];
                    self.yourMobileLabel.text = [NSString stringWithFormat:@"你的手机号:%@", mobile];
                    self.hintLabel.text = @"我们给你发送了一条消息,请将此作为验证码输入";
                    
                    [UIView animateWithDuration:0.5 animations:^{
                        self.yourMobileLabel.alpha = 1;
                        self.hintLabel.alpha = 1;
                        self.passwordTextField.frame = passwordTextFieldF;
                        self.confirmPasswordTextField.frame = confirmPasswordTextFielF;
                        self.commitButton.frame = commitButtonF;
                    }];
                }
            } else {
                
                [MBProgressHUD showError:result.msg];
                
            }
        } failure:^(NSError *error) {
            
        }];
    }
}

#pragma mark ----- 倒计时定时器响应事件
- (void)countdown:(CADisplayLink *)countdown
{
    self.time -= 1;
    
    if (self.time == 0) {
        [countdown invalidate];
        countdown = nil;
        self.confirmButton.enabled = YES;
        [self.confirmButton setTitle:@"验证码" forState:UIControlStateNormal];
    } else {
        self.confirmButton.enabled = NO;
        [self.confirmButton setTitle:[NSString stringWithFormat:@"%i" , self.time] forState:UIControlStateDisabled];
    }
}

#pragma mark ----- 提交按钮点击事件
- (void)commitButtonClick:(SLLoginButton *)commitButton
{
    if (self.mobileTextField.text.length != 11) {
        [MBProgressHUD showError:@"请检查输入的手机号"];
    } else {
        if ([self.passwordTextField.text isEqualToString:self.confirmPasswordTextField.text]) {
            SLFindPwdParameters *parameters = [SLFindPwdParameters parameters];
            parameters.mobile = self.mobileTextField.text;
            parameters.vercode = self.securityCodeTextField.text;
            parameters.password = [self.passwordTextField.text MD5];
            
            [SLFindPwdTool findPwdWithParameters:parameters success:^(SLResult *result) {
                if ([result.code isEqualToString:@"0000"]) {
                    [MBProgressHUD showSuccess:@"密码已找回"];
                    
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }
            } failure:^(NSError *error) {
                
            }];
        } else {
            [MBProgressHUD showError:@"两次密码输入不一致"];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
