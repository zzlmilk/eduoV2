//
//  SLOutletsListFrame.h
//  02-pigBank
//
//  Created by 陆承东 on 14-10-16.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SLOutletsInfo.h"

@interface SLOutletsListFrame : NSObject

@property (nonatomic, strong) SLOutletsInfo *outletsInfo;

/** titleLabelF */
@property (nonatomic, assign, readonly) CGRect titleLabelF;

/** adressLabelF */
@property (nonatomic, assign, readonly) CGRect adressLabelF;

/** distanceLabelF */
@property (nonatomic, assign, readonly) CGRect distanceLabelF;

@end
