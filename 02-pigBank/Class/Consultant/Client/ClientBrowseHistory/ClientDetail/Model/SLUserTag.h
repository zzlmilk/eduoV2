//
//  SLUserTag.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/24.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

/*
 tagId = 63;
 tagText = "\U5e72\U6d3b";
 tagType = 1;
 userId = 100;
 */

#import <Foundation/Foundation.h>

@interface SLUserTag : NSObject

@property (nonatomic, strong) NSNumber *tagId;
@property (nonatomic, copy) NSString *tagText;
@property (nonatomic, copy) NSString *tagType;
@property (nonatomic, copy) NSString *used;
@property (nonatomic, strong) NSNumber *userId;

@end
