//
//  SLChangeCoordinateResult.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/30.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

/*
 info = ok;
 locations = "30.9437675,121.1198989";
 status = 1;
 */

#import <Foundation/Foundation.h>

@interface SLChangeCoordinateResult : NSObject

@property (nonatomic, copy) NSString *info;
@property (nonatomic, copy) NSString *locations;
@property (nonatomic, copy) NSString *status;

@end
