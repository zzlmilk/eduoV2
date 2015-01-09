//
//  SLPraiseButton.m
//  02-pigBank
//
//  Created by 陆承东 on 15/1/8.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import "SLPraiseButton.h"

#import "SLUserOperateTool.h"
#import "SLMerchantOperateTool.h"

#import "MBProgressHUD+MJ.h"

@interface SLPraiseButton ()

@property (nonatomic, strong) NSNumber *merchantId;
@property (nonatomic, strong) NSNumber *materialId;
@property (nonatomic, strong) NSNumber *praiseCounts;
@property (nonatomic, strong) NSNumber *praiseFlag;

@end

@implementation SLPraiseButton

+ (instancetype)button
{
    SLPraiseButton *button = [[SLPraiseButton alloc] initWithFrame:CGRectMake(0, 0, 40, 42)];
    
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

- (void)setMaterialId:(NSNumber *)materialId praiseCounts:(NSNumber *)praiseCounts praiseFlag:(NSNumber *)praiseFlag
{
    self.materialId = materialId;
    self.praiseCounts = praiseCounts;
    self.praiseFlag = praiseFlag;
    
    [self setMaterialData];
}

- (void)setMaterialId:(NSNumber *)materialId praiseFlag:(NSNumber *)praiseFlag
{
    self.materialId = materialId;
    self.praiseFlag = praiseFlag;
    
    [self setMaterialData];
}

- (void)setMerchantId:(NSNumber *)merchantId praiseCounts:(NSNumber *)praiseCounts praiseFlag:(NSNumber *)praiseFlag
{
    self.merchantId = merchantId;
    self.praiseCounts = praiseCounts;
    self.praiseFlag = praiseFlag;
    
    [self setMaterialData];
}
- (void)setMerchantId:(NSNumber *)merchantId praiseFlag:(NSNumber *)praiseFlag
{
    self.merchantId = merchantId;
    self.praiseFlag = praiseFlag;
    
    [self setMaterialData];
}

- (void)setMaterialData
{
    if (self.praiseCounts == nil) {
        self.bounds = CGRectMake(0, 0, 25, 42);
    } else {
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font = SLFont14;
        self.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        [self setTitle:[NSString stringWithFormat:@"%@", self.praiseCounts] forState:UIControlStateNormal];
    }
    [self setImage:[UIImage imageNamed:@"zan"] forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:@"zanJiaoHu"] forState:UIControlStateSelected];
    if (self.materialId) {
        [self addTarget:self action:@selector(praiseButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    } else {
        [self addTarget:self action:@selector(praiseButtonClickMerchant:) forControlEvents:UIControlEventTouchUpInside];
    }
    int praiseFlag = [self.praiseFlag intValue];
    if (praiseFlag == 1) {
        self.selected = YES;
    } else {
        self.selected = NO;
    }
}

- (void)praiseButtonClick:(UIButton *)praiseButton
{
    // 创建网络参数
    SLUserOperateParameters *parameters = [SLUserOperateParameters parameters];
    parameters.operateType = @"praise";
    parameters.materialId = self.materialId;
    
    if (praiseButton.selected == YES) {
        praiseButton.selected = NO;
        if (self.praiseCounts == nil) {
        } else {
            long praiseCounts = [self.praiseCounts longValue];
            praiseCounts -= 1;
            self.praiseCounts = [NSNumber numberWithLong:praiseCounts];
            [praiseButton setTitle:[NSString stringWithFormat:@"%@", self.praiseCounts] forState:UIControlStateNormal];
        }
        
        parameters.operateValue = @"0";
        [SLUserOperateTool userOperateWithParameters:parameters success:^(NSArray *vipStatusFrameArray) {
            [MBProgressHUD showSuccess:@"取消赞成功"];
        } failure:^(NSError *error) {
            [MBProgressHUD showError:@"取消赞失败"];
            praiseButton.selected = YES;
        }];
    } else {
        praiseButton.selected = YES;
        if (self.praiseCounts == nil) {
        } else {
            long praiseCounts = [self.praiseCounts longValue];
            praiseCounts += 1;
            self.praiseCounts = [NSNumber numberWithLong:praiseCounts];
            [praiseButton setTitle:[NSString stringWithFormat:@"%@", self.praiseCounts] forState:UIControlStateSelected];
        }
        
        parameters.operateValue = @"1";
        [SLUserOperateTool userOperateWithParameters:parameters success:^(NSArray *vipStatusFrameArray) {
            [MBProgressHUD showSuccess:@"赞成功"];
        } failure:^(NSError *error) {
            [MBProgressHUD showError:@"赞失败"];
            praiseButton.selected = NO;
        }];
    }
}

- (void)praiseButtonClickMerchant:(UIButton *)praiseButton
{
    // 创建网络参数
    SLUserOperateParameters *parameters = [SLUserOperateParameters parameters];
    parameters.operateType = @"praise";
    parameters.merchantId = self.merchantId;
    
    if (praiseButton.selected == YES) {
        praiseButton.selected = NO;
        if (self.praiseCounts == nil) {
        } else {
            long praiseCounts = [self.praiseCounts longValue];
            praiseCounts -= 1;
            self.praiseCounts = [NSNumber numberWithLong:praiseCounts];
            [praiseButton setTitle:[NSString stringWithFormat:@"%@", self.praiseCounts] forState:UIControlStateNormal];
        }
        
        parameters.operateValue = @"0";
        [SLMerchantOperateTool userOperateWithParameters:parameters success:^(NSArray *vipStatusFrameArray) {
            [MBProgressHUD showSuccess:@"取消赞成功"];
        } failure:^(NSError *error) {
            [MBProgressHUD showError:@"取消赞失败"];
            praiseButton.selected = YES;
        }];
    } else {
        praiseButton.selected = YES;
        if (self.praiseCounts == nil) {
        } else {
            long praiseCounts = [self.praiseCounts longValue];
            praiseCounts += 1;
            self.praiseCounts = [NSNumber numberWithLong:praiseCounts];
            [praiseButton setTitle:[NSString stringWithFormat:@"%@", self.praiseCounts] forState:UIControlStateSelected];
        }
        
        parameters.operateValue = @"1";
        [SLMerchantOperateTool userOperateWithParameters:parameters success:^(NSArray *vipStatusFrameArray) {
            [MBProgressHUD showSuccess:@"赞成功"];
        } failure:^(NSError *error) {
            [MBProgressHUD showError:@"赞失败"];
            praiseButton.selected = NO;
        }];
    }
}

@end
