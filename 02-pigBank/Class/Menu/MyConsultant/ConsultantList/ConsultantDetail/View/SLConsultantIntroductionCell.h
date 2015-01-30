//
//  SLConsultantIntroductionCell.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/12.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SLConsultant.h"

@interface SLConsultantIntroductionCell : UITableViewCell

@property (nonatomic, strong) SLConsultant *consultant;

/**
 *  快速创建cell的方法
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end