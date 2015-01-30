//
//  SLLoginButton.m
//  02-pigBank
//
//  Created by 陆承东 on 14-9-17.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLLoginButton.h"

@implementation SLLoginButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+ (instancetype)buttonWithTitle:(NSString *)title backgroundImage:(NSString *)backgroundImage highlightBackgroundImage:(NSString *)highlightBackgroundImage
{
    // 根据方法中的title和image设置对应的属性
    SLLoginButton *loginButton = [[SLLoginButton alloc] init];
    [loginButton setTitle:title forState:UIControlStateNormal];
    [loginButton setBackgroundImage:[UIImage imageNamed:backgroundImage] forState:UIControlStateNormal];
    [loginButton setBackgroundImage:[UIImage imageNamed:highlightBackgroundImage] forState:UIControlStateHighlighted];
    loginButton.bounds = CGRectMake(0, 0, loginButton.currentBackgroundImage.size.width, loginButton.currentBackgroundImage.size.height);
    
    return loginButton;
}

+ (instancetype)buttonWithTitle:(NSString *)title
{
    SLLoginButton *loginButton = [[SLLoginButton alloc] init];
    [loginButton setTitle:title forState:UIControlStateNormal];
    
    return loginButton;
}

@end
