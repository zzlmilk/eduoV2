//
//  SLMerchantStatusFrame.h
//  02-pigBank
//
//  Created by 陆承东 on 14/10/21.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SLMerchantDetail.h"

@interface SLMerchantStatusFrame : NSObject

@property (nonatomic, strong) SLMerchantDetail *merchantDetial;

/** pictureImageViewF */
@property (nonatomic, assign, readonly) CGRect pictureImageViewF;
/** titleLabelF */
@property (nonatomic, assign, readonly) CGRect titleLabelF;
/** likeViewF */
@property (nonatomic, assign, readonly) CGRect likeViewF;
/** adressLabelF */
@property (nonatomic, assign, readonly) CGRect adressLabelF;
/** priseCountLabelF */
@property (nonatomic, assign, readonly) CGRect priseCountLabelF;
/** distanceLabelF */
@property (nonatomic, assign, readonly) CGRect distanceLabelF;
/** distanceLabelF */
@property (nonatomic, assign, readonly) CGRect separatorViewF;

@end
