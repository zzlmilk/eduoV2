//
//  SLLoginButton.h
//  02-pigBank
//
//  Created by 陆承东 on 14-9-17.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLLoginButton : UIButton

+ (instancetype)buttonWithTitle:(NSString *)title backgroundImage:(NSString *)backgroundImage highlightBackgroundImage:(NSString *)highlightBackgroundImage;

+ (instancetype)buttonWithTitle:(NSString *)title;

@end
