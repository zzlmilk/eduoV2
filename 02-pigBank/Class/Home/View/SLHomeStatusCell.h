//
//  SLHomeStatusCell.h
//  02-pigBank
//
//  Created by 陆承东 on 14-9-18.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SLHomeStatusFrame;

@interface SLHomeStatusCell : UITableViewCell

@property (nonatomic, strong) SLHomeStatusFrame *homeStatusFrame;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
