//
//  SLHomeStatusCacheTool.m
//  02-pigBank
//
//  Created by 陆承东 on 14-10-12.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLHomeStatusCacheTool.h"

#import "FMDB.h"

#import "SLAccountTool.h"
#import "SLAccount.h"
#import "SLHomeStatus.h"

@implementation SLHomeStatusCacheTool

static FMDatabaseQueue *_queue;

+ (void)setup
{
    // 0.获得沙盒中的数据库文件名
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"homeStatus.sqlite"];
    
    // 1.创建队列
    _queue = [FMDatabaseQueue databaseQueueWithPath:path];
    
    // 2.创表
#warning ----- 问题一,在适当的地方清空表格; 问题二,使id可以在不是主键时自增加或者使materialId在不是主键时可以不重复,或者可以同时设置两个主键;
    [_queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"create table if not exists t_status (id integer primary key autoincrement, materialId integer unique, uid integer, homeStatus blob);"];
    }];
}

+ (void)addStatuses:(NSArray *)statusArray
{
    for (SLHomeStatus *status in statusArray) {
        [self addStatus:status];
    }
}

+ (void)addStatus:(SLHomeStatus *)status
{
    [self setup];
    
    [_queue inDatabase:^(FMDatabase *db) {
        // 1.获得需要存储的数据
        NSNumber *uid = [NSNumber numberWithInteger:[SLAccountTool getAccount].uid ];
        NSNumber *materialId = [NSNumber numberWithInteger:status.materialId];
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:status];
        
        // 2.存储数据
        [db executeUpdate:@"insert into t_status (uid, materialId, homeStatus) values(?, ? , ?)", uid, materialId, data];
    }];
    
    [_queue close];
}

+ (NSArray *)statuesWithParameters:(SLHomeStatusParameters *)parameters
{
    [self setup];
    
    // 1.定义数组
    __block NSMutableArray *statusArray = nil;
    
    // 2.使用数据库
    [_queue inDatabase:^(FMDatabase *db) {
        // 创建数组
        statusArray = [NSMutableArray array];
        
        // uid
        NSNumber *uid = [NSNumber numberWithInteger:[SLAccountTool getAccount].uid];
        
        long long limitFrom = [parameters.pageSize longLongValue] * ([parameters.curPage longLongValue] - 1);
        
        NSNumber *curPage = [NSNumber numberWithLongLong:limitFrom];
//        FMResultSet *rs = [db executeQuery:@"select * from t_status where uid = ? limit ?,?;", uid, [NSNumber numberWithInt:currentPage], parameters.pageSize];
        
        FMResultSet *rs = [db executeQuery:@"select * from t_status where uid = ? limit ?, ?;", uid, curPage, parameters.pageSize];
        
        while (rs.next) {
            NSData *data = [rs dataForColumn:@"homeStatus"];
            SLHomeStatus *status = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            [statusArray addObject:status];
        }
    }];
    [_queue close];
    
    // 3.返回数据
    return statusArray;
}

+ (void)clearStatuses
{
    [self setup];
    
    [_queue inDatabase:^(FMDatabase *db) {
        // 清除数据
        [db executeUpdate:@"drop table if exists t_status;"];
        
        [db executeUpdate:@"create table if not exists t_status (id integer primary key autoincrement, materialId integer unique, uid integer, homeStatus blob);"];
        
    }];
    
    [_queue close];
}

@end
