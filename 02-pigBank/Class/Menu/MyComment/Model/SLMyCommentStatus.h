//
//  SLMyCommentStatus.h
//  02-pigBank
//
//  Created by 陆承东 on 14/12/12.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

/**
 { ①
 
 commentId = 322;
 
 commentText = "\U54e6\U6765\U54af\U54e6\U6765\U54af\U54e6\U6765\U54af\U54e6\U6765\U54af\U54e6\U6765\U54af\U54e6\U6765\U54af\U54e6\U6765\U54af\U54e6\U6765\U54af\U54e6\U6765\U54af\U54e6\U6765\U54af\U54e6\U6765\U54af\U54e6\U6765\U54af\U54e6\U6765\U54af\U54e6\U6765\U54af\U54e6\U6765\U54af\U54e6\U6765\U54af";
 
 commentTime = 1418377051528;
 
 merchantDetail = {  };①
 
 merchantId = 49;
 
 merchantName = "\U767e\U601d\U4e70";
 
 replyFlag = 0;
 
 score = 5;
 
 userId = 147;
 
 userPartName = "\U5c0f\U5e05\U54e5";
 
 }
 */

#import <Foundation/Foundation.h>

#import "SLVipMerchantDetail.h"

@interface SLMyCommentStatus : NSObject

@property (nonatomic, strong) SLVipMerchantDetail *merchantDetail;

@property (nonatomic, strong) NSNumber *commentId;

@property (nonatomic, copy) NSString *commentText;

@property (nonatomic, strong) NSNumber *commentTime;

@property (nonatomic, strong) NSNumber *merchantId;

@property (nonatomic, copy) NSString *merchantName;

@property (nonatomic, strong) NSNumber *replyFlag;

@property (nonatomic, strong) NSNumber *score;

@property (nonatomic, strong) NSNumber *userId;

@property (nonatomic, copy) NSString *userPartName;


@end
