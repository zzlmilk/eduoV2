//
//  SLClientToolBar.m
//  02-pigBank
//
//  Created by 陆承东 on 15/1/21.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import "SLClientToolBar.h"

#import "SLAccountTool.h"

@interface SLClientToolBar ()

@property (nonatomic, weak) SLTabBarButton *leftButton;
@property (nonatomic, weak) SLTabBarButton *rightButton;

@property (nonatomic, copy) NSString *userType;

@end

@implementation SLClientToolBar

- (NSString *)userType
{
    if (_userType == nil) {
        _userType = [SLAccountTool getAccount].accountInfo.userType;
    }
    return _userType;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 添加所有子控件
        [self addAllSubViews];
        
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

#pragma mark ----- 添加所有子控件
- (void)addAllSubViews
{
    UIView *separatorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0.5)];
    separatorView.backgroundColor = SLLightGray;
    [self addSubview:separatorView];
    
    SLTabBarButton *leftButton = [[SLTabBarButton alloc] initWithFrame:CGRectMake(0, 0.5, screenW * 0.5, 49)];
    [leftButton setTitle:@"留言" forState:UIControlStateNormal];
    [leftButton setImage:[UIImage imageNamed:@"icon_tabbar_message_normal"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.leftButton = leftButton;
    [self addSubview:leftButton];
    
    UIView *verticalSeparatorView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(leftButton.frame), middleMargin, 0.5, self.frame.size.height - largeMargin)];
    verticalSeparatorView.backgroundColor = SLLightGray;
    [self addSubview:verticalSeparatorView];
    
    SLTabBarButton *rightButton = [[SLTabBarButton alloc] initWithFrame:CGRectMake(screenW * 0.5 + 0.5, 0.5, screenW * 0.5, 49)];
    if ([self.userType isEqualToString:@"3"]) {
        [rightButton setTitle:@"电联" forState:UIControlStateNormal];
        [rightButton setImage:[UIImage imageNamed:@"icon_tabbar_phone_normal"] forState:UIControlStateNormal];
    } else if ([self.userType isEqualToString:@"2"]) {
        [rightButton setTitle:@"客户" forState:UIControlStateNormal];
#pragma mark ----- 设置图片
        [rightButton setImage:[UIImage imageNamed:@"icon_nav_clientDetail_normal"] forState:UIControlStateNormal];
    }
    [rightButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.rightButton = rightButton;
    [self addSubview:rightButton];
}

- (void)setLeftButtonTitle:(NSString *)leftButtonTitle image:(NSString *)imageName
{
    [self.leftButton setTitle:leftButtonTitle forState:UIControlStateNormal];
    [self.leftButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
}
- (void)setRightButtonTitle:(NSString *)rightButtonTitle image:(NSString *)imageName
{
    [self.rightButton setTitle:rightButtonTitle forState:UIControlStateNormal];
    [self.rightButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
}

- (void)rightButtonClick:(SLTabBarButton *)rightButton
{
    SLLog(@"rightButtonClick");
    if ([self.delegate respondsToSelector:@selector(clientToolBar:didClickedRightButton:)]) {
        [self.delegate clientToolBar:self didClickedRightButton:rightButton];
    }
}

- (void)leftButtonClick:(SLTabBarButton *)leftButton
{
    SLLog(@"leftButtonClick");
    if ([self.delegate respondsToSelector:@selector(clientToolBar:didClickedLeftButton:)]) {
        [self.delegate clientToolBar:self didClickedLeftButton:leftButton];
    }
}

@end
