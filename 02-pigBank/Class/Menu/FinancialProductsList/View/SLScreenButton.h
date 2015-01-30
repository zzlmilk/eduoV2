//
//  SLScreenButton.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/19.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SLFinancialProductClass.h"
#import "SLClassInfo.h"
#import "SLSubscribeClass.h"

@interface SLScreenButton : UIButton

@property (nonatomic, strong) SLFinancialProductClass *financialProductClass;
@property (nonatomic, strong) SLClassInfo *classInfo;
@property (nonatomic, strong) SLSubscribeClass *subscribeClass;

@end
