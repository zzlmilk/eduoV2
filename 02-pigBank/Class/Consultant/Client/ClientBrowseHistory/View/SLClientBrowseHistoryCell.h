//
//  SLClientBrowseHistoryCell.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/21.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SLMaterialBrowseHistoryFrame.h"

@interface SLClientBrowseHistoryCell : UITableViewCell

@property (nonatomic, strong) SLMaterialBrowseHistoryFrame *materialBrowseHistoryFrame;

#pragma mark ----- 快速创建cell的方法
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
