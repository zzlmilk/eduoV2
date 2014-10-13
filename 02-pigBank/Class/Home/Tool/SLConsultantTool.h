//
//  SLConsultantTool.h
//  02-pigBank
//
//  Created by 陆承东 on 14-9-29.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SLConsultant.h"

@interface SLConsultantTool : NSObject

+ (void)saveConsultantAccount:(SLConsultant *)consultant;
+ (SLConsultant *)getConsultantAccount;

@end
