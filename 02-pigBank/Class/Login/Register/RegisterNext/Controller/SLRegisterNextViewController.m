//
//  SLRegisterNextViewController.m
//  02-pigBank
//
//  Created by 陆承东 on 15/1/20.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import "sys/utsname.h"

#import "SLRegisterNextViewController.h"

#import "SLInputTextField.h"
#import "SLLoginButton.h"
#import "SLWhiteBackButton.h"

#import "SLMoreViewController.h"
#import "SLTabBarViewController.h"
#import "SLNavigationController.h"
#import "SLSideViewController.h"

#import "SLRegisterTool.h"
#import "SLAccountTool.h"
#import "SLAccountInfo.h"

#import "NSString+S_LINE.h"
#import "MJExtension.h"
#import "MBProgressHUD+MJ.h"

@interface SLRegisterNextViewController ()

@property (nonatomic, weak) SLInputTextField *passwordTextField;
@property (nonatomic, weak) SLInputTextField *confirmPasswordTextField;
@property (nonatomic, weak) SLLoginButton *commitButton;

@end

@implementation SLRegisterNextViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setNavBar];
}

#pragma mark ----- 设置导航栏
- (void)setNavBar
{
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged) name:UITextFieldTextDidChangeNotification object:self.passwordTextField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged) name:UITextFieldTextDidChangeNotification object:self.confirmPasswordTextField];
}

#pragma mark ----- textField的监听方法
- (void)textChanged
{
    self.commitButton.enabled = (self.passwordTextField.text.length && self.confirmPasswordTextField.text.length);
}

#pragma mark ----- addSubviews添加所有子控件
- (void)addSubviews
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    SLInputTextField *passwordTextField = [SLInputTextField inputTextFieldWithLeftViewImage:@"register_password"];
    self.passwordTextField = passwordTextField;
    [self.view addSubview:passwordTextField];
    
    SLInputTextField *confirmPasswordTextField = [SLInputTextField inputTextFieldWithLeftViewImage:@"register_confirmPassword"];
    self.confirmPasswordTextField = confirmPasswordTextField;
    [self.view addSubview:confirmPasswordTextField];
    
    SLLoginButton *commitButton = [SLLoginButton buttonWithTitle:@"确定" backgroundImage:@"login_loginButtonBg_normal" highlightBackgroundImage:@"login_loginButtonBg_highlight"];
    self.commitButton = commitButton;
    self.commitButton.enabled = NO;
    [self.view addSubview: commitButton];
    
    [self setSubviewsData];
}

#pragma mark ----- 设置子控件数据
- (void)setSubviewsData
{
    CGFloat passwordTextFieldX = middleMargin;
    CGFloat passwordTextFieldY = 64 + largeMargin;
    CGFloat passwordTextFieldW = screenW - largeMargin;
    CGFloat passwordTextFieldH = 30;
    self.passwordTextField.frame = CGRectMake(passwordTextFieldX, passwordTextFieldY, passwordTextFieldW, passwordTextFieldH);
    self.passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.passwordTextField.secureTextEntry = YES;
    self.passwordTextField.placeholder = @"密码";
    self.passwordTextField.font = SLFont14;
    
    CGFloat confirmPasswordTextFieldX = passwordTextFieldX;
    CGFloat confirmPasswordTextFieldY = CGRectGetMaxY(self.passwordTextField.frame) + largeMargin;
    CGFloat confirmPasswordTextFieldW = passwordTextFieldW;
    CGFloat confirmPasswordTextFieldH = passwordTextFieldH;
    self.confirmPasswordTextField.frame = CGRectMake(confirmPasswordTextFieldX, confirmPasswordTextFieldY, confirmPasswordTextFieldW, confirmPasswordTextFieldH);
    self.confirmPasswordTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.confirmPasswordTextField.secureTextEntry = YES;
    self.confirmPasswordTextField.placeholder = @"确认密码";
    self.confirmPasswordTextField.font = SLFont14;
    
    self.commitButton.center = CGPointMake(self.confirmPasswordTextField.center.x, CGRectGetMaxY(self.confirmPasswordTextField.frame) + 40 + self.commitButton.frame.size.height * 0.5);
    [self.commitButton addTarget:self action:@selector(commitButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.commitButton.enabled = NO;
}

#pragma mark -----
- (void)commitButtonClick:(SLLoginButton *)commitButton
{
    if ([self.passwordTextField.text isEqualToString:self.confirmPasswordTextField.text]) {
        self.parameters.password = [self.passwordTextField.text MD5];
        NSDictionary *infoDictionary =[[NSBundle mainBundle]infoDictionary];
        self.parameters.clientInfo = [NSString stringWithFormat:@"[ios][理财VIP][%@]", [infoDictionary objectForKey:@"CFBundleVersion"]];
        struct utsname systemInfo;
        uname(&systemInfo);
        NSString *deviceModel = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
        self.parameters.deviceInfo = [NSString stringWithFormat:@"[ios][%@][%@]", [infoDictionary objectForKey:@"CFBundleDisplayName"], deviceModel];
        self.parameters.appCode = @"VIP_IOS";
        
        [SLRegisterTool registerWithParameters:self.parameters success:^(id responseObject) {
            
            SLResult *result = [SLResult objectWithKeyValues:responseObject];
            
            if ([result.code isEqualToString:successStr]) {
                if (result.info.count > 0) {
                    NSDictionary *infoDict = [result.info lastObject];
                    SLAccountInfo *accountInfo = [SLAccountInfo objectWithKeyValues:infoDict];
                    SLAccount *account = [SLAccount objectWithKeyValues:responseObject];
                    account.accountInfo = accountInfo;
                    
                    // 归档账号信息
                    [SLAccountTool saveAccount:account];
                    
                    SLMoreViewController *more = [[SLMoreViewController alloc] init];
                    SLTabBarViewController *tabbar = [SLTabBarViewController sharedTabbarController];
                    for (SLNavigationController *nav in tabbar.viewControllers) {
                        [nav popToRootViewControllerAnimated:YES];
                    }
                    tabbar.selectedIndex = 0;
                    SLSideViewController *sideVC = [[SLSideViewController alloc] initWithContentViewController:tabbar leftMenuViewController:more rightMenuViewController:nil];
                    self.view.window.rootViewController = sideVC;
                    
                    [MBProgressHUD showSuccess:@"注册成功"];
                }
            } else {
                [MBProgressHUD showError:result.msg];
            }
        } failure:^(NSError *error) {
            
        }];
    } else {
        [MBProgressHUD showError:@"您输入的密码不一致"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
