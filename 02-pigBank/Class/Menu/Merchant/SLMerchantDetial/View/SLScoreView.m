//
//  SLScoreView.m
//  02-pigBank
//
//  Created by 陆承东 on 14/10/24.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLScoreView.h"

@interface SLScoreView ()

@property (nonatomic, strong) NSMutableArray *imageViewArray;

@end

@implementation SLScoreView

- (NSMutableArray *)imageViewArray
{
    if (_imageViewArray == nil) {
        _imageViewArray = [NSMutableArray array];
    }
    return _imageViewArray;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 初始化5个子控件
        for (int i = 0; i < 5; i++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(16 * i, 0, 16, 16)];
            imageView.tag = i;
            imageView.image = [UIImage imageNamed:@"pingFenXin"];
            [self.imageViewArray addObject:imageView];
            [self addSubview:imageView];
        }
    }
    return self;
}

- (void)setScore:(long)score
{
    _score = score;
    
    for (int i = 0; i < score; i++) {
        for (UIImageView *imageView in self.imageViewArray) {
            while (imageView.tag == i) {
                imageView.image = [UIImage imageNamed:@"pingFenXinJiaoHu"];
            }
        }
    }
}

@end
