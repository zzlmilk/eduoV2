//
//  SLVipProductArrorCell.m
//  02-pigBank
//
//  Created by 陆承东 on 14-9-24.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLVipProductArrorCell.h"

@implementation SLVipProductArrorCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
