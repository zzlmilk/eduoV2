//
//  SLClientPlate.h
//  02-pigBank
//
//  Created by 陆承东 on 14-9-25.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLClientPlate : NSObject

/** dispName 板块名字 */
@property (nonatomic, copy) NSString *dispName;

/** newsCount */
@property (nonatomic, assign) NSInteger newsCount;

/** pictureUrl */
@property (nonatomic, copy) NSString *pictureUrl;

/** plateId 板块id */
@property (nonatomic, assign) NSInteger plateId;

/** plateName 板块名称 */
@property (nonatomic, copy) NSString *plateName;

/** plateSort */
@property (nonatomic, assign) NSInteger plateSort;

/** plateType */
@property (nonatomic, assign) NSInteger plateType;

@end
