//
//  SLActivitySignCoverView.m
//  02-pigBank
//
//  Created by 陆承东 on 15/1/22.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import "SLActivitySignCoverView.h"

#import "UIImage+S_LINE.h"
#import "MBProgressHUD+MJ.h"

@interface SLActivitySignCoverView ()

@property (nonatomic, weak) UIView *backView;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UIButton *cancelButton;
@property (nonatomic, weak) UITextField *nameTextField;
@property (nonatomic, weak) UITextField *mobileTextField;
@property (nonatomic, weak) UIButton *commitButton;

@end

@implementation SLActivitySignCoverView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 添加所有子控件
        [self addAllSubViews];
        self.backgroundColor = SLColorRGBA(0, 0, 0, 0.5);
    }
    return self;
}

/**
 *  添加所有子控件
 */
- (void)addAllSubViews
{
    /** backView */
    CGFloat backViewW = screenW - largeMargin;
    UIView *backView = [[UIView alloc] init];
    
    /** coverView */
    CGFloat titleLabelW = backViewW;
    CGFloat titleLabelH = 30;
    CGFloat titleLabelX = 0;
    CGFloat titleLabelY = 0;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH)];
    titleLabel.backgroundColor = SLRed;
    titleLabel.font = SLFont18;
    titleLabel.contentMode = UIViewContentModeCenter;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"填写报名信息";
    titleLabel.userInteractionEnabled = YES;
    self.titleLabel = titleLabel;
    [backView addSubview:titleLabel];
    
    CGFloat cancelButtonW = titleLabelH;
    CGFloat cancelButtonH = cancelButtonW;
    CGFloat cancelButtonX = backViewW - cancelButtonW;
    CGFloat cancelButtonY = 0;
    UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(cancelButtonX, cancelButtonY, cancelButtonW, cancelButtonH)];
    [cancelButton setImage:[UIImage imageNamed:@"icon_button_cancel_normal"] forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.titleLabel = titleLabel;
    [titleLabel addSubview:cancelButton];
    
    CGFloat nameTextFieldX = middleMargin;
    CGFloat nameTextFieldY = CGRectGetMaxY(titleLabel.frame) + largeMargin;
    CGFloat nameTextFieldW = backViewW - largeMargin;
    CGFloat nameTextFieldH = 30;
    UITextField *nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(nameTextFieldX, nameTextFieldY, nameTextFieldW, nameTextFieldH)];
    nameTextField.borderStyle = UITextBorderStyleRoundedRect;
    nameTextField.font = SLFont14;
    nameTextField.placeholder = @"请输入姓名";
    self.nameTextField = nameTextField;
    [backView addSubview:nameTextField];
    
    CGFloat mobileTextFieldX = nameTextFieldX;
    CGFloat mobileTextFieldY = CGRectGetMaxY(nameTextField.frame) + largeMargin;
    CGFloat mobileTextFieldW = nameTextFieldW;
    CGFloat mobileTextFieldH = nameTextFieldH;
    UITextField *mobileTextField = [[UITextField alloc] initWithFrame:CGRectMake(mobileTextFieldX, mobileTextFieldY, mobileTextFieldW, mobileTextFieldH)];
    mobileTextField.borderStyle = UITextBorderStyleRoundedRect;
    mobileTextField.font = SLFont14;
    mobileTextField.placeholder = @"请输入手机";
    self.mobileTextField = mobileTextField;
    [backView addSubview:mobileTextField];
    
    CGFloat commitButtonX = mobileTextFieldX;
    CGFloat commitButtonY = CGRectGetMaxY(mobileTextField.frame) + largeMargin;
    CGFloat commitButtonW = mobileTextFieldW;
    CGFloat commitButtonH = mobileTextFieldH;
    UIButton *commitButton = [[UIButton alloc] initWithFrame:CGRectMake(commitButtonX, commitButtonY, commitButtonW, commitButtonH)];
    [commitButton setTitle:@"确定" forState:UIControlStateNormal];
    [commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [commitButton setBackgroundImage:[UIImage resizableImageWithImageName:@"login_loginButtonBg_normal"] forState:UIControlStateNormal];
    [commitButton setBackgroundImage:[UIImage resizableImageWithImageName:@"login_loginButtonBg_highlight"] forState:UIControlStateSelected];
    [commitButton addTarget:self action:@selector(commitButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.commitButton = commitButton;
    [backView addSubview:commitButton];
    
    CGFloat backViewH = CGRectGetMaxY(commitButton.frame) + largeMargin;
    backView.bounds = CGRectMake(0, 0, backViewW, backViewH);
    CGPoint backViewCenter = CGPointMake(screenW * 0.5, screenH * 0.5);
    backView.center = backViewCenter;
    backView.backgroundColor = [UIColor whiteColor];
    self.backView = backView;
    [self addSubview:backView];
}

#pragma mark ----- 取消按钮点击事件
- (void)cancelButtonClick:(UIButton *)cancelButton
{
    if ([self.delegate respondsToSelector:@selector(activitySignCoverView:didClickedCancelButton:)]) {
        [self.delegate activitySignCoverView:self didClickedCancelButton:cancelButton];
    }
}

#pragma mark ----- 确定按钮点击事件
- (void)commitButtonClick:(UIButton *)commitButton
{
    if (self.mobileTextField.text.length == 11) {
        if ([self.delegate respondsToSelector:@selector(activitySignCoverView:didClickedCommitButton:withName:mobile:)]) {
            
            [MBProgressHUD showMessage:@"报名中..."];
            
            [self.delegate activitySignCoverView:self didClickedCommitButton:commitButton withName:self.nameTextField.text mobile:self.mobileTextField.text];
        }
    } else {
        [MBProgressHUD showError:@"请检查输入的手机号码是否正确~"];
    }
    
}

@end
