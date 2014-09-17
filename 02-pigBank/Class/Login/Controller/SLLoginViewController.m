//
//  SLLoginViewController.m
//  02-pigBank
//
//  Created by 陆承东 on 14-9-16.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLLoginViewController.h"
#import "AFNetworking.h"
#import "NSString+Password.h"
#import "SLAccount.h"
#import "SLTabBarController.h"
#import "MBProgressHUD+MJ.h"
#import "SLAccountTool.h"
#import "SLImageView.h"
#import "SLLoginButton.h"
#import "SLInputTextField.h"
#import "MJExtension.h"

@interface SLLoginViewController ()

@property (nonatomic, weak) UITextField *accountTextField;
@property (nonatomic, weak) UITextField *pwdTextField;

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupLoginView];
}

- (void)setupLoginView
{
    CGFloat centerX = self.view.frame.size.width * 0.5;
    
    // logoView
    SLImageView *logoView = [SLImageView imageViewWithImageName:@"logo"];
    logoView.center = CGPointMake(centerX, 100);
    [self.view addSubview:logoView];
    
    
    // vipLogoView
    SLImageView *vipLogoView = [SLImageView imageViewWithImageName:@"vipLogo"];
    vipLogoView.center = CGPointMake(centerX, logoView.center.y + logoView.frame.size.height + 10);
    [self.view addSubview:vipLogoView];
    
    
    // 账号和密码输入框
    SLImageView *loginRectView = [SLImageView imageViewWithImageName:@"loginRect"];
    loginRectView.bounds = CGRectMake(0, 0, loginRectView.frame.size.width, 80);
    loginRectView.center = CGPointMake(centerX, vipLogoView.center.y + vipLogoView.frame.size.height + 30);
    [self.view addSubview:loginRectView];
   
    // 账号输入框
    SLInputTextField *accountTextField = [SLInputTextField inputTextFieldWithLeftViewImage:@"account"];
    CGFloat accountX = loginRectView.frame.origin.x;
    CGFloat accountY = loginRectView.frame.origin.y;
    CGFloat accountW = loginRectView.frame.size.width;
    CGFloat accountH = loginRectView.frame.size.height * 0.5;
    accountTextField.frame = CGRectMake(accountX, accountY, accountW, accountH);
    accountTextField.placeholder = @"请输入账号";
    accountTextField.text = @"18121253011";
    [self.view addSubview:accountTextField];
    self.accountTextField = accountTextField;
    
    // 密码输入框
    SLInputTextField *pwdTextField = [SLInputTextField inputTextFieldWithLeftViewImage:@"password"];
    CGFloat pwdX = loginRectView.frame.origin.x;
    CGFloat pwdY = loginRectView.frame.origin.y + loginRectView.frame.size.height * 0.5;
    CGFloat pwdW = loginRectView.frame.size.width;
    CGFloat pwdH = loginRectView.frame.size.height * 0.5;
    pwdTextField.frame = CGRectMake(pwdX, pwdY, pwdW, pwdH);
    pwdTextField.placeholder = @"请输入密码";
    pwdTextField.secureTextEntry = YES;
    pwdTextField.text = @"admin1";
    [self.view addSubview:pwdTextField];
    self.pwdTextField = pwdTextField;
    
    
    // 登录按钮
    SLLoginButton *loginButton = [SLLoginButton buttonWithTitle:@"登录" backgroundImage:@"loginBtn" highlightBackgroundImage:@"loginBtnPress"];
    loginButton.center = CGPointMake(centerX, loginRectView.center.y + loginRectView.frame.size.height + 30);
    [loginButton addTarget:self action:@selector(loginButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    
    
    // 底部背景
    SLImageView *bottomImageView = [SLImageView imageViewWithImageName:@"bjLogin"];
    bottomImageView.center = CGPointMake(centerX, self.view.frame.size.height - bottomImageView.frame.size.height * 0.5);
    [self.view addSubview:bottomImageView];
    
}

#pragma - 登录按钮的网络请求
- (void)loginButtonClick
{
    // 创建请求管理对象
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 封装请求参数
    NSMutableDictionary *paraments = [NSMutableDictionary dictionary];
    paraments[@"mobile"] = self.accountTextField.text;
    NSString *password = [self.pwdTextField.text MD5];
    paraments[@"password"] = password;
    
    // 发送请求
    [mgr POST:@"http://117.79.93.100:8013/data2.0/ds/user/login" parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // 将字典转为模型
        SLAccount *account = [SLAccount objectWithKeyValues:responseObject];
        
        // 归档
        [SLAccountTool saveAccount:account];
        
        if ([account.msg isEqualToString:@"登陆成功"]) {
            self.view.window.rootViewController = [[SLTabBarController alloc] init];
        } else {
            [MBProgressHUD showError:@"账号或密码错误"];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        SLLog(@"请求失败");
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
