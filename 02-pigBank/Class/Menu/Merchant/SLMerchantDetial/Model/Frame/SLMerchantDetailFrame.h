//
//  SLMerchantDetailFrame.h
//  02-pigBank
//
//  Created by 陆承东 on 14/10/23.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SLMerchantDetail.h"
#import "SLMerchantHeadCellFrame.h"
#import "SLMerchantPhotosFrame.h"
#import "SLMerchantCommentFrame.h"

@interface SLMerchantDetailFrame : NSObject

@property (nonatomic, strong) SLMerchantDetail *merchantDetail;

@property (nonatomic, strong, readonly) SLMerchantHeadCellFrame *merchantHeadCellFrame;

@property (nonatomic, strong, readonly) SLMerchantPhotosFrame *merchantPhotoFrame;

@property (nonatomic, strong) SLMerchantCommentFrame *merchantCommentFrame;

@end
