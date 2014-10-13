//
//  SLConsultantTool.m
//  02-pigBank
//
//  Created by 陆承东 on 14-9-29.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLConsultantTool.h"

#define SLConsultantAccountFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"consultantAccount.data"]

@implementation SLConsultantTool

+ (void)saveConsultantAccount:(SLConsultant *)consultant
{
    // 存储
    [NSKeyedArchiver archiveRootObject:consultant toFile:SLConsultantAccountFile];
}

+ (SLConsultant *)getConsultantAccount
{
    // 取出账号信息
    return [NSKeyedUnarchiver unarchiveObjectWithFile:SLConsultantAccountFile];
}

@end
