//
//  SLBadgeButton.m
//  02-pigBank
//
//  Created by 陆承东 on 14-9-15.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLBadgeButton.h"
#import "UIImage+S_LINE.h"

@implementation SLBadgeButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundImage:[UIImage resizableImageWithImageName:@"tiShi"] forState:UIControlStateNormal];
        self.contentMode = UIViewContentModeCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:13];
        self.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        self.userInteractionEnabled = NO;
        
        CGFloat badgeX = 0;
        CGFloat badgeY = 0;
        CGFloat badgeW = self.currentBackgroundImage.size.width;
        CGFloat badgeH = self.currentBackgroundImage.size.height;
        self.frame = CGRectMake(badgeX, badgeY, badgeW, badgeH);
        self.hidden = YES;
    }
    return self;
}

- (void)setBadgeValue:(NSString *)badgeValue
{
    if (badgeValue) {
        self.hidden = NO;
        
        
        CGFloat badgeY = 0;
        CGFloat badgeW = self.currentBackgroundImage.size.width;
        CGFloat badgeH = self.currentBackgroundImage.size.height;
        if (badgeValue.length > 1) {
            CGSize size = [badgeValue sizeWithFont:self.titleLabel.font];
            badgeW = size.width + 10;
        }
        CGFloat badgeX = 0;
        self.frame = CGRectMake(badgeX, badgeY, badgeW, badgeH);
        
        [self setTitle:badgeValue forState:UIControlStateNormal];
        
    } else {
        self.hidden = YES;
    }
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
