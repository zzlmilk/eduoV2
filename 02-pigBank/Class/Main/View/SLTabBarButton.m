//
//  SLTabBarButton.m
//  02-pigBank
//
//  Created by 陆承东 on 14-9-13.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLTabBarButton.h"
#import "UIImage+S_LINE.h"
#import "SLBadgeButton.h"

#define SLTabBarButtonImageRatio 0.65
#define SLTabBarButtonTitleRatio 0.3

@interface SLTabBarButton()

@property (nonatomic, weak) SLBadgeButton *badgeButton;

@end

@implementation SLTabBarButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 设置button的属性
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        // 设置tabBar的文字颜色
        [self setTitleColor:SLColor(55, 60, 68) forState:UIControlStateNormal];
        [self setTitleColor:SLColor(122, 24, 124) forState:UIControlStateSelected];
        // Initialization code
        
        // 设置badgeButton的属性
        SLBadgeButton *badgeButton = [[SLBadgeButton alloc] init];
        badgeButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        
        [self addSubview:badgeButton];
        self.badgeButton = badgeButton;
    }
    return self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageX = 0;
    CGFloat imageY = 0;
    CGFloat imageW = self.bounds.size.width;
    CGFloat imageH = self.bounds.size.height * SLTabBarButtonImageRatio;
    return CGRectMake(imageX, imageY, imageW, imageH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat imageX = 0;
    CGFloat imageY = self.bounds.size.height * SLTabBarButtonImageRatio;
    CGFloat imageW = self.bounds.size.width;
    CGFloat imageH = self.bounds.size.height * SLTabBarButtonTitleRatio;
    return CGRectMake(imageX, imageY, imageW, imageH);
}

- (void)setItem:(UITabBarItem *)item
{
    _item = item;
    
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
    
    [item addObserver:self forKeyPath:@"badgeValue" options:0 context:nil];
    [item addObserver:self forKeyPath:@"title" options:0 context:nil];
    [item addObserver:self forKeyPath:@"image" options:0 context:nil];
    [item addObserver:self forKeyPath:@"selectedImage" options:0 context:nil];
}

- (void)dealloc
{
    [self.item removeObserver:self forKeyPath:@"badgeValue"];
    [self.item removeObserver:self forKeyPath:@"title"];
    [self.item removeObserver:self forKeyPath:@"image"];
    [self.item removeObserver:self forKeyPath:@"selectedImage"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    // 设置标题
    [self  setTitle:self.item.title forState:UIControlStateNormal];
    [self  setTitle:self.item.title forState:UIControlStateSelected];
    
    // 设置背景图片
    [self setImage:self.item.image forState:UIControlStateNormal];
    [self setImage:self.item.selectedImage forState:UIControlStateSelected];
    
    // 设置右上角小按钮
    self.badgeButton.badgeValue = self.item.badgeValue;
    
    // 设置按钮位置
    CGRect badgeF = self.badgeButton.frame;
    CGFloat badgeX = self.frame.size.width - badgeF.size.width - 10;
    CGFloat badgeY = 0;
    badgeF.origin.x = badgeX;
    badgeF.origin.y = badgeY;
    self.badgeButton.frame = badgeF;
    
}

- (void)setHighlighted:(BOOL)highlighted
{
    
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
