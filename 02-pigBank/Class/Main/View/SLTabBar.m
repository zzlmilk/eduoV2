//
//  SLTabBar.m
//  02-pigBank
//
//  Created by 陆承东 on 14-9-14.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLTabBar.h"
#import "SLTabBarButton.h"

@interface SLTabBar ()

@property (nonatomic, weak) SLTabBarButton *selectedButton;

@end

@implementation SLTabBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // Initialization code
    }
    return self;
}

- (void)addTabBarButtonWithItem:(UITabBarItem *)item
{
    SLTabBarButton *button = [[SLTabBarButton alloc] init];
    [self addSubview:button];
    
    // 给新创建的按钮传递数据
    button.item = item;
    
//    // 给button设置数据
//    [button setTitle:item.title forState:UIControlStateNormal];
//    [button setImage:item.image forState:UIControlStateNormal];
//    [button setImage:item.selectedImage forState:UIControlStateSelected];
    
    // 监听按钮点击
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
}

- (void)buttonClick:(SLTabBarButton *)button
{
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectedFrom:to:)]) {
        [self.delegate tabBar:self didSelectedFrom:self.selectedButton.tag to:button.tag];
    }
    
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat buttonY = 0;
    CGFloat buttonW = self.frame.size.width / self.subviews.count;
    CGFloat buttonH = self.frame.size.height;
    
    for (int index = 0; index < self.subviews.count; index++) {
        // 1.取出按钮
        SLTabBarButton *button = self.subviews[index];
        
        // 设置按钮的frame
        CGFloat buttonX = buttonW * index;
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        // 给按钮绑定tag
        button.tag = index;
        
        if (index == 0) {
            [self buttonClick:button];
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
