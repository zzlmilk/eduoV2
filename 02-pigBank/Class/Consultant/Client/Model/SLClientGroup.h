//
//  SLClientGroup.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/19.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

/*
 groupId = "-1";
 groupName = "<\U65e0\U5206\U7ec4>";
 sort = 0;
 status = 1;
 userList = ({ }, { }, { }, { }, { }, { }, { }, { } );
 */

#import "SLBaseParameters.h"

@interface SLClientGroup : SLBaseParameters

@property (nonatomic, strong) NSNumber *groupId;
@property (nonatomic, copy) NSString *groupName;
@property (nonatomic, strong) NSNumber *sort;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, strong) NSArray *userList;
@property (nonatomic, assign) BOOL open;

@end
