//
//  SLMyCollectedMerchantCell.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/7.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SLMyMerchantCellFrame.h"

@interface SLMyCollectedMerchantCell : UITableViewCell

@property (nonatomic, strong) SLMyMerchantCellFrame *merchantStatusFrame;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
