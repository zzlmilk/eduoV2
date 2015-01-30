//
//  SLChangeMyMobileController.m
//  02-pigBank
//
//  Created by 陆承东 on 14-9-26.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLChangeMyMobileController.h"

#import "SLAccount.h"

#import "SLBackButton.h"
#import "SLInputTextField.h"
#import "SLLoginButton.h"

#import "SLAccountTool.h"
#import "SLMessageTool.h"
#import "SLModifyTool.h"

#import "UIImage+S_LINE.h"
#import "NSString+S_LINE.h"
#import "MBProgressHUD+MJ.h"

#define lingNumber 4

@interface SLChangeMyMobileController ()

@property (nonatomic, weak) SLInputTextField *nameTextField;
@property (nonatomic, weak) SLInputTextField *passwordTextField;
@property (nonatomic, weak) SLInputTextField *freshMobileTextField;
@property (nonatomic, weak) SLInputTextField *securityCodeTextField;
@property (nonatomic, weak) UIButton *confirmButton;
@property (nonatomic, weak) SLLoginButton *commitButton;

@property (nonatomic, assign) int time;

@end

@implementation SLChangeMyMobileController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setNavBar];
}

#pragma mark ----- setNavBar设置导航栏
- (void)setNavBar
{
    SLBackButton *backButton = [SLBackButton button];
    [backButton addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backItem;
}

#pragma mark ----- backButtonClicked返回按钮点击事件
- (void)backButtonClicked:(SLBackButton *)backButton
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 添加所有子控件
    [self addAllSubviews];
    
    [self addObserver];
}

#pragma mark ----- 添加监听方法
- (void)addObserver
{
    // 监听文本框文字改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged) name:UITextFieldTextDidChangeNotification object:self.nameTextField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged) name:UITextFieldTextDidChangeNotification object:self.passwordTextField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged) name:UITextFieldTextDidChangeNotification object:self.freshMobileTextField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged) name:UITextFieldTextDidChangeNotification object:self.securityCodeTextField];
}

- (void)textChanged
{
    self.commitButton.enabled = self.nameTextField.text.length && self.passwordTextField.text.length && self.freshMobileTextField.text.length && self.securityCodeTextField.text.length ;
}

#pragma mark ----- 添加所有子控件
- (void)addAllSubviews
{
    SLInputTextField *nameTextField = [SLInputTextField inputTextFieldWithLeftViewImage:@"icon_image_name"];
    CGFloat nameTextFieldX = middleMargin;
    CGFloat nameTextFieldY = largeMargin + 64;
    CGFloat nameTextFieldW = screenW - largeMargin;
    CGFloat nameTextFieldH = 30;
    CGRect nameTextFieldF = CGRectMake(nameTextFieldX, nameTextFieldY, nameTextFieldW, nameTextFieldH);
    nameTextField.frame = nameTextFieldF;
    nameTextField.borderStyle = UITextBorderStyleRoundedRect;
    nameTextField.placeholder = @"请输入姓名";
    nameTextField.font = SLFont14;
    self.nameTextField = nameTextField;
    [self.view addSubview:nameTextField];
    
    SLInputTextField *passwordTextField = [SLInputTextField inputTextFieldWithLeftViewImage:@"icon_image_password"];
    CGFloat passwordTextFieldX = nameTextFieldX;
    CGFloat passwordTextFieldY = CGRectGetMaxY(nameTextFieldF) + largeMargin;
    CGFloat passwordTextFieldW = nameTextFieldW;
    CGFloat passwordTextFieldH = nameTextFieldH;
    CGRect passwordTextFieldF = CGRectMake(passwordTextFieldX, passwordTextFieldY, passwordTextFieldW, passwordTextFieldH);
    passwordTextField.frame = passwordTextFieldF;
    passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
    passwordTextField.placeholder = @"请输入密码";
    passwordTextField.secureTextEntry = YES;
    passwordTextField.font = SLFont14;
    self.passwordTextField = passwordTextField;
    [self.view addSubview:passwordTextField];
    
    SLInputTextField *freshMobileTextField = [SLInputTextField inputTextFieldWithLeftViewImage:@"icon_image_newMobile"];
    CGFloat freshMobileTextFieldX = passwordTextFieldX;
    CGFloat freshMobileTextFieldY = CGRectGetMaxY(passwordTextFieldF) + largeMargin;
    CGFloat freshMobileTextFieldW = passwordTextFieldW;
    CGFloat freshMobileTextFieldH = passwordTextFieldH;
    CGRect freshMobileTextFieldF = CGRectMake(freshMobileTextFieldX, freshMobileTextFieldY, freshMobileTextFieldW, freshMobileTextFieldH);
    freshMobileTextField.frame = freshMobileTextFieldF;
    freshMobileTextField.borderStyle = UITextBorderStyleRoundedRect;
    freshMobileTextField.placeholder = @"请输入新手机";
    freshMobileTextField.font = SLFont14;
    self.freshMobileTextField = freshMobileTextField;
    [self.view addSubview:freshMobileTextField];
    
    SLInputTextField *securityCodeTextField = [SLInputTextField inputTextFieldWithLeftViewImage:@"icon_image_securityCode"];
    CGFloat securityCodeTextFieldX = freshMobileTextFieldX;
    CGFloat securityCodeTextFieldY = CGRectGetMaxY(freshMobileTextFieldF) + largeMargin;
    CGFloat securityCodeTextFieldW = freshMobileTextFieldW;
    CGFloat securityCodeTextFieldH = freshMobileTextFieldH;
    CGRect securityCodeTextFieldF = CGRectMake(securityCodeTextFieldX, securityCodeTextFieldY, securityCodeTextFieldW, securityCodeTextFieldH);
    securityCodeTextField.frame = securityCodeTextFieldF;
    securityCodeTextField.borderStyle = UITextBorderStyleRoundedRect;
    securityCodeTextField.placeholder = @"验证码";
    securityCodeTextField.font = SLFont14;
    self.securityCodeTextField = securityCodeTextField;
    [self.view addSubview:securityCodeTextField];
    
    UIButton *confirmButton = [[UIButton alloc] init];
    securityCodeTextField.rightView = confirmButton;
    securityCodeTextField.rightViewMode = UITextFieldViewModeAlways;
    CGFloat confirmButtonW = 80;
    CGFloat confirmButtonH = 30;
    confirmButton.bounds = CGRectMake(0, 0, confirmButtonW, confirmButtonH);
    [confirmButton setBackgroundImage:[UIImage resizableImageWithImageName:@"icon_button_redBg_normal"] forState:UIControlStateNormal];
    [confirmButton setBackgroundImage:[UIImage resizableImageWithImageName:@"icon_button_bg_disable"] forState:UIControlStateDisabled];
    [confirmButton setTitle:@"验证码" forState:UIControlStateNormal];
    confirmButton.titleLabel.font = SLFont14;
    [confirmButton addTarget:self action:@selector(confirmButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    confirmButton.layer.cornerRadius = 5;
    confirmButton.clipsToBounds = YES;
    
    SLLoginButton *commitButton = [SLLoginButton buttonWithTitle:@"确定" backgroundImage:@"login_loginButtonBg_normal" highlightBackgroundImage:@"login_loginButtonBg_highlight"];
    CGFloat commitButtonX = securityCodeTextFieldX;
    CGFloat commitButtonY = CGRectGetMaxY(securityCodeTextFieldF) + largeMargin;
    CGFloat commitButtonW = securityCodeTextFieldW;
    CGFloat commitButtonH = securityCodeTextFieldH;
    CGRect commitButtonF = CGRectMake(commitButtonX, commitButtonY, commitButtonW, commitButtonH);
    commitButton.frame = commitButtonF;
    [commitButton addTarget:self action:@selector(commitButtonClidk:) forControlEvents:UIControlEventTouchUpInside];
    commitButton.enabled = NO;
    self.commitButton = commitButton;
    [self.view addSubview:commitButton];
}

#pragma mark ----- 验证码按钮点击事件
- (void)confirmButtonClick:(UIButton *)confirmButton
{
    SLMessageParameters *parameters = [SLMessageParameters parameters];
    parameters.mobile = self.freshMobileTextField.text;
    
    [SLMessageTool messageWithParameters:parameters success:^(SLResult *result) {
        if ([result.code isEqualToString:@"0000"]) {
            
            self.time = 60;
            
            CADisplayLink *countdown = [CADisplayLink displayLinkWithTarget:self selector:@selector(countdown:)];
            countdown.frameInterval = 60;
            [countdown addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
            
            [MBProgressHUD showSuccess:result.msg];
        } else {
            [MBProgressHUD showError:result.msg];
        }
    } failure:^(NSError *error) {
        
    }];
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

#pragma mark ----- 确定按钮点击事件
- (void)commitButtonClidk:(SLLoginButton *)commitButton
{
    if (self.freshMobileTextField.text.length != 11) {
        [MBProgressHUD showError:@"请输入正确的手机号"];
    } else {
        SLChangeMobileParameters *parameters = [SLChangeMobileParameters parameters];
        parameters.password = [self.passwordTextField.text MD5];
        parameters.mobile = self.freshMobileTextField.text;
        parameters.vercode = self.securityCodeTextField.text;
        
        [SLModifyTool changeMobileWithParameters:parameters success:^(SLResult *result) {
            if ([result.code isEqualToString:@"0000"]) {
                [MBProgressHUD showSuccess:@"手机修改成功"];
            } else if ([result.code isEqualToString:@"9002"]) {
                [MBProgressHUD showError:@"新手机号码已被占用"];
            } else if ([result.code isEqualToString:@"9003"]) {
                [MBProgressHUD showError:@"手机号码格式错误"];
            } else if ([result.code isEqualToString:@"9005"]) {
                [MBProgressHUD showError:@"验证码错误"];
            } else if ([result.code isEqualToString:@"9006"]) {
                [MBProgressHUD showError:@"旧密码输入错误"];
            }
        } failure:^(NSError *error) {
            
        }];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
