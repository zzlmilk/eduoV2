//
//  SLAccountTool.h
//  02-pigBank
//
//  Created by 陆承东 on 14-9-17.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SLAccount.h"

@interface SLAccountTool : NSObject

+ (void)saveAccount:(SLAccount *)account;
+ (SLAccount *)getAccount;

@end
