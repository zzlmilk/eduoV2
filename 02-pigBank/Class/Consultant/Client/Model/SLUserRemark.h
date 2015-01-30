//
//  SLUserRemark.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/19.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

/*
 insertTime = 1420534772068;
 insertUser = 195;
 isAttention = 1;
 remarkDesc = "";
 remarkName = "";
 updateTime = 1420534772068;
 updateUser = 195;
 userId = 143;
 */

#import <Foundation/Foundation.h>

@interface SLUserRemark : NSObject

@property (nonatomic, strong) NSNumber *insertTime;
@property (nonatomic, strong) NSNumber *insertUser;
@property (nonatomic, copy) NSString *isAttention;
@property (nonatomic, copy) NSString *remarkDesc;
@property (nonatomic, copy) NSString *remarkName;
@property (nonatomic, strong) NSNumber *updateTime;
@property (nonatomic, strong) NSNumber *updateUser;
@property (nonatomic, strong) NSNumber *userId;

@end
