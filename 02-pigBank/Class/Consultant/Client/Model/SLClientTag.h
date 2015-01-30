//
//  SLClientTag.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/19.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

/*
 tagId = "-1";
 tagText = "<\U65e0\U6807\U7b7e>";
 tagType = 1;
 userId = 195;
 userList = ( { }, { }, { }, { }, { }, { } );
 */

#import <Foundation/Foundation.h>

@interface SLClientTag : NSObject

@property (nonatomic, strong) NSNumber *tagId;
@property (nonatomic, copy) NSString *tagText;
@property (nonatomic, copy) NSString *tagType;
@property (nonatomic, strong) NSNumber *userId;
@property (nonatomic, strong) NSArray *userList;
@property (nonatomic, assign) BOOL open;

@end
