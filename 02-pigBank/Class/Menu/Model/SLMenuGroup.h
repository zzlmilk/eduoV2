//
//  SLMenuGroup.h
//  02-pigBank
//
//  Created by 陆承东 on 14-9-25.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLMenuGroup : NSObject

/** title */
@property (nonatomic, copy) NSString *title;
/** foot */
@property (nonatomic, copy) NSString *foot;
/** moreItems */
@property (nonatomic, strong) NSArray *menuItems;

@end
