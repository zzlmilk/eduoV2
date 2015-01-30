//
//  SLPlateInfoTool.m
//  02-pigBank
//
//  Created by 陆承东 on 15/1/22.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import "SLPlateInfoTool.h"

#import "SLClassInfo.h"
#import "SLPlateInfo.h"

#import "SLHttpTool.h"
#import "MJExtension.h"

#define SLPlataInfoListFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"plateInfoList.data"]
#define SLInternetPlataListFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"internetPlateList.data"]

@implementation SLPlateInfoTool

+ (void)classesListInPlateWithParameters:(SLClassesListParameters *)parameters success:(void (^)(NSArray *classesArray))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [SLHttpUrl stringByAppendingString:@"/plate/listPlateClass"];
    
    [SLHttpTool postWithUrlstr:url parameters:parameters.keyValues success:^(id responseObject) {
        
        SLResult *result = [SLResult objectWithKeyValues:responseObject];
        
        NSArray *dictArray = [result.info lastObject];
        NSArray *classesArrayFirst = [SLClassInfo objectArrayWithKeyValuesArray:dictArray];
        NSMutableArray *temp = [NSMutableArray array];
        SLClassInfo *all = [[SLClassInfo alloc] init];
        all.className = @"全部";
        all.classId = 0;
        [temp addObject:all];
        [temp addObjectsFromArray:classesArrayFirst];
        NSArray *classesArray = [NSArray arrayWithArray:temp];
        
        // 传递了block
        if (success) {
            success(classesArray);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)plateInfoListWithParameters:(SLPlateInfoListParameters *)parameters success:(void (^)(NSArray *plateInfoListArray))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [SLHttpUrl stringByAppendingString:@"/plate/listPlateInfo"];
    
    [SLHttpTool postWithUrlstr:url parameters:parameters.keyValues success:^(id responseObject) {
        
        SLLog(@"%@", responseObject);
        
        SLResult *result = [SLResult objectWithKeyValues:responseObject];
        
        if (result.info.count > 0) {
            NSArray *dictArray = [result.info lastObject];
            
            NSArray *plateInfoArray = [SLPlateInfo objectArrayWithKeyValuesArray:dictArray];
            [SLPlateInfoTool saveInternerPlateList:plateInfoArray];
            NSMutableArray *plateInfoListArray = [NSMutableArray array];
            
            SLPlateInfo *home = [[SLPlateInfo alloc] init];
            home.dispName = @"首页";
            home.pictureUrl = [SLPicHttpUrl stringByAppendingString:@"/plate/shouYe@2x.png"];
            home.plateName = @"首页";
            home.plateType = @"1";
            [plateInfoListArray addObject:home];
            [plateInfoListArray addObjectsFromArray:plateInfoArray];
            
            SLPlateInfo *merchant = [[SLPlateInfo alloc] init];
            merchant.dispName = @"商圈";
            merchant.pictureUrl = [SLPicHttpUrl stringByAppendingString:@"/plate/shangQuan@2x.png"];
            merchant.plateName = @"商圈";
            merchant.plateType = @"6";
            [plateInfoListArray addObject:merchant];
            
            SLPlateInfo *subscribe = [[SLPlateInfo alloc] init];
            subscribe.dispName = @"订阅";
            subscribe.pictureUrl = [SLPicHttpUrl stringByAppendingString:@"/plate/shouYe@2x.png"];
            subscribe.plateName = @"订阅";
            subscribe.plateType = @"7";
            [plateInfoListArray addObject:subscribe];
            
            SLPlateInfo *myComment = [[SLPlateInfo alloc] init];
            myComment.dispName = @"我的点评";
            myComment.pictureUrl = [SLPicHttpUrl stringByAppendingString:@"/plate/dianPing@2x.png"];
            myComment.plateName = @"我的点评";
            myComment.plateType = @"8";
            [plateInfoListArray addObject:myComment];
            
            SLPlateInfo *myCollect = [[SLPlateInfo alloc] init];
            myCollect.dispName = @"我的收藏";
            myCollect.pictureUrl = [SLPicHttpUrl stringByAppendingString:@"/plate/shouCang@2x.png"];
            myCollect.plateName = @"我的收藏";
            myCollect.plateType = @"9";
            [plateInfoListArray addObject:myCollect];
            
            SLPlateInfo *myConsultant = [[SLPlateInfo alloc] init];
            myConsultant.dispName = @"我的顾问";
            myConsultant.pictureUrl = [SLPicHttpUrl stringByAppendingString:@"/plate/guWen@2x.png"];
            myConsultant.plateName = @"我的顾问";
            myConsultant.plateType = @"10";
            [plateInfoListArray addObject:myConsultant];
            
            // 传递了block
            if (success) {
                success(plateInfoListArray);
            }
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)saveInternerPlateList:(NSArray *)plateList
{
    // 存储
    [NSKeyedArchiver archiveRootObject:plateList toFile:SLInternetPlataListFile];
}

+ (NSArray *)getInternetPlateList
{
    // 取出账号信息
    NSArray *plataInfoList = [NSKeyedUnarchiver unarchiveObjectWithFile:SLInternetPlataListFile];
    // 判断是否过期
    return plataInfoList;
}

+ (void)savePlateInfoList:(NSArray *)plateInfoList
{
    // 存储
    [NSKeyedArchiver archiveRootObject:plateInfoList toFile:SLPlataInfoListFile];
}

+ (NSArray *)getPlateInfoList
{
    // 取出账号信息
    NSArray *plataInfoList = [NSKeyedUnarchiver unarchiveObjectWithFile:SLPlataInfoListFile];
    // 判断是否过期
    return plataInfoList;
}

@end
