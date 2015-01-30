//
//  SLAccountTool.m
//  02-pigBank
//
//  Created by 陆承东 on 14-9-17.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLAccountTool.h"
#define SLAccountFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"]


@implementation SLAccountTool

+ (void)saveAccount:(SLAccount *)account
{
    // 这两句等于上面的宏
//    NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    NSString *file = [document stringByAppendingPathComponent:@"account.data"];
    // 算出过期时间
    NSDate *now = [NSDate date];
    account.expireTime = [now dateByAddingTimeInterval:[account.time doubleValue]];
    
    // 存储
    [NSKeyedArchiver archiveRootObject:account toFile:SLAccountFile];
}

+ (SLAccount *)getAccount
{
    // 取出账号信息
    SLAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:SLAccountFile];
    // 判断是否过期
    NSDate *now = [NSDate date];
    if ([now compare:account.expireTime] == NSOrderedAscending) { //没有过期,返回账号信息
        return account;
    } else { // 已经过期返回空
        return nil;
    }
}

@end
