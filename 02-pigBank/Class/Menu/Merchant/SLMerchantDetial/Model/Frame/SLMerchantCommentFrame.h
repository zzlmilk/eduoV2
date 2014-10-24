//
//  SLMerchantCommentFrame.h
//  02-pigBank
//
//  Created by 陆承东 on 14/10/24.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SLMyComment.h"
#import "SLOthersComment.h"

@interface SLMerchantCommentFrame : NSObject

@property (nonatomic, strong) SLMyComment *myComment;
@property (nonatomic, strong) SLOthersComment *otherComment;

@property (nonatomic, assign) CGRect commentLabelF;
@property (nonatomic, assign) CGRect scoreViewF;
@property (nonatomic, assign) CGRect timeLabelF;
@property (nonatomic, assign) CGFloat cellHeight;

@end
