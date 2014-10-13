//
//  SLFinancialProductListCell.h
//  02-pigBank
//
//  Created by 陆承东 on 14-9-27.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SLFinancialStatusFrame.h"

@interface SLFinancialProductListCell : UITableViewCell

@property (nonatomic, strong) SLFinancialStatusFrame *financialStatusFrame;

/**
 *  快速创建cell的方法
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
