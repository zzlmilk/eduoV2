//
//  SLMaterialInfo.h
//  02-pigBank
//
//  Created by 陆承东 on 14/10/24.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

/*
 classId = 2;
 collectCounts = 8;
 content = "<p> </p>";
 extPictureUrl = "http://xynh.eduoinfo.com/resources/client/image/ba065f53-17be-4a2c-8740-5a68e10b7cd1.jpg";
 materialId = 256;
 plateId = 1;
 praiseCounts = 10;
 privilegeDetail = { };
 publishModel = 1;
 recommendFlag = 0;
 searchKey = "";
 status = 1;
 templetType = 2;
 title = "\U9526\U6c5f\U4e0e\U60a8\U76f8\U7ea6\U4e2d\U79cb\U7279\U60e0";
 verifyStatus = 1;
 verifyTime = 1407899558727;
 */

#import <Foundation/Foundation.h>

#import "SLPrivilegeDetail.h"

@interface SLMaterialInfo : NSObject

@property (nonatomic, strong) NSNumber *classId;

@property (nonatomic, strong) NSNumber *collectCounts;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *extPictureUrl;

@property (nonatomic, strong) NSNumber *materialId;

@property (nonatomic, strong) NSNumber *plateId;

@property (nonatomic, strong) NSNumber *praiseCounts;

@property (nonatomic, strong) SLPrivilegeDetail *privilegeDetail;

@property (nonatomic, copy) NSString *title;

@end
