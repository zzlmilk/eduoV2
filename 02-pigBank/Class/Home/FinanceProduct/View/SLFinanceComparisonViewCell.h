//
//  SLFinanceComparisonViewCell.h
//  02-pigBank
//
//  Created by 陆承东 on 14-9-22.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SLFinanceComparisonViewCellFont [UIFont systemFontOfSize:11]

@interface SLFinanceComparisonViewCell : UITableViewCell

@property (nonatomic, assign) double incomeRatio;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
