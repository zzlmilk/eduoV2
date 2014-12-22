//
//  SLMyCommentCell.h
//  02-pigBank
//
//  Created by 陆承东 on 14/12/13.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SLMyCommentStatusFrame.h"

@interface SLMyCommentCell : UITableViewCell

@property (nonatomic, strong) SLMyCommentStatusFrame *myCommentStatusFrame;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
