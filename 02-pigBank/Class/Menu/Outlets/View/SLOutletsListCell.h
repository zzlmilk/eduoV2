//
//  SLOutletsListCell.h
//  02-pigBank
//
//  Created by 陆承东 on 14-10-16.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SLOutletsListFrame.h"

@interface SLOutletsListCell : UITableViewCell

@property (nonatomic, strong) SLOutletsListFrame *outletsListFrame;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end