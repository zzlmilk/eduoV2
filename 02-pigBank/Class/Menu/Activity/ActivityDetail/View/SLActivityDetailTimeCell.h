//
//  SLActivityDetailTimeCell.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/22.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SLActivityDetailFrame.h"

@interface SLActivityDetailTimeCell : UITableViewCell

@property (nonatomic, strong) SLActivityDetailFrame *activityDetailFrame;

#pragma mark ----- 快速创建cell的方法
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
