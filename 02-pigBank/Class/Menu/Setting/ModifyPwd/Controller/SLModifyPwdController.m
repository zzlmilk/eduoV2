//
//  SLModifyPwdController.m
//  02-pigBank
//
//  Created by 陆承东 on 14-9-26.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLModifyPwdController.h"

#import "SLAccount.h"

#import "SLBackButton.h"
#import "SLInputTextField.h"
#import "SLLoginButton.h"

#import "SLAccountTool.h"
#import "SLModifyTool.h"

#import "NSString+Password.h"

@interface SLModifyPwdController ()

@property (nonatomic, weak) SLInputTextField *oldPwdTextField;
@property (nonatomic, weak) SLInputTextField *freshPwdTextField;
@property (nonatomic, weak) SLInputTextField *confirmPwdTextField;
@property (nonatomic, weak) SLLoginButton *commitButton;

@end

@implementation SLModifyPwdController

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
    
    [self addObserver];
}

#pragma mark ----- 添加监听方法
- (void)addObserver
{
    // 监听文本框文字改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged) name:UITextFieldTextDidChangeNotification object:self.oldPwdTextField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged) name:UITextFieldTextDidChangeNotification object:self.freshPwdTextField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged) name:UITextFieldTextDidChangeNotification object:self.confirmPwdTextField];
}

- (void)textChanged
{
    self.commitButton.enabled = self.oldPwdTextField.text.length && self.freshPwdTextField.text.length && self.confirmPwdTextField.text.length;
}

#pragma mark ----- 添加所有子控件
- (void)addAllSubviews
{
    SLInputTextField *oldPwdTextField = [SLInputTextField inputTextFieldWithLeftViewImage:@"icon_image_oldPwd"];
    CGFloat oldPwdTextFieldX = middleMargin;
    CGFloat oldPwdTextFieldY = largeMargin + 64;
    CGFloat oldPwdTextFieldW = screenW - largeMargin;
    CGFloat oldPwdTextFieldH = 30;
    CGRect oldPwdTextFieldF = CGRectMake(oldPwdTextFieldX, oldPwdTextFieldY, oldPwdTextFieldW, oldPwdTextFieldH);
    oldPwdTextField.frame = oldPwdTextFieldF;
    oldPwdTextField.borderStyle = UITextBorderStyleRoundedRect;
    oldPwdTextField.placeholder = @"请输入旧密码";
    oldPwdTextField.secureTextEntry = YES;
    oldPwdTextField.font = SLFont14;
    self.oldPwdTextField = oldPwdTextField;
    [self.view addSubview:oldPwdTextField];
    
    SLInputTextField *freshPwdTextField = [SLInputTextField inputTextFieldWithLeftViewImage:@"icon_image_newPwd"];
    CGFloat freshPwdTextFieldX = oldPwdTextFieldX;
    CGFloat freshPwdTextFieldY = CGRectGetMaxY(oldPwdTextFieldF) + largeMargin;
    CGFloat freshPwdTextFieldW = oldPwdTextFieldW;
    CGFloat freshPwdTextFieldH = oldPwdTextFieldH;
    CGRect freshPwdTextFieldF = CGRectMake(freshPwdTextFieldX, freshPwdTextFieldY, freshPwdTextFieldW, freshPwdTextFieldH);
    freshPwdTextField.frame = freshPwdTextFieldF;
    freshPwdTextField.borderStyle = UITextBorderStyleRoundedRect;
    freshPwdTextField.placeholder = @"请输入新密码";
    freshPwdTextField.secureTextEntry = YES;
    freshPwdTextField.font = SLFont14;
    self.freshPwdTextField = freshPwdTextField;
    [self.view addSubview:freshPwdTextField];
    
    SLInputTextField *confirmPwdTextField = [SLInputTextField inputTextFieldWithLeftViewImage:@"icon_image_confirmPwd"];
    CGFloat confirmPwdTextFieldX = freshPwdTextFieldX;
    CGFloat confirmPwdTextFieldY = CGRectGetMaxY(freshPwdTextFieldF) + largeMargin;
    CGFloat confirmPwdTextFieldW = freshPwdTextFieldW;
    CGFloat confirmPwdTextFieldH = freshPwdTextFieldH;
    CGRect confirmPwdTextFieldF = CGRectMake(confirmPwdTextFieldX, confirmPwdTextFieldY, confirmPwdTextFieldW, confirmPwdTextFieldH);
    confirmPwdTextField.frame = confirmPwdTextFieldF;
    confirmPwdTextField.borderStyle = UITextBorderStyleRoundedRect;
    confirmPwdTextField.placeholder = @"确认新密码";
    confirmPwdTextField.secureTextEntry = YES;
    confirmPwdTextField.font = SLFont14;
    self.confirmPwdTextField = confirmPwdTextField;
    [self.view addSubview:confirmPwdTextField];
    
    SLLoginButton *commitButton = [SLLoginButton buttonWithTitle:@"确定" backgroundImage:@"login_loginButtonBg_normal" highlightBackgroundImage:@"login_loginButtonBg_highlight"];
    CGFloat commitButtonX = confirmPwdTextFieldX;
    CGFloat commitButtonY = CGRectGetMaxY(confirmPwdTextFieldF) + largeMargin;
    CGFloat commitButtonW = confirmPwdTextFieldW;
    CGFloat commitButtonH = confirmPwdTextFieldH;
    CGRect commitButtonF = CGRectMake(commitButtonX, commitButtonY, commitButtonW, commitButtonH);
    commitButton.frame = commitButtonF;
    [commitButton addTarget:self action:@selector(commitButtonClidk:) forControlEvents:UIControlEventTouchUpInside];
    commitButton.enabled = NO;
    self.commitButton = commitButton;
    [self.view addSubview:commitButton];
}

#pragma mark ----- 确定按钮点击事件
- (void)commitButtonClidk:(SLLoginButton *)commitButton
{
    if ([self.freshPwdTextField.text isEqualToString:self.confirmPwdTextField.text]) {
        SLModifyPwdParameters *parameters = [SLModifyPwdParameters parameters];
        parameters.oldpwd = [self.oldPwdTextField.text MD5];
        parameters.password = [self.freshPwdTextField.text MD5];
        
        [SLModifyTool modifyPasswordWithParameters:parameters success:^(SLResult *result) {
            
            if ([result.code isEqualToString:@"0000"]) {
                [MBProgressHUD showSuccess:@"密码修改成功"];
            } else {
                [MBProgressHUD showError:result.msg];
            }
            
        } failure:^(NSError *error) {
            
        }];
    } else {
        [MBProgressHUD showError:@"您输入的密码不一致"];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
