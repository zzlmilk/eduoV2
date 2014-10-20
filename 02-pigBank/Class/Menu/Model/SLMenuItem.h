//
//  SLMenuItem.h
//  02-pigBank
//
//  Created by 陆承东 on 14-9-25.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLMenuItem : NSObject

/** title */
@property (nonatomic, copy) NSString *title;

/** iconImage */
@property (nonatomic, strong) UIImage *iconImage;

/** icon */
@property (nonatomic, copy) NSString *icon;

/** mobile */
@property (nonatomic, copy) NSString *mobile;

+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title;
+ (instancetype)itemWithTitle:(NSString *)title;
+ (instancetype)item;

@end
