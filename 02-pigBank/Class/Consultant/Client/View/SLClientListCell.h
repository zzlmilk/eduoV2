//
//  SLClientListCell.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/19.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SLClientFrame.h"

@interface SLClientListCell : UITableViewCell

@property (nonatomic, strong) SLClientFrame *clientFrame;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
