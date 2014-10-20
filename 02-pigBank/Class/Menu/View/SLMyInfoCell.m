//
//  SLMyInfoCell.m
//  02-pigBank
//
//  Created by 陆承东 on 14-10-15.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLMyInfoCell.h"

#import "UIImageView+WebCache.h"

#import "SLAccountTool.h"

@interface SLMyInfoCell()

@end

@implementation SLMyInfoCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"MyInfoCell";
    
    SLMyInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[SLMyInfoCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.x = 5;
    frame.size.width -= 10;
    
    [super setFrame:frame];
}

- (void)setMenuItem:(SLMenuItem *)menuItem
{
    _menuItem = menuItem;
    
    self.textLabel.text = menuItem.title;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@", [SLAccountTool getAccount].accountInfo.pictureUrl]];
    self.imageView.layer.cornerRadius = 5;
    self.imageView.layer.masksToBounds = YES;
    self.imageView.userInteractionEnabled = YES;
    [self.imageView setImageWithURL:url placeholderImage:[UIImage imageNamed:menuItem.icon]];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 更改imageView的frame
    CGRect frame = self.imageView.frame;
    frame.size.height -= 6;
    frame.size.width -= 6;
    frame.origin.x += 3;
    frame.origin.y += 3;
    self.imageView.frame = frame;
}

- (void)awakeFromNib {
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconImageViewTap:)]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
