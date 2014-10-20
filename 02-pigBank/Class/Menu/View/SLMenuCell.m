//
//  SLMenuCell.m
//  02-pigBank
//
//  Created by 陆承东 on 14-10-15.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLMenuCell.h"

@implementation SLMenuCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"moreItemCell";
    
    SLMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[SLMenuCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    return cell;
}

- (void)setMenuItem:(SLMenuItem *)menuItem
{
    _menuItem = menuItem;
    
    self.textLabel.text = menuItem.title;
    self.imageView.image = [UIImage imageNamed:menuItem.icon];
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.x = 5;
    frame.size.width -= 10;
    
    [super setFrame:frame];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
