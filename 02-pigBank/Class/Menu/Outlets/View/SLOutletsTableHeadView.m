//
//  SLOutletsTableHeadView.m
//  02-pigBank
//
//  Created by 陆承东 on 14-10-16.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLOutletsTableHeadView.h"

#import "UIImage+S_LINE.h"

@interface SLOutletsTableHeadView ()

@end

@implementation SLOutletsTableHeadView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        /** serviceItemButton 服务项目 */
        SLRotateButton *serviceItemButton = [[SLRotateButton alloc] init];
        [self addSubview:serviceItemButton];
        self.serviceItemButton = serviceItemButton;
        
        /** serviceAreaButton 服务区域 */
        SLRotateButton *serviceAreaButton = [[SLRotateButton alloc] init];
        [self addSubview:serviceAreaButton];
        self.serviceAreaButton = serviceAreaButton;
        
        [self setupFrames];
    }
    return self;
}

- (void)setupFrames
{
    CGFloat viewW = [UIScreen mainScreen].bounds.size.width;
    
    CGFloat buttonW = 160;
    CGFloat buttonH = 40;
    CGFloat buttonY = 0;
    CGFloat serviceItemButtonX = 0;
    CGFloat serviceAreaButtonX = viewW * 0.5;
    self.serviceItemButton.frame = CGRectMake(serviceItemButtonX, buttonY, buttonW, buttonH);
    self.serviceAreaButton.frame = CGRectMake(serviceAreaButtonX, buttonY, buttonW, buttonH);
    
    CGFloat viewH = buttonH;
    self.bounds = CGRectMake(0, 0, viewW, viewH);
    
    /** 设置serviceItemButton数据 */
    [self.serviceItemButton setTitle:@"服务项目" forState:UIControlStateNormal];
    [self.serviceItemButton setTitleColor:SLColor(126, 33, 128) forState:UIControlStateNormal];
    [self.serviceItemButton setImage:[UIImage imageNamed:@"xiaLa"] forState:UIControlStateNormal];
    [self.serviceItemButton setImage:[UIImage imageNamed:@"xiaLaJiaoHu"] forState:UIControlStateSelected];
    // 背景
//    [self.serviceItemButton setBackgroundImage:[UIImage resizableImageWithImageName:@"xian"] forState:UIControlStateNormal];
    [self.serviceItemButton addTarget:self action:@selector(serviceItemButtonClick:) forControlEvents:UIControlEventTouchDown];
    
    /** 设置serviceAreaButton数据 */
    [self.serviceAreaButton setTitle:@"服务区域" forState:UIControlStateNormal];
    [self.serviceAreaButton setTitleColor:SLColor(126, 33, 128) forState:UIControlStateNormal];
    [self.serviceAreaButton setImage:[UIImage imageNamed:@"xiaLa"] forState:UIControlStateNormal];
    [self.serviceAreaButton setImage:[UIImage imageNamed:@"xiaLaJiaoHu"] forState:UIControlStateSelected];
    // 背景
//    [self.serviceAreaButton setBackgroundImage:[UIImage resizableImageWithImageName:@"xian"] forState:UIControlStateNormal];
    [self.serviceAreaButton addTarget:self action:@selector(serviceAreaButtonClick:) forControlEvents:UIControlEventTouchDown];
}

/**
 *  serviceItemButton点击事件
 */
- (void)serviceItemButtonClick:(UIButton *)serviceItemButton
{
    if (serviceItemButton.selected == YES) {
        serviceItemButton.selected = NO;
    } else {
        serviceItemButton.selected = YES;
        self.serviceAreaButton.selected = NO;
    }
    
    if ([self.delegate respondsToSelector:@selector(outletsTableHeadView:didClickServiceItemButton:)]) {
        [self.delegate outletsTableHeadView:self didClickServiceItemButton:serviceItemButton];
    }
}
/**
 *  serviceAreaButton点击事件
 */
- (void)serviceAreaButtonClick:(UIButton *)serviceAreaButton
{
    if (serviceAreaButton.selected == YES) {
        serviceAreaButton.selected = NO;
    } else {
        serviceAreaButton.selected = YES;
        self.serviceItemButton.selected = NO;
    }
    
    if ([self.delegate respondsToSelector:@selector(outletsTableHeadView:didClickServiceAreaButton:)]) {
        [self.delegate outletsTableHeadView:self didClickServiceAreaButton:serviceAreaButton];
    }
}

@end
