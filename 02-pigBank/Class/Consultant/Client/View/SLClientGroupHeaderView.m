//
//  SLClientGroupHeaderView.m
//  02-pigBank
//
//  Created by 陆承东 on 15/1/19.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import "SLClientGroupHeaderView.h"

@interface SLClientGroupHeaderView()

@property (nonatomic, weak) UIButton *titleButton;

@end

@implementation SLClientGroupHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+ (SLClientGroupHeaderView *)headerViewWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"SLClientGroupHeaderView";
    
    SLClientGroupHeaderView *headerView = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (headerView == nil)
    {
        headerView = [[SLClientGroupHeaderView alloc] initWithReuseIdentifier:ID];
    }
    return headerView;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置button的frame
    self.titleButton.frame = self.bounds;
}

#pragma mark ----- 在初始化方法中，headerView的frame和bounds没有值
- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier])
    {
        // 添加一个按钮
        UIButton *titleButton = [[UIButton alloc] init];
        [self.contentView addSubview:titleButton];
        [titleButton setBackgroundImage:[UIImage imageNamed:@"buddy_header_bg"] forState:UIControlStateNormal];
        [titleButton setBackgroundImage:[UIImage imageNamed:@"buddy_header_bg_highlighted"] forState:UIControlStateHighlighted];
        [titleButton setImage:[UIImage imageNamed:@"buddy_header_arrow"] forState:UIControlStateNormal];
        [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        titleButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        titleButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        titleButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        titleButton.titleLabel.font = SLFont14;
        
        [titleButton addTarget:self action:@selector(titleButtonClick) forControlEvents:UIControlEventTouchUpInside];
        titleButton.imageView.contentMode = UIViewContentModeCenter;
        titleButton.imageView.clipsToBounds = NO;
        self.titleButton = titleButton;
        
    }
    return self;
}

- (void)titleButtonClick
{
    // 标志位取反
    self.clientGroup.open = !self.clientGroup.open;
    
    // 刷新表格（通知代理刷新表格）
    if ([self.delegate respondsToSelector:@selector(clientGroupHeaderViewDidClickTitleButton:)]) {
        [self.delegate clientGroupHeaderViewDidClickTitleButton:self];
    }
}

- (void)setClientGroup:(SLClientGroup *)clientGroup
{
    _clientGroup = clientGroup;
    
    [self.titleButton setTitle:[NSString stringWithFormat:@"%@ (%lu)", clientGroup.groupName, (unsigned long)clientGroup.userList.count] forState:UIControlStateNormal];
    
    [self didMoveToSuperview];
}

#pragma mark ----- 当一个控件被添加到父控件中就会调用
-(void)didMoveToSuperview
{
    if (self.clientGroup.open == YES) {
        self.titleButton.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
    } else {
        self.titleButton.imageView.transform = CGAffineTransformMakeRotation(0);
    }
}

@end
