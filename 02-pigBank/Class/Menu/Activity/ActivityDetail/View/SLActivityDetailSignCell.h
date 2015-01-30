//
//  SLActivityDetailSignCell.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/21.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SLActivityDetail.h"

@class SLActivityDetailSignCell;

@protocol SLActivityDetailSignCellDelegate <NSObject>

@optional
- (void)activityDetailSignCell:(SLActivityDetailSignCell *)activityDetailSignCell didClickedSignButton:(UIButton *)signButton;

@end

@interface SLActivityDetailSignCell : UITableViewCell

@property (nonatomic, strong) SLActivityDetail *activityDetail;

@property (nonatomic, weak) id<SLActivityDetailSignCellDelegate> delegate;

#pragma mark ----- 快速创建cell的方法
+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (void)setButtonDisable;

@end
