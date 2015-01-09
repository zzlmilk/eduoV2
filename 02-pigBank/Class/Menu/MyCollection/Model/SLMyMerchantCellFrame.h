//
//  SLMyMerchantCellFrame.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/7.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SLMerchantStatus.h"

@interface SLMyMerchantCellFrame : NSObject

@property (nonatomic, strong) SLMerchantStatus *merchantDetial;

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

@end
