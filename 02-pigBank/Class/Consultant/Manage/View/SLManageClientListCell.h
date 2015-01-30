//
//  SLManageClientListCell.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/28.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SLManageClientFrame.h"

@interface SLManageClientListCell : UITableViewCell

@property (nonatomic, strong) SLManageClientFrame *manageClientFrame;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
