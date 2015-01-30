//
//  SLMaterialBrowseHistoryFrame.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/22.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SLMaterial.h"

@interface SLMaterialBrowseHistoryFrame : NSObject

@property (nonatomic, assign, readonly) CGRect iconImageViewF;
@property (nonatomic, assign, readonly) CGRect titleLabelF;
@property (nonatomic, assign, readonly) CGRect priseImageViewF;
@property (nonatomic, assign, readonly) CGRect collectImageViewF;
@property (nonatomic, assign, readonly) CGRect timeLabelF;

@property (nonatomic, strong) SLMaterial *material;

@end
