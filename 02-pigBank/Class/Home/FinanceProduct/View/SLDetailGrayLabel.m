//
//  SLDetailGrayLabel.m
//  02-pigBank
//
//  Created by 陆承东 on 14-9-23.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLDetailGrayLabel.h"
#define SLDetailGrayLabelFont [UIFont systemFontOfSize:13]

@implementation SLDetailGrayLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.textColor = [UIColor grayColor];
        self.font = SLDetailGrayLabelFont;
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
