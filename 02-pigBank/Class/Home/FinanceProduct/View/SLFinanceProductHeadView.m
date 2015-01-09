//
//  SLFinanceProductHeadView.m
//  02-pigBank
//
//  Created by 陆承东 on 14-9-28.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLFinanceProductHeadView.h"

#import "SLFinanceProduct.h"

@interface SLFinanceProductHeadView()

/** titleLabel */
@property (nonatomic, weak) UILabel *titleLabel;
/** dateLabel */
@property (nonatomic, weak) UILabel *dateLabel;
/** leftTimeLabel */
@property (nonatomic, weak) UILabel *leftTimeLabel;


@end

@implementation SLFinanceProductHeadView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        /**
         *  添加所有子控件
         */
        
    }
    return self;
}

- (void)addAllSubviews
{
    /** titleLabel */
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = SLBoldFont18;
    titleLabel.numberOfLines = 0;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    /** dateLabel */
    UILabel *dateLabel = [[UILabel alloc] init];
    dateLabel.textAlignment = NSTextAlignmentLeft;
    dateLabel.font = SLFont11;
    [self addSubview:dateLabel];
    self.dateLabel = dateLabel;
    
    /** leftTimeLabel */
    UILabel *leftTimeLabel = [[UILabel alloc] init];
    leftTimeLabel.textAlignment = NSTextAlignmentRight;
    leftTimeLabel.font = SLFont11;
    [self addSubview:leftTimeLabel];
    self.leftTimeLabel = leftTimeLabel;
}

- (void)setFinanceProductFrame:(SLFinanceProductFrame *)financeProductFrame
{
    _financeProductFrame = financeProductFrame;
    
    /** titleLabel */
    self.titleLabel.frame = self.financeProductFrame.titleLabelF;
    self.titleLabel.text = self.financeProductFrame.financeProduct.title;
    
    /** dateLabel */
    self.dateLabel.frame = self.financeProductFrame.dateLabelF;
    // 转换时间
    NSDate *date = [NSDate dateWithTimeIntervalSince1970: [self.financeProductFrame.financeProduct.verifyTime longLongValue] / 1000];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy/MM/dd"];
    NSString *dateStr = [dateFormat stringFromDate: date];
    self.dateLabel.text = dateStr;
    
    /** leftTimeLabel */
    self.leftTimeLabel.frame = self.financeProductFrame.leftTimeLabelF;
    self.leftTimeLabel.text = @"剩余时间:42天";
}

@end
