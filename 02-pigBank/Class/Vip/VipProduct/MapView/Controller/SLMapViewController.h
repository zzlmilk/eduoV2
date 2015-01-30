//
//  SLMapViewController.h
//  02-pigBank
//
//  Created by 陆承东 on 14/10/22.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SLOutletsInfo.h"
#import "SLMerchantDetail.h"
#import "SLPrivilegeProduct.h"
#import "SLActivityDetail.h"

@interface SLMapViewController : UIViewController

@property (nonatomic, strong) SLOutletsInfo *outletsInfo;
@property (nonatomic, strong) SLMerchantDetail *merchantDetail;
@property (nonatomic, strong) SLPrivilegeProduct *privilegeProduct;
@property (nonatomic, strong) SLActivityDetail *activityDetail;
@end
