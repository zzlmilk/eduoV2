//
//  SLMyComment.h
//  02-pigBank
//
//  Created by 陆承东 on 14/10/22.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

/*
 commentId = 315;
 
 commentText = "ing\U4f60ing\U597d";
 
 commentTime = 1413943924913;
 
 merchantId = 42;
 
 replyFlag = 0;
 
 score = 5;
 
 userId = 147;
 
 userPartName = "\U5c0f\U5e05\U54e5";
 */

#import <Foundation/Foundation.h>

@interface SLMyComment : NSObject

@property (nonatomic, assign) long commentId;

@property (nonatomic, copy) NSString *commentText;

@property (nonatomic, strong) NSNumber *commentTime;

@property (nonatomic, assign) long merchantId;

@property (nonatomic, strong) NSNumber *replyFlag;

@property (nonatomic, assign) long score;

@property (nonatomic, assign) long userId;

@property (nonatomic, copy) NSString *userPartName;

@end
