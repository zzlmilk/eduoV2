//
//  SLInputTextField.m
//  02-pigBank
//
//  Created by 陆承东 on 14-9-17.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLInputTextField.h"

@implementation SLInputTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+ (instancetype)inputTextFieldWithLeftViewImage:(NSString *)imageName
{
    SLInputTextField *inputTextField = [[SLInputTextField alloc] init];
    UIImage *image = [UIImage imageNamed:imageName];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.bounds = CGRectMake(0, 0, image.size.width + 15, image.size.height);
    imageView.contentMode = UIViewContentModeCenter;
    inputTextField.leftView = imageView;
    inputTextField.leftViewMode = UITextFieldViewModeAlways;
    inputTextField.clearButtonMode = UITextFieldViewModeAlways;
    return inputTextField;
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
