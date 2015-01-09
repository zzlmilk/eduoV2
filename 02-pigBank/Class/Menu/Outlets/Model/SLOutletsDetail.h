//
//  SLOutletsDetail.h
//  02-pigBank
//
//  Created by 陆承东 on 14-10-16.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

/*
 address = "\U6ce2\U5e02\U5317\U4ed1\U533a\U65b0\U5927\U8def86\U53f7";
 distanceToMe = "147427.4200546";
 id = 115;
 latitude = "29.920899";
 longitude = "121.845942";
 materialId = 208;
 serviceTypeDisp = "\U94f6\U884c\U4fbf\U5229\U5e97";
 telephone = "0574-86896500";
 */

#import <Foundation/Foundation.h>

@interface SLOutletsDetail : NSObject

/** address */
@property (nonatomic, copy) NSString *address;
/** distanceToMe */
@property (nonatomic, copy) NSString *distanceToMe;
/** latitude */
@property (nonatomic, strong) NSNumber *latitude;
/** longitude */
@property (nonatomic, strong) NSNumber *longitude;
/** materialId */
@property (nonatomic, assign) long materialId;
/** serviceTypeDisp 服务类型 */
@property (nonatomic, copy) NSString *serviceTypeDisp;
/** telephone */
@property (nonatomic, strong) NSNumber *telephone;


@end
