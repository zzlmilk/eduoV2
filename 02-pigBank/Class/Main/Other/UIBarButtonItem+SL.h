//
//  UIBarButtonItem+SL.h
//  02-pigBank
//
//  Created by 陆承东 on 14-9-15.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (SL)

+ (UIBarButtonItem *)itemWithImage:(NSString *)image highlightImage:(NSString *)highlightImage target:(id)target action:(SEL)action;

@end
