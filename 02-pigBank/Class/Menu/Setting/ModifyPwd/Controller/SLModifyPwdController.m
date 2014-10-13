//
//  SLModifyPwdController.m
//  02-pigBank
//
//  Created by 陆承东 on 14-9-26.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLModifyPwdController.h"

#import "MBProgressHUD+MJ.h"
#import "NSString+Password.h"
#import "SLAccountTool.h"
#import "SLAccount.h"

#import "SLModifyPwdFrame.h"

@interface SLModifyPwdController ()

/** bjView  */
@property (nonatomic, weak) UIView *bjView;
/** topLineView  */
@property (nonatomic, weak) UIView *topLineView;
/** pwdLeftImageView */
@property (nonatomic, weak) UIImageView *oldPwdLeftImageView;
/** pwdTextField */
@property (nonatomic, weak) UITextField *oldPwdTextField;
/** middleUpLineView */
@property (nonatomic, weak) UIView *middleUpLineView;
/** freshMobileLeftImageView */
@property (nonatomic, weak) UIImageView *freshPwdLeftImageView;
/** freshMobileTextField */
@property (nonatomic, weak) UITextField *freshPwdTextField;
/** middleDownLineView */
@property (nonatomic, weak) UIView *middleDownLineView;
/** captchaLeftImageView */
@property (nonatomic, weak) UIImageView *reFreshPwdLeftImageView;
/** captchaTextField */
@property (nonatomic, weak) UITextField *reFreshPwdTextField;
/** bottomLineView  */
@property (nonatomic, weak) UIView *bottomLineView;
/** sureButton */
@property (nonatomic, weak) UIButton *sureButton;

@property (nonatomic, strong) SLModifyPwdFrame *modifyPwdFrame;

@end

@implementation SLModifyPwdController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 添加所有子控件
    [self addAllSubviews];
    
    SLModifyPwdFrame *modifyPwdFrame = [[SLModifyPwdFrame alloc] init];
    modifyPwdFrame.login = 1;
    self.modifyPwdFrame = modifyPwdFrame;
    
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
    
    /** oldPwdLeftImageView */
    UIImageView *oldPwdLeftImageView = [[UIImageView alloc] init];
    [bjView addSubview:oldPwdLeftImageView];
    self.oldPwdLeftImageView = oldPwdLeftImageView;
    
    /** oldPwdTextField */
    UITextField *oldPwdTextField = [[UITextField alloc] init];
    [bjView addSubview:oldPwdTextField];
    self.oldPwdTextField = oldPwdTextField;
    
    /** middleUpLineView */
    UIView *middleUpLineView = [[UIView alloc] init];
    [bjView addSubview:middleUpLineView];
    self.middleUpLineView = middleUpLineView;
    
    /** freshPwdLeftImageView */
    UIImageView *freshPwdLeftImageView = [[UIImageView alloc] init];
    [bjView addSubview:freshPwdLeftImageView];
    self.freshPwdLeftImageView = freshPwdLeftImageView;
    
    /** freshPwdTextField */
    UITextField *freshPwdTextField = [[UITextField alloc] init];
    [bjView addSubview:freshPwdTextField];
    self.freshPwdTextField = freshPwdTextField;
    
    /** middleDownLineView */
    UIView *middleDownLineView = [[UIView alloc] init];
    [bjView addSubview:middleDownLineView];
    self.middleDownLineView = middleDownLineView;
    
    /** reFreshPwdLeftImageView */
    UIImageView *reFreshPwdLeftImageView = [[UIImageView alloc] init];
    [bjView addSubview:reFreshPwdLeftImageView];
    self.reFreshPwdLeftImageView = reFreshPwdLeftImageView;
    
    /** reFreshPwdTextField */
    UITextField *reFreshPwdTextField = [[UITextField alloc] init];
    [bjView addSubview:reFreshPwdTextField];
    self.reFreshPwdTextField = reFreshPwdTextField;
    
    /** bottomLineView  */
    UIView *bottomLineView = [[UIView alloc] init];
    [bjView addSubview:bottomLineView];
    self.bottomLineView = bottomLineView;
    
    /** sureButton */
    UIButton *sureButton = [[UIButton alloc] init];
    [self.view addSubview:sureButton];
    self.sureButton = sureButton;
}

/**
 *  设置子控件的数据
 */
- (void)setupSubviewsData
{
    /** bjView  */
    self.bjView.frame = self.modifyPwdFrame.bjViewF;
    
    /** topLineView  */
    self.topLineView.frame = self.modifyPwdFrame.topLineViewF;
    self.topLineView.backgroundColor = SLColor(177, 177, 177);
    
    /** oldPwdLeftImageView */
    self.oldPwdLeftImageView.frame = self.modifyPwdFrame.oldPwdLeftImageViewF;
    self.oldPwdLeftImageView.image = [UIImage imageNamed:@"shuMiMa"];
    self.oldPwdLeftImageView.contentMode = UIViewContentModeCenter;
    
    /** oldPwdTextField */
    self.oldPwdTextField.frame = self.modifyPwdFrame.oldPwdTextFieldF;
    self.oldPwdTextField.placeholder = @"请输入旧密码";
    self.oldPwdTextField.font = SLFont14;
    self.oldPwdTextField.contentMode = UIViewContentModeCenter;
    
    /** middleUpLineView */
    self.middleUpLineView.frame = self.modifyPwdFrame.middleUpLineViewF;
    self.middleUpLineView.backgroundColor = SLColor(177, 177, 177);
    
    /** freshPwdLeftImageView */
    self.freshPwdLeftImageView.frame = self.modifyPwdFrame.freshPwdLeftImageViewF;
    self.freshPwdLeftImageView.image = [UIImage imageNamed:@"xinMiMa"];
    self.freshPwdLeftImageView.contentMode = UIViewContentModeCenter;
    
    /** freshPwdTextField */
    self.freshPwdTextField.frame = self.modifyPwdFrame.freshPwdTextFieldF;
    self.freshPwdTextField.placeholder = @"请输入新密码";
    self.freshPwdTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.freshPwdTextField.font = SLFont14;
    self.freshPwdTextField.contentMode = UIViewContentModeCenter;
    
    /** middleDownLineView */
    self.middleDownLineView.frame = self.modifyPwdFrame.middleDownLineViewF;
    self.middleDownLineView.backgroundColor = SLColor(177, 177, 177);
    
    /** reFreshPwdLeftImageView */
    self.reFreshPwdLeftImageView.frame = self.modifyPwdFrame.reFreshPwdLeftImageViewF;
    self.reFreshPwdLeftImageView.image = [UIImage imageNamed:@"queRenMiMa"];
    self.reFreshPwdLeftImageView.contentMode = UIViewContentModeCenter;
    
    /** reFreshPwdTextField */
    self.reFreshPwdTextField.frame = self.modifyPwdFrame.reFreshPwdTextFieldF;
    self.reFreshPwdTextField.placeholder = @"确认新密码";
    self.reFreshPwdTextField.font = SLFont14;
    self.reFreshPwdTextField.contentMode = UIViewContentModeCenter;
    
    /** bottomLineView  */
    self.bottomLineView.frame = self.modifyPwdFrame.bottomLineViewF;
    self.bottomLineView.backgroundColor = SLColor(177, 177, 177);
    
    /** sureButton */
    self.sureButton.frame = self.modifyPwdFrame.sureButtonF;
    [self.sureButton setTitle:@"确定" forState:UIControlStateNormal];
    [self.sureButton setBackgroundImage:[UIImage imageNamed:@"anNiuZhuCe"] forState:UIControlStateNormal];
    [self.sureButton setBackgroundImage:[UIImage imageNamed:@"anNiuZhuCeJiaoHu"] forState:UIControlStateHighlighted];
    [self.sureButton addTarget:self action:@selector(sureButtonClick:) forControlEvents:UIControlEventTouchUpInside];
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
    // oldpwd:String/用户旧密码（MD5加密后）
    paraments[@"oldpwd"] = [self.oldPwdTextField.text MD5];
    // password:String/用户密码（MD5加密后）
    paraments[@"password"] = [self.reFreshPwdTextField.text MD5];
    // uid:Long/当前登录用户UID
    paraments[@"uid"] = [NSNumber numberWithInteger:account.uid];
    // token:String/当前登录用户身份识别码（登陆、注册接口返回该值）
    paraments[@"token"] = account.token;
    
    // 发送请求
    [mgr POST:@"http://117.79.93.100:8013/data2.0/ds/user/changePwdByOldPwd" parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        SLLog(@"%@", responseObject);
        
        /*
         0000：接口业务调用成功
         9999：接口业务调用失败
         9998：登陆信息验证失败
         9001：用户不存在
         9006：旧密码输入错误
         9018：新密码格式错误
         */
        if ([responseObject[@"code"] isEqualToString:@"0000"]) {
            [MBProgressHUD showSuccess:@"密码修改成功"];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        SLLog(@"请求失败");
    }];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
