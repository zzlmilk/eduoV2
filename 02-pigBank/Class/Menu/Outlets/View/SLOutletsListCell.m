//
//  SLOutletsListCell.m
//  02-pigBank
//
//  Created by 陆承东 on 14-10-16.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLOutletsListCell.h"

@interface SLOutletsListCell()

@property (nonatomic, weak) UILabel *titleLabel;

@property (nonatomic, weak) UILabel *adressLabel;

@property (nonatomic, weak) UILabel *distanceLabel;


@end

@implementation SLOutletsListCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"outletsListCell";
    
    SLOutletsListCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[SLOutletsListCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 1.添加status内部所有的子控件
        [self setupStatusSubviews];
    }
    return self;
}

- (void)setupStatusSubviews
{
    /** distanceLabel */
    UILabel *distanceLabel = [[UILabel alloc] init];
    [self.contentView addSubview:distanceLabel];
    self.distanceLabel = distanceLabel;
}

- (void)setOutletsListFrame:(SLOutletsListFrame *)outletsListFrame
{
    _outletsListFrame = outletsListFrame;
    
    // 设置所有子控件的尺寸和数据
    [self setupSubviewsData];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect detailLabelFrame = self.detailTextLabel.frame;
    detailLabelFrame.size.width = 200;
    self.detailTextLabel.frame = detailLabelFrame;
}

- (void)setupSubviewsData
{
    double distance = [self.outletsListFrame.outletsInfo.outletsDetail.distanceToMe doubleValue] / 1000;
    self.textLabel.text = self.outletsListFrame.outletsInfo.title;
    self.detailTextLabel.text = self.outletsListFrame.outletsInfo.outletsDetail.address;
    
    /** distanceLabel */
    CGRect distanceLabelFrame = self.detailTextLabel.frame;
    distanceLabelFrame.origin.x = 220;
    distanceLabelFrame.size.width = 90;
    self.distanceLabel.frame = distanceLabelFrame;
    self.distanceLabel.font = SLFont12;
    self.distanceLabel.textAlignment = NSTextAlignmentRight;
    self.distanceLabel.textColor = [UIColor darkGrayColor];
    self.distanceLabel.text = [NSString stringWithFormat:@"%.2f千米", distance];
}

@end
