//
//  SLMerchantPhoto.h
//  02-pigBank
//
//  Created by 陆承东 on 14/10/22.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

/*
 id = 693;
 
 merchantId = 42;
 
 pictureSmallUrl = "http://xynh.eduoinfo.com/resources/client/image/760d193a-cecd-46d0-8e0f-9739f6d01915.jpg";
 
 pictureUrl = "http://xynh.eduoinfo.com/resources/client/image/760d193a-cecd-46d0-8e0f-9739f6d01915.jpg";
 */

#import <Foundation/Foundation.h>

@interface SLMerchantPhoto : NSObject

@property (nonatomic, assign) long Id;

@property (nonatomic, assign) long merchantId;

@property (nonatomic, copy) NSString *pictureSmallUrl;

@property (nonatomic, copy) NSString *pictureUrl;

@end
