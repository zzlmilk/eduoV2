//
//  SLMerchantHeadCellFrame.h
//  02-pigBank
//
//  Created by 陆承东 on 14/10/23.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SLMerchantDetail.h"

@interface SLMerchantHeadCellFrame : NSObject

/** iconImageViewF */
@property (nonatomic, assign) CGRect iconImageViewF;

/** titleLabelF */
@property (nonatomic, assign) CGRect titleLabelF;

/** subTitleLabelF */
@property (nonatomic, assign) CGRect subTitleLabelF;

/** cellHeight */
@property (nonatomic, assign) CGFloat cellHeight;

@end
