//
//  SLVipStatusCell.h
//  02-pigBank
//
//  Created by 陆承东 on 14-9-23.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SLVipStatusFrame;

@interface SLVipStatusCell : UITableViewCell

@property (nonatomic, strong) SLVipStatusFrame *vipStatusFrame;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
