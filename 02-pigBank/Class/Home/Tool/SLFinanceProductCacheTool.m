//
//  SLFinanceProductCacheTool.m
//  02-pigBank
//
//  Created by 陆承东 on 14-10-13.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLFinanceProductCacheTool.h"
#import "FMDB.h"

#import "SLAccountTool.h"
#import "SLAccount.h"

@implementation SLFinanceProductCacheTool

static FMDatabaseQueue *_queue;

+ (void)setup
{
    // 0.获得沙盒中的数据库文件名
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"pigBank.sqlite"];
    
    // 1.创建队列
    _queue = [FMDatabaseQueue databaseQueueWithPath:path];
    
    // 2.创表
#warning ----- 问题一,在适当的地方清空表格; 问题二,使id可以在不是主键时自增加或者使materialId在不是主键时可以不重复,或者可以同时设置两个主键;
    // 解决:不是主键的字段可以设置不重复,在后面加上unique
    [_queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"create table if not exists t_financeProductFrames (id integer primary key autoincrement, materialId integer unique, financeProductFrame blob);"];
    }];
}

+ (void)addFinanceProductFrames:(NSArray *)financeProductFrames;
{
    for (SLFinanceProductFrame *fpf in financeProductFrames) {
        [self addFinanceProductFrame:fpf];
    }
}

+ (void)addFinanceProductFrame:(SLFinanceProductFrame *)financeProductFrame
{
    [self setup];
    
    [_queue inDatabase:^(FMDatabase *db) {
        // 1.获得需要存储的数据
        NSNumber *materialId = financeProductFrame.financeProduct.financialProductsDetail.materialId;
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:financeProductFrame];
        
        // 2.存储数据
        [db executeUpdate:@"insert into t_financeProductFrames ( materialId, financeProductFrame) values(?, ?)", materialId, data];
    }];
    
    [_queue close];
}

+ (SLFinanceProductFrame *)statuesWithParameters:(SLFinanceProductParameters *)parameters
{
    [self setup];
    
    // 1.定义数组
    __block NSMutableArray *financeProductFrameArray = nil;
    
    // 2.使用数据库
    [_queue inDatabase:^(FMDatabase *db) {
        // 创建数组
        financeProductFrameArray = [NSMutableArray array];
        
        FMResultSet *rs = [db executeQuery:@"select * from t_financeProductFrames where materialId = ?;", parameters.materialId];
        
        while (rs.next) {
            NSData *data = [rs dataForColumn:@"financeProductFrame"];
            SLFinanceProductFrame *financeProductFrame = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            [financeProductFrameArray addObject:financeProductFrame];
        }
    }];
    [_queue close];
    
    // 3.返回数据
    return [financeProductFrameArray lastObject];
}

+ (void)clearTable
{
    [self setup];
    
    [_queue inDatabase:^(FMDatabase *db) {
        // 清除数据
        [db executeUpdate:@"drop table if exists t_financeProductFrames;"];
        
        [db executeUpdate:@"create table if not exists t_financeProductFrames (id integer primary key autoincrement, materialId integer unique, financeProductFrame blob);"];
        
    }];
    
    [_queue close];
}

@end
