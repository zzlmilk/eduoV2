//
//  SLMerchantCell.h
//  02-pigBank
//
//  Created by 陆承东 on 14/10/21.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SLMerchantStatusFrame.h"

@interface SLMerchantCell : UITableViewCell

@property (nonatomic, strong) SLMerchantStatusFrame *merchantStatusFrame;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
