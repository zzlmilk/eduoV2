//
//  SLClientPlatesTool.m
//  02-pigBank
//
//  Created by 陆承东 on 14-9-26.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLClientPlatesTool.h"

#define SLClientPlatesFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"clientPlates.data"]

@implementation SLClientPlatesTool

+ (void)saveClientPlates:(NSArray *)clientPlates
{
    // 存储
    [NSKeyedArchiver archiveRootObject:clientPlates toFile:SLClientPlatesFile];
}

+ (NSArray *)getClientPlates
{
    // 取出账号信息
    return [NSKeyedUnarchiver unarchiveObjectWithFile:SLClientPlatesFile];
    
//    // 判断是否过期
//    NSDate *now = [NSDate date];
//    if ([now compare:account.expireTime] == NSOrderedAscending) { //没有过期,返回账号信息
//        return account;
//    } else { // 已经过期返回空
//        return nil;
//    }
}

/**
 *  获取理财信息板块
 */
+ (SLClientPlate *)getFinancialProductClientPlate
{
    NSArray *clientPlates = [SLClientPlatesTool getClientPlates];
    
    return clientPlates[1];
}

/**
 *  获取网点板块
 */
+ (SLClientPlate *)getOutletClientPlate
{
    NSArray *clientPlates = [SLClientPlatesTool getClientPlates];
    
    return clientPlates[2];
}

@end
