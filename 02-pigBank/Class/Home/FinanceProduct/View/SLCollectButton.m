//
//  SLCollectButton.m
//  02-pigBank
//
//  Created by 陆承东 on 15/1/8.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import "SLCollectButton.h"

#import "SLUserOperateTool.h"
#import "SLMerchantOperateTool.h"

#import "MBProgressHUD+MJ.h"

@interface SLCollectButton ()

@property (nonatomic, strong) NSNumber *merchantId;
@property (nonatomic, strong) NSNumber *materialId;
@property (nonatomic, strong) NSNumber *collectCounts;
@property (nonatomic, strong) NSNumber *collectFlag;

@end

@implementation SLCollectButton

+ (instancetype)button
{
    SLCollectButton *button = [[SLCollectButton alloc] initWithFrame:CGRectMake(0, 0, 40, 42)];
    
    return button;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setMaterialId:(NSNumber *)materialId collectCounts:(NSNumber *)collectCounts collectFlag:(NSNumber *)collectFlag
{
    self.materialId = materialId;
    self.collectCounts = collectCounts;
    self.collectFlag = collectFlag;
    
    [self setData];
}

- (void)setMerchantId:(NSNumber *)merchantId collectCounts:(NSNumber *)collectCounts collectFlag:(NSNumber *)collectFlag
{
    self.merchantId = merchantId;
    self.collectCounts = collectCounts;
    self.collectFlag = collectFlag;
    
    [self setData];
}

- (void)setMerchantId:(NSNumber *)merchantId collectFlag:(NSNumber *)collectFlag
{
    self.merchantId = merchantId;
    self.collectFlag = collectFlag;
    
    [self setData];
}


- (void)setMaterialId:(NSNumber *)materialId collectFlag:(NSNumber *)collectFlag
{
    self.materialId = materialId;
    self.collectFlag = collectFlag;
    
    [self setData];
}

- (void)setData
{
    if (self.collectCounts == nil) {
        self.bounds = CGRectMake(0, 0, 25, 42);
    } else {
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font = SLFont14;
        self.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        [self setTitle:[NSString stringWithFormat:@"%@", self.collectCounts] forState:UIControlStateNormal];
    }
    [self setImage:[UIImage imageNamed:@"shouCang"] forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:@"shouCangJiaoHu"] forState:UIControlStateSelected];
    if (self.materialId) {
        [self addTarget:self action:@selector(collectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    } else {
        [self addTarget:self action:@selector(collectButtonClickMerchant:) forControlEvents:UIControlEventTouchUpInside];
    }
    int collectFlag = [self.collectFlag intValue];
    if (collectFlag == 1) {
        self.selected = YES;
    } else {
        self.selected = NO;
    }
}

- (void)collectButtonClick:(UIButton *)collectButton
{
    // 创建网络参数
    SLUserOperateParameters *parameters = [SLUserOperateParameters parameters];
    parameters.operateType = @"collect";
    parameters.materialId = self.materialId;
    
    if (collectButton.selected == YES) {
        collectButton.selected = NO;
        if (self.collectCounts == nil) {
        } else {
            long collectCounts = [self.collectCounts longValue];
            collectCounts -= 1;
            self.collectCounts = [NSNumber numberWithLong:collectCounts];
            [collectButton setTitle:[NSString stringWithFormat:@"%@", self.collectCounts] forState:UIControlStateNormal];
        }
        
        parameters.operateValue = @"0";
        [SLUserOperateTool userOperateWithParameters:parameters success:^(NSArray *vipStatusFrameArray) {
            [MBProgressHUD showSuccess:@"取消收藏成功"];
        } failure:^(NSError *error) {
            [MBProgressHUD showError:@"取消收藏失败"];
            collectButton.selected = YES;
        }];
        
    } else {
        collectButton.selected = YES;
        if (self.collectCounts == nil) {
        } else {
            long collectCounts = [self.collectCounts longValue];
            collectCounts += 1;
            self.collectCounts = [NSNumber numberWithLong:collectCounts];
            [collectButton setTitle:[NSString stringWithFormat:@"%@", self.collectCounts] forState:UIControlStateSelected];
        }
        
        parameters.operateValue = @"1";
        [SLUserOperateTool userOperateWithParameters:parameters success:^(NSArray *vipStatusFrameArray) {
            [MBProgressHUD showSuccess:@"收藏成功"];
        } failure:^(NSError *error) {
            [MBProgressHUD showError:@"收藏失败"];
            collectButton.selected = NO;
        }];
    }
}

- (void)collectButtonClickMerchant:(UIButton *)collectButton
{
    // 创建网络参数
    SLUserOperateParameters *parameters = [SLUserOperateParameters parameters];
    parameters.operateType = @"collect";
    parameters.merchantId = self.merchantId;
    
    if (collectButton.selected == YES) {
        collectButton.selected = NO;
        if (self.collectCounts == nil) {
        } else {
            long collectCounts = [self.collectCounts longValue];
            collectCounts -= 1;
            self.collectCounts = [NSNumber numberWithLong:collectCounts];
            [collectButton setTitle:[NSString stringWithFormat:@"%@", self.collectCounts] forState:UIControlStateNormal];
        }
        
        parameters.operateValue = @"0";
        [SLMerchantOperateTool userOperateWithParameters:parameters success:^(NSArray *vipStatusFrameArray) {
            [MBProgressHUD showSuccess:@"取消收藏成功"];
        } failure:^(NSError *error) {
            [MBProgressHUD showError:@"取消收藏失败"];
            collectButton.selected = YES;
        }];
        
    } else {
        collectButton.selected = YES;
        if (self.collectCounts == nil) {
        } else {
            long collectCounts = [self.collectCounts longValue];
            collectCounts += 1;
            self.collectCounts = [NSNumber numberWithLong:collectCounts];
            [collectButton setTitle:[NSString stringWithFormat:@"%@", self.collectCounts] forState:UIControlStateSelected];
        }
        
        parameters.operateValue = @"1";
        [SLMerchantOperateTool userOperateWithParameters:parameters success:^(NSArray *vipStatusFrameArray) {
            [MBProgressHUD showSuccess:@"收藏成功"];
        } failure:^(NSError *error) {
            [MBProgressHUD showError:@"收藏失败"];
            collectButton.selected = NO;
        }];
    }
}

@end
