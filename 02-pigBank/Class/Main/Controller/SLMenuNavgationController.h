//
//  SLMenuNavgationController.h
//  02-pigBank
//
//  Created by 陆承东 on 14/10/27.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ICSDrawerController.h"

@interface SLMenuNavgationController : UINavigationController <ICSDrawerControllerChild, ICSDrawerControllerPresenting>

@property(nonatomic, weak) ICSDrawerController *drawer;

@end
