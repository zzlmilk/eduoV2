//
//  SLWebViewCell.m
//  02-pigBank
//
//  Created by 陆承东 on 14/10/24.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLWebViewCell.h"

@implementation SLWebViewCell

#pragma mark - 初始化
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"SLWebViewCell";
    SLWebViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[SLWebViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
