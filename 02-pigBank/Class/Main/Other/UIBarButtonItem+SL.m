//
//  UIBarButtonItem+SL.m
//  02-pigBank
//
//  Created by 陆承东 on 14-9-15.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "UIBarButtonItem+SL.h"

@implementation UIBarButtonItem (SL)

+ (UIBarButtonItem *)itemWithImage:(NSString *)image highlightImage:(NSString *)highlightImage target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highlightImage] forState:UIControlStateHighlighted];
    button.frame = CGRectMake(0, 0, button.currentImage.size.width, button.currentImage.size.height);
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

@end
