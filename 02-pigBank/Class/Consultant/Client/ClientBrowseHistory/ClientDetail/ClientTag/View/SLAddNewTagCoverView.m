//
//  SLAddNewTagCoverView.m
//  02-pigBank
//
//  Created by 陆承东 on 15/1/26.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import "SLAddNewTagCoverView.h"

#import "MBProgressHUD+MJ.h"

@interface SLAddNewTagCoverView ()

@property (nonatomic, weak) UITextField *tagTextField;

@end

@implementation SLAddNewTagCoverView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 添加所有子控件
        [self addAllSubViews];
        
        self.backgroundColor = [UIColor whiteColor];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)addAllSubViews
{
    CGFloat bgViewW = screenW - largeMargin;
    UIView *bgView = [[UIView alloc] init];
    [self addSubview:bgView];
    
    CGFloat titleLabelX = 0;
    CGFloat titleLabelY = largeMargin;
    CGFloat titleLabelW = bgViewW;
    CGFloat titleLabelH = 20;
    CGRect titleLabelF = CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:titleLabelF];
    titleLabel.text = @"添加标签";
    titleLabel.font = SLFont16;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:titleLabel];
    
    CGFloat tagTextFieldX = middleMargin;
    CGFloat tagTextFieldY = CGRectGetMaxY(titleLabelF) + largeMargin;
    CGFloat tagTextFieldW = titleLabelW - largeMargin;
    CGFloat tagTextFieldH = 30;
    CGRect tagTextFieldF = CGRectMake(tagTextFieldX, tagTextFieldY, tagTextFieldW, tagTextFieldH);
    UITextField *tagTextField = [[UITextField alloc] initWithFrame:tagTextFieldF];
    tagTextField.placeholder = @"10个字以内";
    tagTextField.borderStyle = UITextBorderStyleRoundedRect;
    tagTextField.font = SLFont14;
    self.tagTextField = tagTextField;
    [bgView addSubview:tagTextField];
    
    CGFloat HorizontalSeparatorViewX = 0;
    CGFloat HorizontalSeparatorViewY = CGRectGetMaxY(tagTextFieldF) + largeMargin;
    CGFloat HorizontalSeparatorViewW = bgViewW;
    CGFloat HorizontalSeparatorViewH = 0.5;
    CGRect HorizontalSeparatorViewF = CGRectMake(HorizontalSeparatorViewX, HorizontalSeparatorViewY, HorizontalSeparatorViewW, HorizontalSeparatorViewH);
    UIView *HorizontalSeparatorView = [[UIView alloc] initWithFrame:HorizontalSeparatorViewF];
    HorizontalSeparatorView.backgroundColor = SLLightGray;
    [bgView addSubview:HorizontalSeparatorView];
    
    CGFloat cancelButtonX = 0;
    CGFloat cancelButtonY = CGRectGetMaxY(HorizontalSeparatorViewF);
    CGFloat cancelButtonW = bgViewW * 0.5;
    CGFloat cancelButtonH = tagTextFieldH;
    CGRect cancelButtonF = CGRectMake(cancelButtonX, cancelButtonY, cancelButtonW, cancelButtonH);
    UIButton *cancelButton = [[UIButton alloc] initWithFrame:cancelButtonF];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cancelButton.titleLabel.font = SLFont14;
    [cancelButton addTarget:self action:@selector(cancelButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:cancelButton];
    
    CGFloat verticalSeparatorViewX = CGRectGetMaxX(cancelButtonF);
    CGFloat verticalSeparatorViewY = cancelButtonY;
    CGFloat verticalSeparatorViewW = 0.5;
    CGFloat verticalSeparatorViewH = cancelButtonH;
    CGRect verticalSeparatorViewF = CGRectMake(verticalSeparatorViewX, verticalSeparatorViewY, verticalSeparatorViewW, verticalSeparatorViewH);
    UIView *verticalSeparatorView = [[UIView alloc] initWithFrame:verticalSeparatorViewF];
    verticalSeparatorView.backgroundColor = SLLightGray;
    [bgView addSubview:verticalSeparatorView];
    
    CGFloat commitButtonX = CGRectGetMaxX(verticalSeparatorViewF);
    CGFloat commitButtonY = verticalSeparatorViewY;
    CGFloat commitButtonW = cancelButtonW;
    CGFloat commitButtonH = cancelButtonH;
    CGRect commitButtonF = CGRectMake(commitButtonX, commitButtonY, commitButtonW, commitButtonH);
    UIButton *commitButton = [[UIButton alloc] initWithFrame:commitButtonF];
    [commitButton setTitle:@"确定" forState:UIControlStateNormal];
    [commitButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    commitButton.titleLabel.font = SLFont14;
    [commitButton addTarget:self action:@selector(commitButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:commitButton];
    
    CGFloat bgViewH = CGRectGetMaxY(commitButtonF);
    bgView.bounds = CGRectMake(0, 0, bgViewW, bgViewH);
    bgView.center = self.center;
    bgView.layer.cornerRadius = 5;
    bgView.clipsToBounds = YES;
    bgView.backgroundColor = [UIColor whiteColor];
}

#pragma mark ----- 取消按钮点击事件
- (void)cancelButtonClick:(UIButton *)cancelButton
{
    if ([self.delegate respondsToSelector:@selector(addNewTagCoverView:didClickedCancelButton:)]) {
        [self.delegate addNewTagCoverView:self didClickedCancelButton:cancelButton];
    }
}

#pragma mark ----- 确定按钮点击事件
- (void)commitButtonClick:(UIButton *)commitButton
{
    if (self.tagTextField.text.length > 10) {
        [MBProgressHUD showError:@"输入字符超过10个~"];
    } else if (self.tagTextField.text.length == 0) {
        [MBProgressHUD showError:@"请输入标签描述"];
    } else {
        if ([self.delegate respondsToSelector:@selector(addNewTagCoverView:didClickedCommitButton:withTagStr:)]) {
        [self.delegate addNewTagCoverView:self didClickedCommitButton:commitButton withTagStr:self.tagTextField.text];
        }
    }
}

- (void)tapView:(UITapGestureRecognizer *)tap
{
    SLLog(@"tapView");
}

@end
