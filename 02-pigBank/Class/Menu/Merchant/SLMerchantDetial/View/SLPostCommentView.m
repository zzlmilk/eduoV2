//
//  SLPostCommentView.m
//  02-pigBank
//
//  Created by 陆承东 on 14/10/27.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLPostCommentView.h"

@interface SLPostCommentView ()

@end

@implementation SLPostCommentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = SLColor(242, 242, 242);
        
        UIButton *postCommentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [postCommentButton setBackgroundImage:[UIImage imageNamed:@"pinLunAnNiu"] forState:UIControlStateNormal];
        [postCommentButton setTitle:@"发表评论" forState:UIControlStateNormal];
        [postCommentButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [postCommentButton setImage:[UIImage imageNamed:@"xie"] forState:UIControlStateNormal];
        postCommentButton.bounds = CGRectMake(0, 0, 158, 31);
        postCommentButton.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
        [postCommentButton addTarget:self action:@selector(postCommentButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:postCommentButton];
    }
    return self;
}

- (void)postCommentButtonClick:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(postCommentView:didClickPostCommentButton:)]) {
        [self.delegate postCommentView:self didClickPostCommentButton:button];
    }
}

@end
