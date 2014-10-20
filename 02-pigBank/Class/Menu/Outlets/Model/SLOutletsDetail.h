//
//  SLOutletsDetail.h
//  02-pigBank
//
//  Created by 陆承东 on 14-10-16.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

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

/** serviceTypeDisp */
@property (nonatomic, copy) NSString *serviceTypeDisp;

/** telephone */
@property (nonatomic, strong) NSNumber *telephone;

/** materialId */
//@property (nonatomic, assign) long materialId;

@end
