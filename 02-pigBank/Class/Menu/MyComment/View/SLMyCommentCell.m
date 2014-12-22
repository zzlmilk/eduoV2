//
//  SLMyCommentCell.m
//  02-pigBank
//
//  Created by 陆承东 on 14/12/13.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLMyCommentCell.h"

#define gap 3

@interface SLMyCommentCell ()

@property (nonatomic, weak) UIImageView *iconImageView;

@property (nonatomic, weak) UILabel *merchantNameLabel;

@property (nonatomic, weak) UIImageView *accessoryImageView;

@property (nonatomic, weak) UIImageView *separatorImageView;

@end

@implementation SLMyCommentCell

#pragma mark ------ cellWithTableView cell的快速创建方法a
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"myCommentCell";
    
    SLMyCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[SLMyCommentCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 1.添加status内部所有的子控件
        [self setupStatusSubviews];
    }
    return self;
}

#pragma mark ----- setupStatusSubviews添加cell内部所有子控件
- (void)setupStatusSubviews
{
    UIImageView *iconImageView = [[UIImageView alloc] init];
    [self addSubview:iconImageView];
    self.iconImageView = iconImageView;
    
    UILabel *merchantNameLabel = [[UILabel alloc] init];
    [self addSubview:merchantNameLabel];
    self.merchantNameLabel = merchantNameLabel;
    
    UIImageView *accessoryImageView = [[UIImageView alloc] init];
    [self addSubview:accessoryImageView];
    self.accessoryImageView = accessoryImageView;
    
    UIImageView *separatorImageView = [[UIImageView alloc] init];
    [self addSubview:separatorImageView];
    self.separatorImageView = separatorImageView;
}

#pragma mark ----- myCommentStatusFrame的set方法
- (void)setMyCommentStatusFrame:(SLMyCommentStatusFrame *)myCommentStatusFrame
{
    _myCommentStatusFrame = myCommentStatusFrame;
    
    [self setSubviewsData];
}

#pragma mark ----- setSubviewsData设置所有子控件的数据
- (void)setSubviewsData
{
    CGFloat iconImageViewX = middleMargin;
    CGFloat iconImageViewY = gap;
    CGFloat iconImageViewW = 29;
    CGFloat iconImageViewH = 29;
    CGRect iconImageViewF = CGRectMake(iconImageViewX, iconImageViewY, iconImageViewW, iconImageViewH);
    self.iconImageView.frame = self.myCommentStatusFrame.iconImageViewF;
    self.iconImageView.image = [UIImage imageNamed:@"shangQuan"];
    
    CGFloat merchantNameLabelX = CGRectGetMaxX(iconImageViewF) + middleMargin;
    CGFloat merchantNameLabelY = iconImageViewY;
    CGFloat merchantNameLabelW = screenW - merchantNameLabelX - 40;
    CGFloat merchantNameLabelH = iconImageViewH;
    CGRect merchantNameLabelF = CGRectMake(merchantNameLabelX, merchantNameLabelY, merchantNameLabelW, merchantNameLabelH);
    self.merchantNameLabel.frame = self.myCommentStatusFrame.merchantNameLabelF;
    self.merchantNameLabel.font = SLBoldFont14;
    self.merchantNameLabel.text = self.myCommentStatusFrame.myCommentStatus.merchantName;
    
    CGFloat accessoryImageViewX = screenW - 7 - middleMargin;
    CGFloat accessoryImageViewY = merchantNameLabelY;
    CGFloat accessoryImageViewW = 7;
    CGFloat accessoryImageViewH = merchantNameLabelH;
    CGRect accessoryImageViewF = CGRectMake(accessoryImageViewX, accessoryImageViewY, accessoryImageViewW, accessoryImageViewH);
    self.accessoryImageView.frame = self.myCommentStatusFrame.accessoryImageViewF;
    self.accessoryImageView.contentMode = UIViewContentModeCenter;
    self.accessoryImageView.image = [UIImage imageNamed:@"jianTou"];
    
    CGFloat separatorImageViewX = 0;
    CGFloat separatorImageViewY = CGRectGetMaxY(iconImageViewF) + gap;
    CGFloat separatorImageViewW = screenW;
    CGFloat separatorImageViewH = 9;
    CGRect separatorImageViewF = CGRectMake(separatorImageViewX, separatorImageViewY, separatorImageViewW, separatorImageViewH);
    self.separatorImageView.frame = self.myCommentStatusFrame.separatorImageViewF;
    self.separatorImageView.image = [UIImage imageNamed:@"jianJiaoXian"];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
