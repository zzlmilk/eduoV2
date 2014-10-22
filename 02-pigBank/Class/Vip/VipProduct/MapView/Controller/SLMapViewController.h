//
//  SLMapViewController.h
//  02-pigBank
//
//  Created by 陆承东 on 14/10/22.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SLOutletsInfo.h"
#import "SLVipMerchantDetail.h"

@interface SLMapViewController : UIViewController

@property (nonatomic, strong) SLOutletsInfo *outletsInfo;
@property (nonatomic, strong) SLVipMerchantDetail *merchantDetail;

@end