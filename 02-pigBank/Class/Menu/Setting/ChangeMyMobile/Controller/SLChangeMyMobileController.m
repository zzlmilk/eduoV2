//
//  SLChangeMyMobileController.m
//  02-pigBank
//
//  Created by 陆承东 on 14-9-26.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLChangeMyMobileController.h"
#import "AFNetworking.h"

#import "SLAccount.h"
#import "SLAccountTool.h"
#import "SLChangeMyMobileFrame.h"

#define lingNumber 4

@interface SLChangeMyMobileController ()

/** bjView  */
@property (nonatomic, weak) UIView *bjView;
/** topLineView  */
@property (nonatomic, weak) UIView *topLineView;
/** pwdLeftImageView */
@property (nonatomic, weak) UIImageView *pwdLeftImageView;
/** pwdTextField */
@property (nonatomic, weak) UITextField *pwdTextField;
/** middleUpLineView */
@property (nonatomic, weak) UIView *middleUpLineView;
/** freshMobileLeftImageView */
@property (nonatomic, weak) UIImageView *freshMobileLeftImageView;
/** freshMobileTextField */
@property (nonatomic, weak) UITextField *freshMobileTextField;
/** middleDownLineView */
@property (nonatomic, weak) UIView *middleDownLineView;
/** captchaLeftImageView */
@property (nonatomic, weak) UIImageView *captchaLeftImageView;
/** captchaTextField */
@property (nonatomic, weak) UITextField *captchaTextField;
/** getCaptchaButton */
@property (nonatomic, weak) UIButton *getCaptchaButton;
/** bottomLineView  */
@property (nonatomic, weak) UIView *bottomLineView;
/** sureButton */
@property (nonatomic, weak) UIButton *sureButton;

@property (nonatomic, strong) SLChangeMyMobileFrame *changeMyMobileFrame;

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 添加所有子控件
    [self addAllSubviews];
    
    SLChangeMyMobileFrame *changeMyMobileFrame = [[SLChangeMyMobileFrame alloc] init];
    changeMyMobileFrame.login = 1;
    self.changeMyMobileFrame = changeMyMobileFrame;
    
    // 加载子控件数据
    [self setupSubviewsData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  添加所有子控件
 */
- (void)addAllSubviews
{
    // 添加输入部分整体的view
    UIView *bjView = [[UIView alloc] init];
    [self.view addSubview:bjView];
    self.bjView = bjView;
    
    /** topLineView  */
    UIView *topLineView = [[UIView alloc] init];
    [bjView addSubview:topLineView];
    self.topLineView = topLineView;
    
    /** pwdLeftImageView */
    UIImageView *pwdLeftImageView = [[UIImageView alloc] init];
    [bjView addSubview:pwdLeftImageView];
    self.pwdLeftImageView = pwdLeftImageView;
    
    /** pwdTextField */
    UITextField *pwdTextField = [[UITextField alloc] init];
    [bjView addSubview:pwdTextField];
    self.pwdTextField = pwdTextField;
    
    /** middleUpLineView */
    UIView *middleUpLineView = [[UIView alloc] init];
    [bjView addSubview:middleUpLineView];
    self.middleUpLineView = middleUpLineView;
    
    /** freshMobileLeftImageView */
    UIImageView *freshMobileLeftImageView = [[UIImageView alloc] init];
    [bjView addSubview:freshMobileLeftImageView];
    self.freshMobileLeftImageView = freshMobileLeftImageView;
    
    /** freshMobileTextField */
    UITextField *freshMobileTextField = [[UITextField alloc] init];
    [bjView addSubview:freshMobileTextField];
    self.freshMobileTextField = freshMobileTextField;
    
    /** middleDownLineView */
    UIView *middleDownLineView = [[UIView alloc] init];
    [bjView addSubview:middleDownLineView];
    self.middleDownLineView = middleDownLineView;
    
    /** captchaLeftImageView */
    UIImageView *captchaLeftImageView = [[UIImageView alloc] init];
    [bjView addSubview:captchaLeftImageView];
    self.captchaLeftImageView = captchaLeftImageView;
    
    /** captchaTextField */
    UITextField *captchaTextField = [[UITextField alloc] init];
    [bjView addSubview:captchaTextField];
    self.captchaTextField = captchaTextField;
    
    /** getCaptchaButton */
    UIButton *getCaptchaButton = [[UIButton alloc] init];
    [bjView addSubview:getCaptchaButton];
    self.getCaptchaButton = getCaptchaButton;
    
    /** bottomLineView  */
    UIView *bottomLineView = [[UIView alloc] init];
    [bjView addSubview:bottomLineView];
    self.bottomLineView = bottomLineView;
    
    /** sureButton */
    UIButton *sureButton = [[UIButton alloc] init];
    [self.view addSubview:sureButton];
    self.sureButton = sureButton;
}

- (void)setupSubviewsData
{
    /** bjView  */
    self.bjView.frame = self.changeMyMobileFrame.bjViewF;
    
    /** topLineView  */
    self.topLineView.frame = self.changeMyMobileFrame.topLineViewF;
    self.topLineView.backgroundColor = SLColor(177, 177, 177);
    
    /** pwdLeftView */
    self.pwdLeftImageView.frame = self.changeMyMobileFrame.pwdLeftImageViewF;
    self.pwdLeftImageView.image = [UIImage imageNamed:@"shuMiMa"];
    self.pwdLeftImageView.contentMode = UIViewContentModeCenter;
    
    /** pwdTextField */
    self.pwdTextField.frame = self.changeMyMobileFrame.pwdTextFieldF;
    self.pwdTextField.placeholder = @"请输入密码";
    self.pwdTextField.font = SLFont14;
    self.pwdTextField.contentMode = UIViewContentModeCenter;
    
    /** middleUpLineView */
    self.middleUpLineView.frame = self.changeMyMobileFrame.middleUpLineViewF;
    self.middleUpLineView.backgroundColor = SLColor(177, 177, 177);
    
    /** freshMobileLeftImageView */
    self.freshMobileLeftImageView.frame = self.changeMyMobileFrame.freshMobileLeftImageViewF;
    self.freshMobileLeftImageView.image = [UIImage imageNamed:@"shouJiHao"];
    self.freshMobileLeftImageView.contentMode = UIViewContentModeCenter;
    
    /** freshMobileTextField */
    self.freshMobileTextField.frame = self.changeMyMobileFrame.freshMobileTextFieldF;
    self.freshMobileTextField.placeholder = @"新手机号码";
    self.freshMobileTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.freshMobileTextField.font = SLFont14;
    self.freshMobileTextField.contentMode = UIViewContentModeCenter;
    
    /** middleDownLineView */
    self.middleDownLineView.frame = self.changeMyMobileFrame.middleDownLineViewF;
    self.middleDownLineView.backgroundColor = SLColor(177, 177, 177);
    
    /** captchaLeftImageView */
    self.captchaLeftImageView.frame = self.changeMyMobileFrame.captchaLeftImageViewF;
    self.captchaLeftImageView.image = [UIImage imageNamed:@"yanZhengMa"];
    self.captchaLeftImageView.contentMode = UIViewContentModeCenter;
    
    /** captchaTextField */
    self.captchaTextField.frame = self.changeMyMobileFrame.captchaTextFieldF;
    self.captchaTextField.placeholder = @"验证码";
    self.captchaTextField.font = SLFont14;
    self.captchaTextField.contentMode = UIViewContentModeCenter;
    
    /** getCaptchaButton */
    self.getCaptchaButton.frame = self.changeMyMobileFrame.getCaptchaButtonF;
    [self.getCaptchaButton setBackgroundImage:[UIImage imageNamed:@"weiHuoQu"] forState:UIControlStateNormal];
    [self.getCaptchaButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    self.getCaptchaButton.titleLabel.font = SLFont14;
    [self.getCaptchaButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.getCaptchaButton addTarget:self action:@selector(getCaptchaButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    /** bottomLineView  */
    self.bottomLineView.frame = self.changeMyMobileFrame.bottomLineViewF;
    self.bottomLineView.backgroundColor = SLColor(177, 177, 177);
    
    /** sureButton */
    self.sureButton.frame = self.changeMyMobileFrame.sureButtonF;
    [self.sureButton setTitle:@"确定" forState:UIControlStateNormal];
    [self.sureButton setBackgroundImage:[UIImage imageNamed:@"anNiuZhuCe"] forState:UIControlStateNormal];
    [self.sureButton setBackgroundImage:[UIImage imageNamed:@"anNiuZhuCeJiaoHu"] forState:UIControlStateHighlighted];
    [self.sureButton addTarget:self action:@selector(sureButtonClick:) forControlEvents:UIControlEventTouchUpInside];
}

/**
 *  获取验证码的按钮事件
 */
- (void)getCaptchaButtonClick:(UIButton *)getCaptchaButton
{
    // 创建请求管理对象
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 封装请求参数
    NSMutableDictionary *paraments = [NSMutableDictionary dictionary];
    paraments[@"mobile"] = self.freshMobileTextField.text;
    
    // 发送请求
    [mgr POST:@"http://117.79.93.100:8013/data2.0/ds/sms/sendVercode" parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        SLLog(@"%@", responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        SLLog(@"请求失败");
    }];
}

/**
 *  确定按钮事件
 */
- (void)sureButtonClick:(UIButton *)sureButton
{
    // 创建请求管理对象
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 获取账户信息
    SLAccount *account = [SLAccountTool getAccount];
    
    // 封装请求参数
    NSMutableDictionary *paraments = [NSMutableDictionary dictionary];
    // password:String/用户密码（MD5加密后）
    paraments[@"password"] = self.pwdTextField.text;
    // mobile:String/新手机号码
    paraments[@"mobile"] = self.freshMobileTextField.text;
    // vercode:String/验证码（新手机号码的验证码）
    paraments[@"vercode"] = self.captchaTextField.text;
    // uid:Long/当前登录用户UID
    paraments[@"uid"] = [NSNumber numberWithInteger:account.uid];
    // token:String/当前登录用户身份识别码（登陆、注册接口返回该值）
    paraments[@"token"] = account.token;
    
    // 发送请求
    [mgr POST:@"http://117.79.93.100:8013/data2.0/ds/user/changeUserMobile" parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        SLLog(@"%@", responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        SLLog(@"请求失败");
    }];
}

@end
