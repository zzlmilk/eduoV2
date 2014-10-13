//
//  SLLabelView.m
//  02-pigBank
//
//  Created by 陆承东 on 14-9-20.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLLabelView.h"
#define margin 7

@implementation SLLabelView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        UIView *colorView = [[UIView alloc] init];
        colorView.center = CGPointMake(0, self.center.y);
        colorView.bounds = CGRectMake(0, 0, margin, margin);
        [self addSubview:colorView];
        self.colorView = colorView;
        
        
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(0, 0, 130, smallLabelHeight);
        label.center = CGPointMake(CGRectGetMaxX(colorView.frame) + 3 + label.bounds.size.width * 0.5, self.center.y);
        [self addSubview:label];
        self.label = label;
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
