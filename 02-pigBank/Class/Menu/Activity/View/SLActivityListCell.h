//
//  SLActivityListCell.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/19.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SLActivityListCellFrame.h"

@interface SLActivityListCell : UITableViewCell

@property (nonatomic, strong) SLActivityListCellFrame *activityListCellFrame;

#pragma mark ----- 快速创建cell的方法
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
