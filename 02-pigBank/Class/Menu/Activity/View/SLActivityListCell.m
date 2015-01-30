//
//  SLActivityListCell.m
//  02-pigBank
//
//  Created by 陆承东 on 15/1/19.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import "SLActivityListCell.h"

@interface SLActivityListCell ()

@property (nonatomic, weak) UILabel *activityStatusLabel;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *addressLabel;
@property (nonatomic, weak) UILabel *timeLabel;
@property (nonatomic, weak) UILabel *myJoinStatusLabel;

@end

@implementation SLActivityListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 1.添加status内部所有的子控件
        [self addSubviews];
    }
    return self;
}

#pragma mark -----快速创建cell的方法
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"SLActivityListCell";
    
    SLActivityListCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[SLActivityListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    return cell;
}

#pragma mark ----- 添加所有子控件
- (void)addSubviews
{
    /*
     @property (nonatomic, weak) UILabel *activityStatusLabel;
     @property (nonatomic, weak) UILabel *nameLabel;
     @property (nonatomic, weak) UILabel *addressLabel;
     @property (nonatomic, weak) UILabel *timeLabel;
     @property (nonatomic, weak) UILabel *myJoinStatusLabel;
     */
    UILabel *activityStatusLabel = [[UILabel alloc] init];
    self.activityStatusLabel = activityStatusLabel;
    [self.contentView addSubview:activityStatusLabel];
    
    UILabel *nameLabel = [[UILabel alloc] init];
    self.nameLabel = nameLabel;
    [self.contentView addSubview:nameLabel];
    
    UILabel *addressLabel = [[UILabel alloc] init];
    self.addressLabel = addressLabel;
    [self.contentView addSubview:addressLabel];
    
    UILabel *timeLabel = [[UILabel alloc] init];
    self.timeLabel = timeLabel;
    [self.contentView addSubview:timeLabel];
    
    UILabel *myJoinStatusLabel = [[UILabel alloc] init];
    self.myJoinStatusLabel = myJoinStatusLabel;
    [self.contentView addSubview:myJoinStatusLabel];
}

- (void)setActivityListCellFrame:(SLActivityListCellFrame *)activityListCellFrame
{
    _activityListCellFrame = activityListCellFrame;
    
    SLActivityList *activityList = activityListCellFrame.activityList;
    
    self.activityStatusLabel.frame = activityListCellFrame.activityStatusLabelF;
    self.activityStatusLabel.textAlignment = NSTextAlignmentCenter;
    self.activityStatusLabel.textColor = [UIColor whiteColor];
    self.activityStatusLabel.font = SLFont11;
    self.activityStatusLabel.text = activityList.status;
    if ([activityList.status isEqualToString:@"已结束"]) {
        self.activityStatusLabel.backgroundColor = SLColor(173, 176, 178);
    } else if ([activityList.status isEqualToString:@"进行中"]) {
        self.activityStatusLabel.backgroundColor = SLColor(49, 78, 183);
    } else if ([activityList.status isEqualToString:@"报名中"]) {
        self.activityStatusLabel.backgroundColor = SLColor(64, 144, 198);
    }
    self.activityStatusLabel.layer.cornerRadius = 3;
    self.activityStatusLabel.clipsToBounds = YES;
    
    self.nameLabel.frame = activityListCellFrame.nameLabelF;
    self.nameLabel.text = activityListCellFrame.activityList.title;
    self.nameLabel.font = SLBoldFont14;
    
    self.addressLabel.frame = activityListCellFrame.addressLabelF;
    self.addressLabel.text = [NSString stringWithFormat:@"活动地点:%@", activityListCellFrame.activityList.address];
    self.addressLabel.font = SLFont12;
    self.addressLabel.textColor = [UIColor darkGrayColor];
    
    self.timeLabel.frame = activityListCellFrame.timeLabelF;
    self.timeLabel.text = [NSString stringWithFormat:@"活动时间:%@", activityList.activityTime];
    self.timeLabel.font = SLFont12;
    self.timeLabel.textColor = [UIColor darkGrayColor];
    
    self.myJoinStatusLabel.frame = activityListCellFrame.myJoinStatusLabelF;
    if ([activityListCellFrame.activityList.isSign intValue] == 0) {
        self.myJoinStatusLabel.hidden = YES;
    } else {
        self.myJoinStatusLabel.hidden = NO;
        self.myJoinStatusLabel.text = @"已报名";
    }
    self.myJoinStatusLabel.font = SLFont11;
    self.myJoinStatusLabel.textColor = SLColor(42, 68, 154);
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
