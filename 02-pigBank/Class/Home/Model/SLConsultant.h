//
//  SLConsultant.h
//  02-pigBank
//
//  Created by 陆承东 on 14-9-29.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLConsultant : NSObject

/** dispName */
@property (nonatomic, copy) NSString *dispName;
/** email */
@property (nonatomic, copy) NSString *email;
/** dispName */
@property (nonatomic, strong) NSNumber *mobile;
/** pictureSmallUrl */
@property (nonatomic, copy) NSString *pictureSmallUrl;
/** pictureUrl */
@property (nonatomic, copy) NSString *pictureUrl;

@end
