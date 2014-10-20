//
//  SLVipChildTableHeadView.m
//  02-pigBank
//
//  Created by 陆承东 on 14-10-15.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLVipChildTableHeadView.h"

#import "UIImage+S_LINE.h"

@interface SLVipChildTableHeadView()

/** 本地 */
@property (nonatomic, weak) UIButton *localButton;
/** 全国 */
@property (nonatomic, weak) UIButton *nationwideButton;

@end

@implementation SLVipChildTableHeadView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        /** 本地 */
        UIButton *localButton = [[UIButton alloc] init];
        [self addSubview:localButton];
        self.localButton = localButton;
        
        /** 全国 */
        UIButton *nationwideButton = [[UIButton alloc] init];
        [self addSubview:nationwideButton];
        self.nationwideButton = nationwideButton;
        
        [self setupFrames];
        
        [self localButtonClick:self.localButton];
    }
    return self;
}

- (void)setupFrames
{
    CGFloat viewW = [UIScreen mainScreen].bounds.size.width;
    
    CGFloat buttonW = 150;
    CGFloat buttonH = 30;
    CGFloat buttonY = smallMargin;
    CGFloat localButtonX = viewW * 0.5 - buttonW;
    CGFloat nationwideButtonX = viewW * 0.5;
    self.localButton.frame = CGRectMake(localButtonX, buttonY, buttonW, buttonH);
    self.nationwideButton.frame = CGRectMake(nationwideButtonX, buttonY, buttonW, buttonH);
    
    CGFloat viewH = CGRectGetMaxY(self.localButton.frame) + smallMargin;
    self.bounds = CGRectMake(0, 0, viewW, viewH);
    
    /** 设置localButton数据 */
    [self.localButton setTitle:@"本地" forState:UIControlStateNormal];
    [self.localButton setTitleColor:SLColor(126, 33, 128) forState:UIControlStateNormal];
    [self.localButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.localButton setBackgroundImage:[UIImage resizableImageWithImageName:@"zuoKuang"] forState:UIControlStateNormal];
    [self.localButton setBackgroundImage:[UIImage resizableImageWithImageName:@"zuoKuangJiaoHu"] forState:UIControlStateSelected];
    [self.localButton addTarget:self action:@selector(localButtonClick:) forControlEvents:UIControlEventTouchDown];
    
    /** 设置nationwideButton数据 */
    [self.nationwideButton setTitle:@"全国" forState:UIControlStateNormal];
    [self.nationwideButton setTitleColor:SLColor(126, 33, 128) forState:UIControlStateNormal];
    [self.nationwideButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.nationwideButton setBackgroundImage:[UIImage resizableImageWithImageName:@"youKuang"] forState:UIControlStateNormal];
    [self.nationwideButton setBackgroundImage:[UIImage resizableImageWithImageName:@"youKuangJiaoHu"] forState:UIControlStateSelected];
    [self.nationwideButton addTarget:self action:@selector(nationwideButtonClick:) forControlEvents:UIControlEventTouchDown];
}

/**
 *  localButton点击事件
 */
- (void)localButtonClick:(UIButton *)localButton
{
    self.nationwideButton.selected = NO;
    [self.nationwideButton setTitleColor:SLColor(126, 33, 128) forState:UIControlStateNormal];
    self.localButton.selected = YES;
    [self.localButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    
    if ([self.delegate respondsToSelector:@selector(vipChildTableHeadView:didClickLocalButton:)]) {
        [self.delegate vipChildTableHeadView:self didClickLocalButton:self.localButton];
    }
}
/**
 *  nationwideButton点击事件
 */
- (void)nationwideButtonClick:(UIButton *)nationwideButton
{
    self.localButton.selected = NO;
    [self.localButton setTitleColor:SLColor(126, 33, 128) forState:UIControlStateNormal];
    self.nationwideButton.selected = YES;
    [self.nationwideButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    
    if ([self.delegate respondsToSelector:@selector(vipChildTableHeadView:didClickNationwideButton:)]) {
        [self.delegate vipChildTableHeadView:self didClickNationwideButton:self.nationwideButton];
    }
}

@end
