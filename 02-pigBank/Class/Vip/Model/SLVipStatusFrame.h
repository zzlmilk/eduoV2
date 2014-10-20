//
//  SLVipStatusFrame.h
//  02-pigBank
//
//  Created by 陆承东 on 14-9-23.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SLVipStatus.h"

@interface SLVipStatusFrame : NSObject

/** vipStatus */
@property (nonatomic, strong) SLVipStatus *vipStatus;

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
