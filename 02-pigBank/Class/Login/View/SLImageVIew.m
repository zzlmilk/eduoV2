//
//  SLImageVIew.m
//  02-pigBank
//
//  Created by 陆承东 on 14-9-17.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLImageVIew.h"

@implementation SLImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+ (instancetype)imageViewWithImageName:(NSString *)name
{
    UIImage *image = [UIImage imageNamed:name];
    SLImageView *imageView = [[SLImageView alloc] initWithImage:image];
    imageView.bounds = CGRectMake(0, 0, image.size.width, image.size.height);
    return imageView;
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
