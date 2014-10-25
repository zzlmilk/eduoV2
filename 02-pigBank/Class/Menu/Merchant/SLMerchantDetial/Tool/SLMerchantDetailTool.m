//
//  SLMerchantDetailTool.m
//  02-pigBank
//
//  Created by 陆承东 on 14/10/22.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLMerchantDetailTool.h"

#import "SLMerchantPhoto.h"
#import "SLMyComment.h"
#import "SLOthersComment.h"
#import "SLMaterialInfo.h"
#import "SLVipStatusFirstMaterialInfo.h"
#import "SLVipStatus.h"

#import "SLHttpTool.h"

#import "MJExtension.h"

@interface SLMerchantDetailTool()

@end

@implementation SLMerchantDetailTool

+ (void)merchantDetailWithParameters:(SLMerchantDetailPatameters *)parameters success:(void (^)(NSArray *merchantDetailAndVipStatuses))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [SLHttpUrl stringByAppendingString:@"/merchant/catchMerchantInfoById"];
    
    [SLHttpTool postWithUrlstr:url parameters:parameters.keyValues success:^(id responseObject) {
        NSMutableArray *merchantDetailAndVipStatuses = [NSMutableArray array];
        NSMutableArray *vipStatusArray = [NSMutableArray array];
        
        NSDictionary *dict = [responseObject[@"info"] lastObject];
        
        SLMerchantDetail *merchantDetail = [SLMerchantDetail objectWithKeyValues:dict];
        merchantDetail.Description = dict[@"description"];
        
        if (merchantDetail.materialInfoList.count) {
            NSMutableArray *materialInfoListArray = [NSMutableArray array];
            for (NSDictionary *dict in merchantDetail.materialInfoList) {
                SLMaterialInfo *materialInfo = [SLMaterialInfo objectWithKeyValues:dict];
                SLVipStatusFirstMaterialInfo *firstMaterialInfo = [SLVipStatusFirstMaterialInfo objectWithKeyValues:dict];
                SLVipStatus *vipStatus = [[SLVipStatus alloc] init];
                vipStatus.firstMaterialInfo = firstMaterialInfo;
                [vipStatusArray addObject:vipStatus];
                [materialInfoListArray addObject:materialInfo];
            }
            merchantDetail.materialInfoList = materialInfoListArray;
        }
        
        if (merchantDetail.merchantPhotoList.count) {
            NSMutableArray *merchantPhotoListArray = [NSMutableArray array];
            for (NSDictionary *dict in merchantDetail.merchantPhotoList) {
                SLMerchantPhoto *merchantPhoto = [SLMerchantPhoto objectWithKeyValues:dict];
                [merchantPhotoListArray addObject:merchantPhoto];
            }
            merchantDetail.merchantPhotoList = merchantPhotoListArray;
        }
        
        if (merchantDetail.myCommentList.count) {
            NSMutableArray *myCommentListArray = [NSMutableArray array];
            for (NSDictionary *dict in merchantDetail.myCommentList) {
                SLMyComment *myComment = [SLMyComment objectWithKeyValues:dict];
                [myCommentListArray addObject:myComment];
            }
            merchantDetail.myCommentList = myCommentListArray;
        }
        
        if (merchantDetail.othersCommentList) {
            NSMutableArray *othersCommentListArray = [NSMutableArray array];
            for (NSDictionary *dict in merchantDetail.othersCommentList) {
                SLOthersComment *otherComment = [SLOthersComment objectWithKeyValues:dict];
                [othersCommentListArray addObject:otherComment];
            }
            merchantDetail.othersCommentList = othersCommentListArray;
        }
        [merchantDetailAndVipStatuses addObject:merchantDetail];
        [merchantDetailAndVipStatuses addObject:vipStatusArray];
        // 传递了block
        if (success) {
            success(merchantDetailAndVipStatuses);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

//+ (void)merchantDetailWithParameters:(SLMerchantDetailPatameters *)parameters success:(void (^)(SLMerchantDetail *merchantDetail))success failure:(void (^)(NSError *error))failure
//{
//    NSString *url = [SLHttpUrl stringByAppendingString:@"/merchant/catchMerchantInfoById"];
//    
//    [SLHttpTool postWithUrlstr:url parameters:parameters.keyValues success:^(id responseObject) {
//        
//        NSDictionary *dict = [responseObject[@"info"] lastObject];
//        
//        SLMerchantDetail *merchantDetail = [SLMerchantDetail objectWithKeyValues:dict];
//        merchantDetail.Description = dict[@"description"];
//        
//        if (merchantDetail.materialInfoList.count) {
//            NSMutableArray *materialInfoListArray = [NSMutableArray array];
//            for (NSDictionary *dict in merchantDetail.materialInfoList) {
//                SLMaterialInfo *materialInfo = [SLMaterialInfo objectWithKeyValues:dict];
//                [materialInfoListArray addObject:materialInfo];
//            }
//            merchantDetail.materialInfoList = materialInfoListArray;
//        }
//        
//        if (merchantDetail.merchantPhotoList.count) {
//            NSMutableArray *merchantPhotoListArray = [NSMutableArray array];
//            for (NSDictionary *dict in merchantDetail.merchantPhotoList) {
//                SLMerchantPhoto *merchantPhoto = [SLMerchantPhoto objectWithKeyValues:dict];
//                [merchantPhotoListArray addObject:merchantPhoto];
//            }
//            merchantDetail.merchantPhotoList = merchantPhotoListArray;
//        }
//        
//        if (merchantDetail.myCommentList.count) {
//            NSMutableArray *myCommentListArray = [NSMutableArray array];
//            for (NSDictionary *dict in merchantDetail.myCommentList) {
//                SLMyComment *myComment = [SLMyComment objectWithKeyValues:dict];
//                [myCommentListArray addObject:myComment];
//            }
//            merchantDetail.myCommentList = myCommentListArray;
//        }
//        
//        if (merchantDetail.othersCommentList) {
//            NSMutableArray *othersCommentListArray = [NSMutableArray array];
//            for (NSDictionary *dict in merchantDetail.othersCommentList) {
//                SLOthersComment *otherComment = [SLOthersComment objectWithKeyValues:dict];
//                [othersCommentListArray addObject:otherComment];
//            }
//            merchantDetail.othersCommentList = othersCommentListArray;
//        }
//        
//        // 传递了block
//        if (success) {
//            success(merchantDetail);
//        }
//    } failure:^(NSError *error) {
//        if (failure) {
//            failure(error);
//        }
//    }];
//}

@end
