//
//  SLWhiteBackButton.m
//  02-pigBank
//
//  Created by 陆承东 on 15/1/20.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import "SLWhiteBackButton.h"

@implementation SLWhiteBackButton

+ (instancetype)button
{
    SLWhiteBackButton *backButton = [[SLWhiteBackButton alloc] initWithFrame:CGRectMake(0, 0, 21, 21)];
    [backButton setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    
    return backButton;
}

@end
