//
//  SLClientListCell.m
//  02-pigBank
//
//  Created by 陆承东 on 15/1/19.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import "SLClientListCell.h"

#import "SLChangeAttentionParameters.h"

#import "SLUpImageButton.h"

#import "SLChangeAttentionTool.h"

@interface SLClientListCell ()

@property (nonatomic, weak) UIImageView *iconImageView;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *remarkLabel;
@property (nonatomic, weak) UIView *separatorView;
@property (nonatomic, weak) SLUpImageButton *attentionButton;

@end

@implementation SLClientListCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"SLClientListCell";
    
    SLClientListCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[SLClientListCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        // 1.添加status内部所有的子控件
        [self addSubviews];
    }
    return self;
}

#pragma mark ----- addSubviews添加所有子控件
- (void)addSubviews
{
    UIImageView *iconImageView = [[UIImageView alloc] init];
    self.iconImageView = iconImageView;
    [self.contentView addSubview:iconImageView];
    
    UILabel *nameLabel = [[UILabel alloc] init];
    self.nameLabel = nameLabel;
    [self.contentView addSubview:nameLabel];
    
    UILabel *remarkLabel = [[UILabel alloc] init];
    self.remarkLabel = remarkLabel;
    [self.contentView addSubview:remarkLabel];
    
    UIView *separatorView = [[UIView alloc] init];
    self.separatorView = separatorView;
    [self.contentView addSubview:separatorView];
    
    SLUpImageButton *attentionButton = [[SLUpImageButton alloc] init];
    self.attentionButton = attentionButton;
    [self.contentView addSubview:attentionButton];
}

- (void)setClientFrame:(SLClientFrame *)clientFrame
{
    _clientFrame = clientFrame;
    
    [self setSubviewsData];
}

#pragma mark ----- 设置子控件数据
- (void)setSubviewsData
{
    self.iconImageView.frame = self.clientFrame.iconImageViewF;
    [self.iconImageView setImageWithURL:[NSURL URLWithString:self.clientFrame.client.pictureUrl] placeholderImage:[UIImage imageNamed:@"moRenTouXiang"]];
    self.iconImageView.layer.cornerRadius = 5;
    self.iconImageView.clipsToBounds = YES;
    
    self.nameLabel.frame = self.clientFrame.nameLabelF;
    self.nameLabel.font = SLFont14;
    self.nameLabel.text = self.clientFrame.client.dispName;
    
    self.remarkLabel.frame = self.clientFrame.remarkLabelF;
    self.remarkLabel.font = SLFont12;
    self.remarkLabel.text = self.clientFrame.client.userRemark.remarkDesc;
    
    self.separatorView.frame = self.clientFrame.separatorViewF;
    self.separatorView.backgroundColor = [UIColor lightGrayColor];
    
    self.attentionButton.frame = self.clientFrame.attentionButtonF;
    [self.attentionButton setTitle:@"取消关注" forState:UIControlStateNormal];
    [self.attentionButton setTitleColor:SLLightGray forState:UIControlStateNormal];
    [self.attentionButton setImage:[UIImage imageNamed:@"icon_button_attention_normal"] forState:UIControlStateNormal];
    [self.attentionButton setTitle:@"关注" forState:UIControlStateSelected];
    [self.attentionButton setTitleColor:SLRed forState:UIControlStateSelected];
    [self.attentionButton setImage:[UIImage imageNamed:@"icon_button_attention_selected"] forState:UIControlStateSelected];
    self.attentionButton.selected = [self.clientFrame.client.userRemark.isAttention intValue];
    [self.attentionButton addTarget:self action:@selector(attentionButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)attentionButtonClicked:(UIButton *)attentionButton
{
    SLChangeAttentionParameters *parameters = [SLChangeAttentionParameters parameters];
    parameters.userId = self.clientFrame.client.userId;
    
    if (attentionButton.selected == YES) {
        parameters.attentionType = @"0";
        [SLChangeAttentionTool changeAttentionWithParameters:parameters success:^(SLResult *result) {
            if ([result.code isEqualToString:@"0000"]) {
                self.attentionButton.selected = NO;
                [MBProgressHUD showSuccess:@"取消关注成功"];
            }
        } failure:^(NSError *error) {
            
        }];
    } else {
        parameters.attentionType = @"1";
        [SLChangeAttentionTool changeAttentionWithParameters:parameters success:^(SLResult *result) {
            if ([result.code isEqualToString:@"0000"]) {
                self.attentionButton.selected = YES;
                [MBProgressHUD showSuccess:@"关注成功"];
            }
        } failure:^(NSError *error) {
            
        }];
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
