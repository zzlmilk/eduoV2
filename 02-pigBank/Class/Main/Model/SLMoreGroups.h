//
//  SLMoreGroups.h
//  02-pigBank
//
//  Created by 陆承东 on 14-9-22.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLMoreGroups : NSObject

/** title */
@property (nonatomic, copy) NSString *title;
/** foot */
@property (nonatomic, copy) NSString *foot;
/** moreItems */
@property (nonatomic, strong) NSArray *moreItems;

@end
