//
//  SLMyInfoCell.h
//  02-pigBank
//
//  Created by 陆承东 on 14-10-15.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SLMenuItem.h"

@class SLMyInfoCell;

@interface SLMyInfoCell : UITableViewCell

@property (nonatomic, strong) SLMenuItem *menuItem;

@property (nonatomic, strong) NSIndexPath *indexPath;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
