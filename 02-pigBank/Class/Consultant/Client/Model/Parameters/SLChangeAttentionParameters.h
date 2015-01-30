//
//  SLChangeAttentionParameters.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/19.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

/*
 userId	Long
 attentionType	String
 */

#import "SLBaseParameters.h"

@interface SLChangeAttentionParameters : SLBaseParameters

@property (nonatomic, strong) NSNumber *userId;
@property (nonatomic, copy) NSString *attentionType;

@end
