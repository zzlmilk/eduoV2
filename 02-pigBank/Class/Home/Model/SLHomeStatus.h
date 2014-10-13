//
//  SLHomeStatus.h
//  02-pigBank
//
//  Created by 陆承东 on 14-9-17.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLHomeStatus : NSObject <NSCoding>
/** 图片 */
@property (nonatomic, copy) NSString *extPictureUrl;
/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 喜欢的人数 */
@property (nonatomic, assign) long praiseCounts;
/** 数据模版类型 */
@property (nonatomic, assign) int templetType;
/** materialId */
@property (nonatomic, assign) long materialId;
/** verifyTime */
@property (nonatomic, assign) long long verifyTime;
/** plateId */
@property (nonatomic, assign) long plateId;

@end
