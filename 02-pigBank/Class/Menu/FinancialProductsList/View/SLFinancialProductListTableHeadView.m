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
/** 剩余时间 */
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
    CGFloat buttonH = 29.5;
    CGFloat buttonY = smallMargin;
    CGFloat expectedYieldButtonX = viewW * 0.5 - buttonW;
    CGFloat leftTimeButtonX = viewW * 0.5;
    self.expectedYieldButton.frame = CGRectMake(expectedYieldButtonX, buttonY, buttonW, buttonH);
    self.leftTimeButton.frame = CGRectMake(leftTimeButtonX, buttonY, buttonW, buttonH);
    
    CGFloat viewH = CGRectGetMaxY(self.expectedYieldButton.frame) + smallMargin;
    self.bounds = CGRectMake(0, 0, viewW, viewH);
    
    CGFloat separatorViewW = viewW;
    CGFloat separatorViewH = 0.5;
    CGFloat separatorViewX = 0;
    CGFloat separatorViewY = viewH - separatorViewH;
    CGRect separatorViewF = CGRectMake(separatorViewX, separatorViewY, separatorViewW, separatorViewH);
    UIView *separatorView = [[UIView alloc] initWithFrame:separatorViewF];
    separatorView.backgroundColor = SLLightGray;
    [self addSubview:separatorView];
    
    /** 设置expectedYieldButton数据 */
    [self.expectedYieldButton setTitle:@"预期收益率" forState:UIControlStateNormal];
#warning 设置颜色
    [self.expectedYieldButton setTitleColor:SLRed forState:UIControlStateNormal];
    [self.expectedYieldButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.expectedYieldButton setBackgroundImage:[UIImage resizableImageWithImageName:@"icon_button_left_normal"] forState:UIControlStateNormal];
    [self.expectedYieldButton setBackgroundImage:[UIImage resizableImageWithImageName:@"icon_button_left_selected"] forState:UIControlStateSelected];
    [self.expectedYieldButton addTarget:self action:@selector(expectedYieldButtonClick:) forControlEvents:UIControlEventTouchDown];
    
    /** 设置leftTimeButton数据 */
    [self.leftTimeButton setTitle:@"剩余时间" forState:UIControlStateNormal];
#warning 设置颜色
    [self.leftTimeButton setTitleColor:SLRed forState:UIControlStateNormal];
    [self.leftTimeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.leftTimeButton setBackgroundImage:[UIImage resizableImageWithImageName:@"icon_button_right_normal"] forState:UIControlStateNormal];
    [self.leftTimeButton setBackgroundImage:[UIImage resizableImageWithImageName:@"icon_button_right_selected"] forState:UIControlStateSelected];
    [self.leftTimeButton addTarget:self action:@selector(leftTimeButtonClick:) forControlEvents:UIControlEventTouchDown];
}

/**
 *  expectedYieldButton点击事件
 */
- (void)expectedYieldButtonClick:(UIButton *)expectedYieldButton
{
    self.leftTimeButton.selected = NO;
    self.expectedYieldButton.selected = YES;
    
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
    self.leftTimeButton.selected = YES;
    
    if ([self.delegate respondsToSelector:@selector(financialProductListTableHeadView:didClickLeftTimeButton:)]) {
        [self.delegate financialProductListTableHeadView:self didClickLeftTimeButton:self.leftTimeButton];
        }
}

@end
