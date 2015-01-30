//
//  SLLoginViewController.m
//  02-pigBank
//
//  Created by 陆承东 on 14-9-16.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "sys/utsname.h"

#import "SLLoginViewController.h"

#import "NSString+Password.h"

#import "MBProgressHUD+MJ.h"
#import "MJExtension.h"
#import "SLSideViewController.h"

#import "SLAccount.h"
#import "SLAccountInfo.h"
#import "SLLoginParameters.h"
#import "SLResult.h"

#import "SLImageView.h"
#import "SLLoginButton.h"
#import "SLInputTextField.h"

#import "SLMoreViewController.h"
#import "SLTabBarViewController.h"
#import "SLNavigationController.h"
#import "SLFindPwdViewController.h"
#import "SLRegisterViewController.h"

#import "SLHttpTool.h"
#import "SLAccountTool.h"
#import "SLLoginTool.h"
#import "SLPlateInfoTool.h"

@interface SLLoginViewController ()<UIAlertViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) SLSideViewController *sideViewController;

@property (nonatomic, weak) SLImageView *logoView;
@property (nonatomic, weak) UILabel *chineseBankNameLabel;
@property (nonatomic, weak) UILabel *englishBankNameLabel;
@property (nonatomic, weak) SLInputTextField *accountTextField;
@property (nonatomic, weak) SLInputTextField *pwdTextField;
@property (nonatomic, weak) SLLoginButton *loginButton;
@property (nonatomic, weak) SLImageView *bottomImageView;

@property (nonatomic, copy) NSString *infoValue;
@property (nonatomic, strong) NSArray *plateInfoListArray;

@end

@implementation SLLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [MBProgressHUD hideHUD];
    
    if ([self.code integerValue] == 9998) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"请重新登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
    }
    
    [[SLTabBarViewController sharedTabbarController] dead];
    
    [self setNavBar];
    
    [self catchRegistType];
}

#pragma mark ----- 获取用户注册方式
- (void)catchRegistType
{
    [SLLoginTool catchRegistTypeWithParameters:nil success:^(SLResult *result) {
        NSString *infoValue = [result.info lastObject][@"infoValue"];
        
        self.infoValue = infoValue;
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark ----- setNavBar设置导航栏属性
- (void)setNavBar
{
    // 设置状态栏颜色为白色同时隐藏
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [UIApplication sharedApplication].statusBarHidden = YES;
    
    // 设置导航栏颜色为红色同时字体为白色同时隐藏
    UINavigationBar *navBar = self.navigationController.navigationBar;
    // 设置背景
    [navBar setBarTintColor:SLRed];
    NSMutableDictionary *attri = [NSMutableDictionary dictionary];
    attri[UITextAttributeTextColor] = SLWhite;
    [navBar setTitleTextAttributes:attri];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // 设置状态栏和导航栏不隐藏
    self.navigationController.navigationBar.hidden = NO;
    [UIApplication sharedApplication].statusBarHidden = NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = SLWhite;
    
    [self addObserver];
    
    [self setupLoginView];
}

#pragma mark ----- 添加监听方法
- (void)addObserver
{
    // 监听文本框文字改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged) name:UITextFieldTextDidChangeNotification object:self.accountTextField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged) name:UITextFieldTextDidChangeNotification object:self.pwdTextField];
}

#pragma mark ----- 设置当前view
- (void)setupLoginView
{
    CGFloat centerX = self.view.frame.size.width * 0.5;
    
    // logoView
    SLImageView *logoView = [SLImageView imageViewWithImageName:@"login_logo"];
    self.logoView = logoView;
    logoView.center = CGPointMake(centerX, 100);
    [self.view addSubview:logoView];
    
    
    // chineseBankNameLabel
    UILabel *chineseBankNameLabel = [[UILabel alloc] init];
    self.chineseBankNameLabel = chineseBankNameLabel;
    CGFloat chineseBankNameLabelX = 0;
    CGFloat chineseBankNameLabelY = CGRectGetMaxY(logoView.frame) + middleMargin;
    CGFloat chineseBankNameLabelW = screenW;
    CGFloat chineseBankNameLabelH = 24;
    chineseBankNameLabel.frame = CGRectMake(chineseBankNameLabelX, chineseBankNameLabelY, chineseBankNameLabelW, chineseBankNameLabelH);
    chineseBankNameLabel.textAlignment = NSTextAlignmentCenter;
    chineseBankNameLabel.font = SLBoldFont24;
    chineseBankNameLabel.text = @"中国银行";
    [self.view addSubview:chineseBankNameLabel];
    
    // englishBankNameLabel
    UILabel *englishBankNameLabel = [[UILabel alloc] init];
    self.englishBankNameLabel = englishBankNameLabel;
    CGFloat englishBankNameLabelX = 0;
    CGFloat englishBankNameLabelY = CGRectGetMaxY(chineseBankNameLabel.frame) + middleMargin;
    CGFloat englishBankNameLabelW = screenW;
    CGFloat englishBankNameLabelH = 24;
    englishBankNameLabel.frame = CGRectMake(englishBankNameLabelX, englishBankNameLabelY, englishBankNameLabelW, englishBankNameLabelH);
    englishBankNameLabel.textAlignment = NSTextAlignmentCenter;
    englishBankNameLabel.font = SLBoldFont24;
    englishBankNameLabel.text = @"BANK OF CHINA";
    [self.view addSubview:englishBankNameLabel];
   
    // 账号输入框
    SLInputTextField *accountTextField = [SLInputTextField inputTextFieldWithLeftViewImage:@"login_mobile"];
    CGFloat accountX = middleMargin;
    CGFloat accountY = CGRectGetMaxY(logoView.frame) + 80;
    CGFloat accountW = screenW - largeMargin;
    CGFloat accountH = 40;
    accountTextField.frame = CGRectMake(accountX, accountY, accountW, accountH);
    accountTextField.borderStyle = UITextBorderStyleRoundedRect;
    accountTextField.placeholder = @"手机号";
    SLAccount *account = [SLAccountTool getAccount];
    if (account) {
        accountTextField.text = account.accountInfo.mobile;
    } else {
    }
    [self.view addSubview:accountTextField];
    self.accountTextField = accountTextField;
    
    // 密码输入框
    SLInputTextField *pwdTextField = [SLInputTextField inputTextFieldWithLeftViewImage:@"password"];
    CGFloat pwdX = accountX;
    CGFloat pwdY = CGRectGetMaxY(accountTextField.frame) + middleMargin;
    CGFloat pwdW = accountW;
    CGFloat pwdH = accountH;
    pwdTextField.frame = CGRectMake(pwdX, pwdY, pwdW, pwdH);
    pwdTextField.borderStyle = UITextBorderStyleRoundedRect;
    pwdTextField.placeholder = @"密码";
    pwdTextField.secureTextEntry = YES;
    pwdTextField.text = @"admin1";
    pwdTextField.delegate = self;
    [self.view addSubview:pwdTextField];
    self.pwdTextField = pwdTextField;
    
    // 登录按钮
    SLLoginButton *loginButton = [SLLoginButton buttonWithTitle:@"登录" backgroundImage:@"login_loginButtonBg_normal" highlightBackgroundImage:@"login_loginButtonBg_highlight"];
    self.loginButton = loginButton;
    loginButton.center = CGPointMake(pwdTextField.center.x, CGRectGetMaxY(pwdTextField.frame) + loginButton.frame.size.height * 0.5 + largeMargin);
    [loginButton addTarget:self action:@selector(loginButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    
    UIButton *registeButton = [[UIButton alloc] init];
    CGFloat registeButtonW = 80;
    CGFloat registeButtonH = 12;
    CGFloat registeButtonX = screenW * 0.5 - registeButtonW - 30;
    CGFloat registeButtonY = CGRectGetMaxY(loginButton.frame) + middleMargin;
    registeButton.frame = CGRectMake(registeButtonX, registeButtonY, registeButtonW, registeButtonH);
    [registeButton setTitle:@"新用户注册" forState:UIControlStateNormal];
    [registeButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [registeButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    registeButton.titleLabel.font = SLFont12;
    [registeButton setImage:[UIImage imageNamed:@"login_register"] forState:UIControlStateNormal];
    [registeButton addTarget:self action:@selector(registeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registeButton];
    
    UIButton *findPwdButton = [[UIButton alloc] init];
    CGFloat findPwdButtonW = 80;
    CGFloat findPwdButtonH = 12;
    CGFloat findPwdButtonX = screenW * 0.5 + 30;
    CGFloat findPwdButtonY = registeButtonY;
    findPwdButton.frame = CGRectMake(findPwdButtonX, findPwdButtonY, findPwdButtonW, findPwdButtonH);
    [findPwdButton setTitle:@"找回密码" forState:UIControlStateNormal];
    [findPwdButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [findPwdButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    findPwdButton.titleLabel.font = SLFont12;
    [findPwdButton setImage:[UIImage imageNamed:@"login_findPwd"] forState:UIControlStateNormal];
    [findPwdButton addTarget:self action:@selector(findPwdButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:findPwdButton];
}

#pragma mark ----- 点击了return的事件
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    
    [self loginButtonClick];
    
    return YES;
}

#pragma mark ----- 登录按钮的网络请求
- (void)loginButtonClick
{
    [MBProgressHUD showMessage:@"登陆中"];
    
    // 创建传递参数
    SLLoginParameters *parameters = [[SLLoginParameters alloc] init];
    parameters.mobile = self.accountTextField.text;
    parameters.password = [self.pwdTextField.text MD5];
    parameters.appCode = @"VIP_IOS";
    NSDictionary *infoDictionary =[[NSBundle mainBundle]infoDictionary];
    parameters.clientInfo = [NSString stringWithFormat:@"[ios][理财VIP][%@]", [infoDictionary objectForKey:@"CFBundleVersion"]];
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceModel = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    parameters.deviceInfo = [NSString stringWithFormat:@"[ios][%@][%@]", [infoDictionary objectForKey:@"CFBundleDisplayName"], deviceModel];
    
    // 请求url
    NSString *url = [SLHttpUrl stringByAppendingString:@"/user/login"];
    
    [SLHttpTool postWithUrlstr:url parameters:parameters.keyValues success:^(id responseObject) {
        
        SLLog(@"%@", responseObject);
        
        NSString *code = responseObject[@"code"];
        
        if ([code isEqualToString:@"0000"]) {
            
            NSDictionary *infoDict = [responseObject[@"info"] lastObject];
            SLAccountInfo *accountInfo = [SLAccountInfo objectWithKeyValues:infoDict];
            SLAccount *account = [SLAccount objectWithKeyValues:responseObject];
            account.accountInfo = accountInfo;
            
            // 归档账号信息
            [SLAccountTool saveAccount:account];
            
            SLMoreViewController *more = [[SLMoreViewController alloc] init];
            SLTabBarViewController *tabbar = [SLTabBarViewController sharedTabbarController];
            for (SLNavigationController *nav in tabbar.viewControllers) {
                [nav popToRootViewControllerAnimated:YES];
                
                [MBProgressHUD hideHUD];
                [MBProgressHUD showSuccess:@"登录成功"];
            }
            tabbar.selectedIndex = 0;
            SLSideViewController *sideVC = [[SLSideViewController alloc] initWithContentViewController:tabbar leftMenuViewController:more rightMenuViewController:nil];
            self.view.window.rootViewController = sideVC;
        } else {
            [MBProgressHUD hideHUD];
            [MBProgressHUD showError:@"账号或密码错误"];
        }
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark ----- textField的监听方法
- (void)textChanged
{
    self.loginButton.enabled = (self.accountTextField.text.length && self.pwdTextField.text.length);
}

#pragma mark ----- 找回密码按钮点击事件
- (void)findPwdButtonClick:(UIButton *)findPwdButton
{
    SLFindPwdViewController *fpvc = [[SLFindPwdViewController alloc] init];
    fpvc.title = @"找回密码";
    [self.navigationController pushViewController:fpvc animated:YES];
}

#pragma mark ----- 注册新用户按钮点击事件
- (void)registeButtonClick:(UIButton *)registeButton
{
    SLRegisterViewController *rvc = [[SLRegisterViewController alloc] init];
    rvc.title = @"注册";
    rvc.infoValue = self.infoValue;
    [self.navigationController pushViewController:rvc animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
