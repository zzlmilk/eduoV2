//
//  SLConsultantDetailIconCell.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/12.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SLConsultant.h"

@class SLConsultantDetailIconCell;

@protocol SLConsultantDetailIconCellDelegate <NSObject>

@optional
- (void)consultantDetailIconCell:(SLConsultantDetailIconCell *)consultantDetailIconCell didClickSelectButton:(UIButton *)selectButton;

@end

@interface SLConsultantDetailIconCell : UITableViewCell

@property (nonatomic, strong) SLConsultant *consultant;

@property (nonatomic, weak) id<SLConsultantDetailIconCellDelegate> delegate;

/**
 *  快速创建cell的方法
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
