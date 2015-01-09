//
//  SLPrivilegeDetail.h
//  02-pigBank
//
//  Created by 陆承东 on 14/10/24.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

/*
 id = 95;
 materialId = 256;
 merchantDetail =                         { };
 merchantId = 66;
 pictureSmallUrl = "http://xynh.eduoinfo.com/resources/client/image/ba065f53-17be-4a2c-8740-5a68e10b7cd1.jpg";
 pictureUrl = "http://xynh.eduoinfo.com/resources/client/image/ba065f53-17be-4a2c-8740-5a68e10b7cd1.jpg";
 productCode = "";
 saleDescript = "";
 saleTypes = "";
 scale = 1;
 */

#import <Foundation/Foundation.h>

#import "SLMerchantInDetail.h"

@interface SLPrivilegeDetail : NSObject

@property (nonatomic, strong) NSNumber *materialId;
@property (nonatomic, strong) SLMerchantInDetail *merchantDetail;
@property (nonatomic, strong) NSNumber *merchantId;
@property (nonatomic, copy) NSString *pictureSmallUrl;
@property (nonatomic, copy) NSString *pictureUrl;
@property (nonatomic, copy) NSString *productCode;
@property (nonatomic, copy) NSString *saleDescript;
@property (nonatomic, copy) NSString *saleTypes;
@property (nonatomic, strong) NSNumber *scale;


@end
