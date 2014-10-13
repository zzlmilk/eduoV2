//
//  SLHomeStatusFrame.h
//  02-pigBank
//
//  Created by 陆承东 on 14-9-18.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SLHomeStatusTitleFont [UIFont boldSystemFontOfSize:14]
#define SLHomeStatusPraiseCountsFont [UIFont systemFontOfSize:13]

@class SLHomeStatus;

@interface SLHomeStatusFrame : NSObject

@property (nonatomic, strong) SLHomeStatus *homeStatus;

/** dateLabelF */
@property (nonatomic, assign, readonly) CGRect dateLabelF;
/** extPicture 图标 */
@property (nonatomic, assign, readonly) CGRect extPictureViewF;
/** title */
@property (nonatomic, assign, readonly) CGRect titleLabelF;
/** 赞的图标 */
@property (nonatomic, assign, readonly) CGRect likeViewF;
/** praiseCounts */
@property (nonatomic, assign, readonly) CGRect praiseCountsLabelF;
/** cellHeight */
@property (nonatomic, assign, readonly) CGFloat cellHeight;

@end
