//
//  SLVipStatusCacheTool.m
//  02-pigBank
//
//  Created by 陆承东 on 14-10-15.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLVipStatusCacheTool.h"

#import "FMDB.h"

#import "SLAccountTool.h"
#import "SLAccount.h"

@implementation SLVipStatusCacheTool

static FMDatabaseQueue *_queue;

+ (void)setup
{
    // 0.获得沙盒中的数据库文件名
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"pigBank.sqlite"];
    
    // 1.创建队列
    _queue = [FMDatabaseQueue databaseQueueWithPath:path];
    
    // 2.创表
    [_queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"create table if not exists t_vipStatusFrame (materialId integer, uid integer, vipStatusFrame blob, primary key(materialId, uid));"];
    }];
}

+ (void)addStatuses:(NSArray *)statusFrameArray
{
    for (SLVipStatusFrame *statusFrame in statusFrameArray) {
        [self addStatus:statusFrame];
    }
}

+ (void)addStatus:(SLVipStatusFrame *)statusFrame
{
    [self setup];
    
    [_queue inDatabase:^(FMDatabase *db) {
        // 1.获得需要存储的数据
        NSNumber *uid = [SLAccountTool getAccount].uid;
        NSNumber *materialId = statusFrame.vipStatus.firstMaterialInfo.materialId;
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:statusFrame];
        
        // 2.存储数据
        [db executeUpdate:@"insert into t_vipStatusFrame (uid, materialId, vipStatusFrame) values(?, ? , ?)", uid, materialId, data];
    }];
    
    [_queue close];
}

+ (NSArray *)statuesWithParameters:(SLVipParameters *)parameters
{
    [self setup];
    
    // 1.定义数组
    __block NSMutableArray *statusFrameArray = nil;
    
    // 2.使用数据库
    [_queue inDatabase:^(FMDatabase *db) {
        // 创建数组
        statusFrameArray = [NSMutableArray array];
        
        // uid
        NSNumber *uid = [SLAccountTool getAccount].uid;
        
        FMResultSet *rs = [db executeQuery:@"select * from t_vipStatusFrame where uid = ?;", uid];
        
        while (rs.next) {
            NSData *data = [rs dataForColumn:@"vipStatusFrame"];
            SLVipStatusFrame *statusFrame = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            [statusFrameArray addObject:statusFrame];
        }
    }];
    [_queue close];
    
    // 3.返回数据
    return statusFrameArray;
}

+ (void)clearStatuses
{
    [self setup];
    
    [_queue inDatabase:^(FMDatabase *db) {
        // 清除数据
        [db executeUpdate:@"drop table if exists t_vipStatusFrame;"];
        
        [db executeUpdate:@"create table if not exists t_vipStatusFrame (materialId integer, uid integer, vipStatusFrame blob, primary key(materialId, uid));"];
        
    }];
    
    [_queue close];
}

@end
