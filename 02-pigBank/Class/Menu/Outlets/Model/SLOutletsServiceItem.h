//
//  SLOutletsServiceItem.h
//  02-pigBank
//
//  Created by 陆承东 on 14-10-17.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

/*
 dataSort = 1;
 dataText = ATM;
 dataType = "OUTLETS_SERVICE_TYPE";
 dataValue = 1; 传递
 isFix = 0;
 */

#import <Foundation/Foundation.h>

@interface SLOutletsServiceItem : NSObject

@property (nonatomic, copy) NSString *dataText;

@property (nonatomic, copy) NSString *dataType;

@property (nonatomic, strong) NSNumber *dataValue;

@property (nonatomic, strong) NSNumber *dataSort;

@end
