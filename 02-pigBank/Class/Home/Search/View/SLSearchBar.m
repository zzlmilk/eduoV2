//
//  SLSearchBar.m
//  02-pigBank
//
//  Created by 陆承东 on 14-9-15.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLSearchBar.h"
#import "UIImage+S_LINE.h"

@interface SLSearchBar ()



@end

@implementation SLSearchBar

+ (instancetype)searchBar
{
    return [[self alloc] init];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        // 设置搜索框背景图片
        self.background = [UIImage resizableImageWithImageName:@"qingKong"];
//        self.background = [UIImage imageNamed:@"qingKong"];
        
        // 设置最左边的放大镜搜索icon
        UIImageView *searchIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"souSuo"]];
        searchIcon.contentMode = UIViewContentModeCenter;
        // UITextField有leftView属性,可以在UITextField的最右边设置一个自定义view
        self.leftView = searchIcon;
        // 需要设置leftViewMode为一直显示才可以显示
        self.leftViewMode = UITextFieldViewModeAlways;
        
        // 字体
        self.font = [UIFont systemFontOfSize:13];
        
        // 右边清除按钮
        self.clearButtonMode = UITextFieldViewModeAlways;
        
        // 设置提醒文字
        NSMutableDictionary *attri = [NSMutableDictionary dictionary];
        attri[NSForegroundColorAttributeName] = [UIColor grayColor];
        self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"搜索" attributes:attri];
        
        // 设置键盘右下角按钮的样式
        self.returnKeyType = UIReturnKeySearch;
        self.enablesReturnKeyAutomatically = YES;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.leftView.frame = CGRectMake(0, 0, 30, self.frame.size.height);
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
