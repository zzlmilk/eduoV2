//
//  SLFinancialLabel.m
//  02-pigBank
//
//  Created by 陆承东 on 14-9-27.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLFinancialLabel.h"

@implementation SLFinancialLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.font = SLFont13;
        self.numberOfLines = 1;
    }
    return self;
}

@end
