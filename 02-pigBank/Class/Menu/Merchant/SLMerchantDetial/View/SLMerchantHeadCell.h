//
//  SLMerchantHeadCell.h
//  02-pigBank
//
//  Created by 陆承东 on 14/10/23.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SLMerchantDetailItem.h"

@interface SLMerchantHeadCell : UITableViewCell

@property (nonatomic, strong) SLMerchantDetailItem *item;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
