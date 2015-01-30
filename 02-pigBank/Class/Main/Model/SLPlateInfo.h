//
//  SLPlateInfo.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/26.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

/*
 dispName = "VIP\U7279\U6743";
 newsCount = 0;
 pictureUrl = "http://xynh.eduoinfo.com/resources/data2.0/ds/plate/vip@2x.png";
 plateId = 1;
 plateName = "VIP\U7279\U6743";
 plateSort = 1;
 plateType = 2;
 */

#import <Foundation/Foundation.h>

@interface SLPlateInfo : NSObject

@property (nonatomic, copy) NSString *dispName;
@property (nonatomic, strong) NSNumber *newsCount;
@property (nonatomic, copy) NSString *pictureUrl;
@property (nonatomic, strong) NSNumber *plateId;
@property (nonatomic, copy) NSString *plateName;
@property (nonatomic, strong) NSNumber *plateSort;
@property (nonatomic, copy) NSString *plateType;

@end
