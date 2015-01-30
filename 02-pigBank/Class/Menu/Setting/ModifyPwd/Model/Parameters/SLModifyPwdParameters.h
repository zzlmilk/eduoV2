//
//  SLModifyPwdParameters.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/23.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import "SLBaseParameters.h"

@interface SLModifyPwdParameters : SLBaseParameters

@property (nonatomic, copy) NSString *oldpwd;
@property (nonatomic, copy) NSString *password;

@end
