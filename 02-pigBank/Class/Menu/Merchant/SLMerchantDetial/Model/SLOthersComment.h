//
//  SLOthersComment.h
//  02-pigBank
//
//  Created by 陆承东 on 14/10/22.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

/*
 commentId = 313;
 
 commentText = "\U6797\U4fca\U6770\U53ef\U53e3\U53ef\U4e50\U4e86";
 
 commentTime = 1413284963863;
 
 merchantId = 42;
 
 replyFlag = 0;
 
 score = 0;
 
 userId = 135;
 
 userPartName = "\U5218\U5b66\U7fa4";
 */

#import <Foundation/Foundation.h>

@interface SLOthersComment : NSObject

@property (nonatomic, assign) long commentId;

@property (nonatomic, copy) NSString *commentText;

@property (nonatomic, strong) NSNumber *commentTime;

@property (nonatomic, assign) long merchantId;

@property (nonatomic, strong) NSNumber *replyFlag;

@property (nonatomic, assign) long score;

@property (nonatomic, assign) long userId;

@property (nonatomic, copy) NSString *userPartName;

@end
