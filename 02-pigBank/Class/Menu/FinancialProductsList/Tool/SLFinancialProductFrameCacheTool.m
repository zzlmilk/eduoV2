//
//  SLFinancialProductFrameCacheTool.m
//  02-pigBank
//
//  Created by 陆承东 on 14-10-15.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLFinancialProductFrameCacheTool.h"

#import "FMDB.h"

#import "SLAccountTool.h"
#import "SLAccount.h"

@implementation SLFinancialProductFrameCacheTool

static FMDatabaseQueue *_queue;

+ (void)setup
{
    // 0.获得沙盒中的数据库文件名
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"pigBank.sqlite"];
    
    // 1.创建队列
    _queue = [FMDatabaseQueue databaseQueueWithPath:path];
    
    // 2.创表
    [_queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"create table if not exists t_financialProducts (plateId integer, leftTime integer, expectedYield integer, materialId integer, uid integer, financialStatusFrame blob, primary key(materialId, uid));"];
    }];
}

+ (void)addFinancialProductFrames:(NSArray *)financialProductFramesArray
{
    for (SLFinancialStatusFrame *financialStatusFrame in financialProductFramesArray) {
        [self addFinancialStatusFrame:financialStatusFrame];
    }
}

+ (void)addFinancialStatusFrame:(SLFinancialStatusFrame *)financialStatusFrame
{
    [self setup];
    
    [_queue inDatabase:^(FMDatabase *db) {
        // 1.获得需要存储的数据
        NSNumber *uid = [SLAccountTool getAccount].uid;
        NSNumber *materialId = financialStatusFrame.financeProduct.financialProductsDetail.materialId;
        NSNumber *plateId = financialStatusFrame.financeProduct.plateId;
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:financialStatusFrame];
        
        NSDate *now = [NSDate date];
        NSTimeInterval nowTimeInterval = [now timeIntervalSince1970];
        long long leftTimeLong = (long long)(financialStatusFrame.financeProduct.financialProductsDetail.subscribeEnd / 1000 - nowTimeInterval) / 60 / 60 / 24;
        NSNumber *leftTime = [NSNumber numberWithLongLong:leftTimeLong];
        
        NSInteger expectedYieldInteger = [financialStatusFrame.financeProduct.financialProductsDetail.expectedYield integerValue];
        NSNumber *expectedYield = [NSNumber numberWithInteger:expectedYieldInteger];
        
        // 2.存储数据
        [db executeUpdate:@"insert into t_financialProducts (uid, materialId, financialStatusFrame, plateId, leftTime, expectedYield) values(?, ?, ?, ?, ?, ?)", uid, materialId, data, plateId, leftTime, expectedYield];
    }];
    
    [_queue close];
}

+ (NSArray *)statuesWithParameters:(SLFinancialProductParameters *)parameters
{
    [self setup];
    
    // 1.定义数组
    __block NSMutableArray *financialStatusFrameArray = nil;
    
    // 2.使用数据库
    [_queue inDatabase:^(FMDatabase *db) {
        // 创建数组
        financialStatusFrameArray = [NSMutableArray array];
        
        // uid
        NSNumber *uid = [SLAccountTool getAccount].uid;
        
        FMResultSet *rs = nil;
        
        if ([parameters.orderType isEqualToString:@"1"]) {
            rs = [db executeQuery:@"select * from t_financialProducts where uid = ? and plateId = ? order by leftTime desc;", uid, parameters.plateId, parameters.pageSize];
        } else if ([parameters.orderType isEqualToString:@"2"]) {
            rs = [db executeQuery:@"select * from t_financialProducts where uid = ? and plateId = ? order by expectedYield desc;", uid, parameters.plateId, parameters.pageSize];
        }
        
        while (rs.next) {
            NSData *data = [rs dataForColumn:@"financialStatusFrame"];
            SLFinancialStatusFrame *financialStatusFrame = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            [financialStatusFrameArray addObject:financialStatusFrame];
        }
    }];
    [_queue close];
    
    // 3.返回数据
    return financialStatusFrameArray;
}

+ (void)clearStatuses
{
    [self setup];
    
    [_queue inDatabase:^(FMDatabase *db) {
        // 清除数据
        [db executeUpdate:@"drop table if exists t_financialProducts;"];
        
        [db executeUpdate:@"create table if not exists t_financialProducts (plateId integer, leftTime integer, expectedYield integer, materialId integer, uid integer, financialStatusFrame blob, primary key(materialId, uid));"];
        
    }];
    
    [_queue close];
}

@end
