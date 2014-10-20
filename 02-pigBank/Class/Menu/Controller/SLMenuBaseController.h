//
//  SLMenuBaseController.h
//  02-pigBank
//
//  Created by 陆承东 on 14-10-15.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SLMenuGroup.h"

@interface SLMenuBaseController : UITableViewController

/** 菜单列表 */
@property (nonatomic, strong) NSMutableArray *menuGroups;

- (SLMenuGroup *)addGroup;

@end
