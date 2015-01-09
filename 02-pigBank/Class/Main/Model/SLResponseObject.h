//
//  SLResponseObject.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/9.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

/*
 code = 0000;
 info = ({});
 msg = "\U7d20\U6750\U6570\U636e\U83b7\U53d6\U6210\U529f";
 time = 1420775297312;
 */

#import <Foundation/Foundation.h>

@interface SLResponseObject : NSObject

@property (nonatomic, strong) NSNumber *code;
@property (nonatomic, strong) NSArray *info;
@property (nonatomic, copy) NSString *msg;
@property (nonatomic, strong) NSNumber *time;

@end
