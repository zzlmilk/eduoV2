//
//  SLBackButton.m
//  02-pigBank
//
//  Created by 陆承东 on 15/1/14.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import "SLBackButton.h"

@implementation SLBackButton

+ (instancetype)button
{
    SLBackButton *backButton = [[SLBackButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [backButton setImage:[UIImage imageNamed:@"fanHui"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"fanHuiJiaoHu"] forState:UIControlStateHighlighted];
    
    return backButton;
}

@end
