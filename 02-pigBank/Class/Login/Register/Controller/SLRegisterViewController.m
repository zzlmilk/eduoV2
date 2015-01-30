//
//  SLRegisterViewController.m
//  02-pigBank
//
//  Created by 陆承东 on 15/1/20.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import "SLRegisterViewController.h"

#import "SLMessageParameters.h"

#import "SLWhiteBackButton.h"
#import "SLInputTextField.h"
#import "SLLoginButton.h"

#import "SLRegisterNextViewController.h"

#import "SLMessageTool.h"
#import "SLRegisterTool.h"

#import "UIImage+S_LINE.h"

#import "CardIO.h"

@interface SLRegisterViewController ()<CardIOPaymentViewControllerDelegate>

@property (nonatomic, weak) SLInputTextField *nameTextField;
@property (nonatomic, weak) SLInputTextField *cardTextField;
@property (nonatomic, weak) SLInputTextField *mobileTextField;
@property (nonatomic, weak) SLInputTextField *securityCodeTextField;
@property (nonatomic, weak) UIButton *confirmButton;
@property (nonatomic, weak) SLInputTextField *inviteCodeTextField;
@property (nonatomic, weak) UIButton *agreeItemsButton;
@property (nonatomic, weak) UIButton *readItemsButton;
@property (nonatomic, weak) SLLoginButton *commitButton;

@property (nonatomic, assign) int time;

@end

@implementation SLRegisterViewController

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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged) name:UITextFieldTextDidChangeNotification object:self.nameTextField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged) name:UITextFieldTextDidChangeNotification object:self.cardTextField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged) name:UITextFieldTextDidChangeNotification object:self.mobileTextField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged) name:UITextFieldTextDidChangeNotification object:self.securityCodeTextField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged) name:UITextFieldTextDidChangeNotification object:self.inviteCodeTextField];
}

#pragma mark ----- textField的监听方法
- (void)textChanged
{
    if ([self.infoValue isEqualToString:@"2"]) {
        self.commitButton.enabled = (self.nameTextField.text.length && self.cardTextField.text.length && self.mobileTextField.text.length && self.securityCodeTextField.text.length && self.inviteCodeTextField.text.length);
    } else {
        self.commitButton.enabled = (self.nameTextField.text.length && self.cardTextField.text.length && self.mobileTextField.text.length && self.securityCodeTextField.text.length);
    }
}

#pragma mark ----- addSubviews添加所有子控件
- (void)addSubviews
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    SLInputTextField *nameTextField = [SLInputTextField inputTextFieldWithLeftViewImage:@"register_name"];
    self.nameTextField = nameTextField;
    [self.view addSubview:nameTextField];
    
    SLInputTextField *cardTextField = [SLInputTextField inputTextFieldWithLeftViewImage:@"register_card"];
    self.cardTextField = cardTextField;
    [self.view addSubview:cardTextField];
    
    UIButton *camera = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 35, 28)];
    [camera setImage:[UIImage imageNamed:@"icon_button_camera_normal"] forState:UIControlStateNormal];
    [camera addTarget:self action:@selector(cameraClick:) forControlEvents:UIControlEventTouchUpInside];
    cardTextField.rightView = camera;
    cardTextField.rightViewMode = UITextFieldViewModeAlways;
    
    SLInputTextField *mobileTextField = [SLInputTextField inputTextFieldWithLeftViewImage:@"register_mobile"];
    self.mobileTextField = mobileTextField;
    [self.view addSubview:mobileTextField];
    
    SLInputTextField *securityCodeTextField = [SLInputTextField inputTextFieldWithLeftViewImage:@"register_securityCode"];
    self.securityCodeTextField = securityCodeTextField;
    [self.view addSubview:securityCodeTextField];
    
    UIButton *confirmButton = [[UIButton alloc] init];
    self.confirmButton = confirmButton;
    securityCodeTextField.rightView = confirmButton;
    securityCodeTextField.rightViewMode = UITextFieldViewModeAlways;
    
    SLInputTextField *inviteCodeTextField = [SLInputTextField inputTextFieldWithLeftViewImage:@"register_inviteCode"];
    self.inviteCodeTextField = inviteCodeTextField;
    [self.view addSubview:inviteCodeTextField];
    
    UIButton *agreeItemsButton = [[UIButton alloc] init];
    self.agreeItemsButton = agreeItemsButton;
    [self.view addSubview:agreeItemsButton];
    
    UIButton *readItemsButton = [[UIButton alloc] init];
    self.readItemsButton = readItemsButton;
    [self.view addSubview:readItemsButton];
    
    SLLoginButton *commitButton = [SLLoginButton buttonWithTitle:@"下一步" backgroundImage:@"login_loginButtonBg_normal" highlightBackgroundImage:@"login_loginButtonBg_highlight"];
    self.commitButton = commitButton;
    self.commitButton.enabled = NO;
    [self.view addSubview: commitButton];
    
    [self setSubviewsData];
}

- (void)cameraClick:(UIButton *)camera
{
    CardIOPaymentViewController *scanViewController = [[CardIOPaymentViewController alloc] initWithPaymentDelegate:self];
    scanViewController.collectCVV = NO;
    scanViewController.collectExpiry = NO;
    scanViewController.hideCardIOLogo = YES;
    scanViewController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self presentViewController:scanViewController animated:YES completion:nil];
}

#pragma mark - CardIOPaymentViewControllerDelegate
- (void)userDidProvideCreditCardInfo:(CardIOCreditCardInfo *)info inPaymentViewController:(CardIOPaymentViewController *)paymentViewController {
    [self dismissViewControllerAnimated:YES completion:nil];
    
    self.cardTextField.text = info.cardNumber;
}

- (void)userDidCancelPaymentViewController:(CardIOPaymentViewController *)paymentViewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark ----- 设置子控件数据
- (void)setSubviewsData
{
    CGFloat nameTextFieldX = middleMargin;
    CGFloat nameTextFieldY = 64 + largeMargin;
    CGFloat nameTextFieldW = screenW - largeMargin;
    CGFloat nameTextFieldH = 30;
    self.nameTextField.frame = CGRectMake(nameTextFieldX, nameTextFieldY, nameTextFieldW, nameTextFieldH);
    self.nameTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.nameTextField.placeholder = @"姓名";
    self.nameTextField.font = SLFont14;
    
    CGFloat cardTextFieldX = nameTextFieldX;
    CGFloat cardTextFieldY = CGRectGetMaxY(self.nameTextField.frame) + largeMargin;
    CGFloat cardTextFieldW = nameTextFieldW;
    CGFloat cardTextFieldH = nameTextFieldH;
    self.cardTextField.frame = CGRectMake(cardTextFieldX, cardTextFieldY, cardTextFieldW, cardTextFieldH);
    self.cardTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.cardTextField.placeholder = @"卡号";
    self.cardTextField.font = SLFont14;
    
    CGFloat mobileTextFieldX = cardTextFieldX;
    CGFloat mobileTextFieldY = CGRectGetMaxY(self.cardTextField.frame) + largeMargin;
    CGFloat mobileTextFieldW = cardTextFieldW;
    CGFloat mobileTextFieldH = cardTextFieldH;
    self.mobileTextField.frame = CGRectMake(mobileTextFieldX, mobileTextFieldY, mobileTextFieldW, mobileTextFieldH);
    self.mobileTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.mobileTextField.placeholder = @"手机号";
    self.mobileTextField.font = SLFont14;
    
    CGFloat securityCodeTextFieldX = mobileTextFieldX;
    CGFloat securityCodeTextFieldY = CGRectGetMaxY(self.mobileTextField.frame) + largeMargin;
    CGFloat securityCodeTextFieldW = mobileTextFieldW;
    CGFloat securityCodeTextFieldH = mobileTextFieldH;
    self.securityCodeTextField.frame = CGRectMake(securityCodeTextFieldX, securityCodeTextFieldY, securityCodeTextFieldW, securityCodeTextFieldH);
    self.securityCodeTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.securityCodeTextField.placeholder = @"验证码";
    self.securityCodeTextField.font = SLFont14;
    
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
    
    CGFloat agreeItemsButtonY;
    
    if ([self.infoValue isEqualToString:@"2"]) {
        CGFloat inviteCodeTextFieldX = securityCodeTextFieldX;
        CGFloat inviteCodeTextFieldY = CGRectGetMaxY(self.securityCodeTextField.frame) + largeMargin;
        CGFloat inviteCodeTextFieldW = securityCodeTextFieldW;
        CGFloat inviteCodeTextFieldH = securityCodeTextFieldH;
        self.inviteCodeTextField.frame = CGRectMake(inviteCodeTextFieldX, inviteCodeTextFieldY, inviteCodeTextFieldW, inviteCodeTextFieldH);
        self.inviteCodeTextField.borderStyle = UITextBorderStyleRoundedRect;
        self.inviteCodeTextField.placeholder = @"邀请码";
        self.inviteCodeTextField.font = SLFont14;
        
        agreeItemsButtonY = CGRectGetMaxY(self.inviteCodeTextField.frame) + middleMargin;
    } else {
        self.inviteCodeTextField.hidden = YES;
        agreeItemsButtonY = CGRectGetMaxY(self.securityCodeTextField.frame) + middleMargin;
    }
    
    CGFloat agreeItemsButtonX = securityCodeTextFieldX + smallMargin;
    CGFloat agreeItemsButtonW = 13;
    CGFloat agreeItemsButtonH = agreeItemsButtonW;
    self.agreeItemsButton.frame = CGRectMake(agreeItemsButtonX, agreeItemsButtonY, agreeItemsButtonW, agreeItemsButtonH);
    [self.agreeItemsButton setImage:[UIImage imageNamed:@"register_agree_not"] forState:UIControlStateNormal];
    [self.agreeItemsButton setImage:[UIImage imageNamed:@"register_agree_yes"] forState:UIControlStateSelected];
    [self.agreeItemsButton addTarget:self action:@selector(agreeItemsButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.agreeItemsButton.selected = YES;
    
    CGFloat readItemsButtonX = CGRectGetMaxX(self.agreeItemsButton.frame) + smallMargin;
    CGFloat readItemsButtonY = agreeItemsButtonY;
    CGFloat readItemsButtonW = 170;
    CGFloat readItemsButtonH = agreeItemsButtonH;
    self.readItemsButton.frame = CGRectMake(readItemsButtonX, readItemsButtonY, readItemsButtonW, readItemsButtonH);
    [self.readItemsButton setTitle:@"已阅读并同意试用条款和隐私策略" forState:UIControlStateNormal];
    [self.readItemsButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.readItemsButton.titleLabel.font = SLFont11;
    self.readItemsButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.readItemsButton addTarget:self action:@selector(readItemsButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.commitButton.center = CGPointMake(self.securityCodeTextField.center.x, CGRectGetMaxY(self.agreeItemsButton.frame) + largeMargin + self.commitButton.frame.size.height * 0.5);
    [self.commitButton addTarget:self action:@selector(commitButtonClick:) forControlEvents:UIControlEventTouchUpInside];
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

#pragma mark ----- 同意条款复选框按钮点击事件
- (void)agreeItemsButtonClick:(UIButton *)agreeItemsButton
{
    if (self.agreeItemsButton.selected == YES) {
        self.agreeItemsButton.selected = NO;
    } else {
        self.agreeItemsButton.selected = YES;
    }
}

- (void)readItemsButtonClick:(UIButton *)readItemsButton
{
#warning 条款浏览页未完成
}

#pragma mark ----- 下一步按钮点击事件
- (void)commitButtonClick:(SLLoginButton *)commitButton
{
    if (self.agreeItemsButton.selected == YES) {
        SLRegisterBaseParameters *parameters = [SLRegisterBaseParameters parameters];
        parameters.name = self.nameTextField.text;
        parameters.mobile = self.mobileTextField.text;
        parameters.vercode = self.securityCodeTextField.text;
        parameters.cardNo = self.cardTextField.text;
        
        [SLRegisterTool registerBaseWithParameters:parameters success:^(SLResult *result) {
            if ([result.code isEqualToString:@"0000"]) {
                SLRegisterNextViewController *rnvc = [[SLRegisterNextViewController alloc] init];
                rnvc.parameters = parameters;
                [self.navigationController pushViewController:rnvc animated:YES];
            } else {
                [MBProgressHUD showError:result.msg];
            }
        } failure:^(NSError *error) {
            
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
