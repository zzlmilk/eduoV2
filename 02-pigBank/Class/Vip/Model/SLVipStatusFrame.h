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

/** pictureImageView */
@property (nonatomic, assign, readonly) CGRect pictureImageViewF;
/** titleLabel */
@property (nonatomic, assign, readonly) CGRect titleLabelF;
/** 赞的图标 */
@property (nonatomic, assign, readonly) CGRect likeViewF;
/** adressLabel */
@property (nonatomic, assign, readonly) CGRect adressLabelF;
/** priseCountLabel */
@property (nonatomic, assign, readonly) CGRect priseCountLabelF;

@end
