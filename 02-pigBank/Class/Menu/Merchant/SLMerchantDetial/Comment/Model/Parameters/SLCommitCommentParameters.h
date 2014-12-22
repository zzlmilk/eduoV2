//
//  SLCommitCommentParameters.h
//  02-pigBank
//
//  Created by 陆承东 on 14/12/12.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLBaseParameters.h"

@interface SLCommitCommentParameters : SLBaseParameters

@property (nonatomic, strong) NSNumber *merchantId;

@property (nonatomic, strong) NSNumber *score;

@property (nonatomic, strong) NSString *comment;

@end
