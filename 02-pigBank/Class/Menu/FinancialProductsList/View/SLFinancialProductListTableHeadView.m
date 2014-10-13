//
//  SLFinancialProductListTableHeadView.m
//  02-pigBank
//
//  Created by 陆承东 on 14-9-29.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLFinancialProductListTableHeadView.h"

#import "UIImage+S_LINE.h"

@interface SLFinancialProductListTableHeadView()

/** 预期收益率 */
@property (nonatomic, weak) UIButton *expectedYieldButton;
/** 预期收益率 */
@property (nonatomic, weak) UIButton *leftTimeButton;

@end

@implementation SLFinancialProductListTableHeadView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        /** 预期收益率 */
        UIButton *expectedYieldButton = [[UIButton alloc] init];
        [self addSubview:expectedYieldButton];
        self.expectedYieldButton = expectedYieldButton;
        
        /** 预期收益率 */
        UIButton *leftTimeButton = [[UIButton alloc] init];
        [self addSubview:leftTimeButton];
        self.leftTimeButton = leftTimeButton;
        
        [self setupFrames];
        
        [self expectedYieldButtonClick:self.expectedYieldButton];
    }
    return self;
}

- (void)setupFrames
{
    CGFloat viewW = [UIScreen mainScreen].bounds.size.width;
    
    CGFloat buttonW = 150;
    CGFloat buttonH = 30;
    CGFloat buttonY = smallMargin;
    CGFloat expectedYieldButtonX = viewW * 0.5 - buttonW;
    CGFloat leftTimeButtonX = viewW * 0.5;
    self.expectedYieldButton.frame = CGRectMake(expectedYieldButtonX, buttonY, buttonW, buttonH);
    self.leftTimeButton.frame = CGRectMake(leftTimeButtonX, buttonY, buttonW, buttonH);
    
    CGFloat viewH = CGRectGetMaxY(self.expectedYieldButton.frame) + smallMargin;
    self.bounds = CGRectMake(0, 0, viewW, viewH);
    
    /** 设置expectedYieldButton数据 */
    [self.expectedYieldButton setTitle:@"预期收益率" forState:UIControlStateNormal];
    [self.expectedYieldButton setTitleColor:SLColor(126, 33, 128) forState:UIControlStateNormal];
    [self.expectedYieldButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.expectedYieldButton setBackgroundImage:[UIImage resizableImageWithImageName:@"zuoKuang"] forState:UIControlStateNormal];
    [self.expectedYieldButton setBackgroundImage:[UIImage resizableImageWithImageName:@"zuoKuangJiaoHu"] forState:UIControlStateSelected];
    [self.expectedYieldButton addTarget:self action:@selector(expectedYieldButtonClick:) forControlEvents:UIControlEventTouchDown];
    
    /** 设置leftTimeButton数据 */
    [self.leftTimeButton setTitle:@"剩余时间" forState:UIControlStateNormal];
    [self.leftTimeButton setTitleColor:SLColor(126, 33, 128) forState:UIControlStateNormal];
    [self.leftTimeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.leftTimeButton setBackgroundImage:[UIImage resizableImageWithImageName:@"youKuang"] forState:UIControlStateNormal];
    [self.leftTimeButton setBackgroundImage:[UIImage resizableImageWithImageName:@"youKuangJiaoHu"] forState:UIControlStateSelected];
    [self.leftTimeButton addTarget:self action:@selector(leftTimeButtonClick:) forControlEvents:UIControlEventTouchDown];
}

/**
 *  expectedYieldButton点击事件
 */
- (void)expectedYieldButtonClick:(UIButton *)expectedYieldButton
{
    self.leftTimeButton.selected = NO;
    [self.leftTimeButton setTitleColor:SLColor(126, 33, 128) forState:UIControlStateNormal];
    self.expectedYieldButton.selected = YES;
    [self.expectedYieldButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    
    if ([self.delegate respondsToSelector:@selector(financialProductListTableHeadView:didClickExpectedYieldButton:)]) {
        [self.delegate financialProductListTableHeadView:self didClickExpectedYieldButton:self.expectedYieldButton];
    }
}
/**
 *  leftTimeButton点击事件
 */
- (void)leftTimeButtonClick:(UIButton *)leftTimeButton
{
    self.expectedYieldButton.selected = NO;
    [self.expectedYieldButton setTitleColor:SLColor(126, 33, 128) forState:UIControlStateNormal];
    self.leftTimeButton.selected = YES;
    [self.leftTimeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    
    if ([self.delegate respondsToSelector:@selector(financialProductListTableHeadView:didClickLeftTimeButton:)]) {
        [self.delegate financialProductListTableHeadView:self didClickLeftTimeButton:self.leftTimeButton];
        }
}

@end
