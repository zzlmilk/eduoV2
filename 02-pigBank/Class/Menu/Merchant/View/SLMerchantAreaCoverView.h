//
//  SLMerchantAreaCoverView.h
//  02-pigBank
//
//  Created by 陆承东 on 14/10/21.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SLChildrenArea.h"

@class SLMerchantAreaCoverView;

@protocol SLMerchantAreaCoverViewDelegate <NSObject>

@optional
- (void)merchantAreaCoverView:(SLMerchantAreaCoverView *)merchantAreaCoverView didSelectedChildrenArea:(SLChildrenArea *)childrenArea;

@end

@interface SLMerchantAreaCoverView : UIView

@property (nonatomic, strong) NSArray *merchantChildAreaArray;

@property (nonatomic, weak) id<SLMerchantAreaCoverViewDelegate> delegate;

@end
