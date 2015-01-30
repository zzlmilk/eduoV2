//
//  SLTagSelectView.m
//  carPark
//
//  Created by 陆承东 on 14/12/24.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLTagSelectView.h"

#import "SLUserTag.h"

#import "UIImage+S_LINE.h"
#import "NSString+S_LINE.h"

@interface SLTagSelectView ()

@property (nonatomic, strong) NSArray *tagStrArray;

@property (nonatomic, assign) CGFloat width;

@property (nonatomic, strong) NSMutableArray *tagButtonArray;

@property (nonatomic, assign) CGRect lastButtonFrame;

@end

@implementation SLTagSelectView

- (NSMutableArray *)tagButtonArray
{
    if (_tagButtonArray == nil) {
        _tagButtonArray = [NSMutableArray array];
    }
    return _tagButtonArray;
}

#pragma mark ----- addTags添加标签
- (void)addTagWidth:(CGFloat)width tagStrArray:(NSArray *)tagStrArray
{
    for (SLScreenButton *screenButton in self.tagButtonArray) {
        [screenButton removeFromSuperview];
    }
    [self.tagButtonArray removeAllObjects];
    
    self.width = width;
    self.tagStrArray = tagStrArray;
    self.lastButtonFrame = CGRectMake(0, 10, 0, 0);
    
    [self setSubviewData];
}

#pragma mark ----- setSubviewData
- (void)setSubviewData
{
    for (int i = 0; i < self.tagStrArray.count; i++) {
        SLUserTag *userTag = self.tagStrArray[i];
        NSString *tagString = userTag.tagText;
        
        SLScreenButton *screenButton = [[SLScreenButton alloc] init];
        screenButton.enabled = NO;
        [screenButton setTitle:tagString forState:UIControlStateNormal];
        [screenButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [screenButton setBackgroundColor:SLColor(arc4random()%255, arc4random()%255, arc4random()%255)];
        screenButton.titleLabel.font = SLFont14;
        
        CGFloat screenButtonW = [tagString sizeWithFont:SLFont14 maxSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)].width + largeMargin + smallMargin;
        CGFloat judge = CGRectGetMaxX(self.lastButtonFrame) + screenButtonW + middleMargin * 2;
        CGFloat screenButtonX;
        CGFloat screenButtonY;
        if (judge > (self.width)) {
            screenButtonX = middleMargin;
            screenButtonY = CGRectGetMaxY(self.lastButtonFrame) + middleMargin;
        } else {
            screenButtonX = CGRectGetMaxX(self.lastButtonFrame) + middleMargin;
            screenButtonY = self.lastButtonFrame.origin.y;
        }
        CGFloat screenButtonH = 25;
        CGRect screenButtonF = CGRectMake(screenButtonX, screenButtonY, screenButtonW, screenButtonH);
        screenButton.frame = screenButtonF;
        
        if ([tagString isEqualToString:@"编辑标签"]) {
            [screenButton addTarget:self action:@selector(screenButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [screenButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [screenButton setImage:[UIImage imageNamed:@"icon_button_modify"] forState:UIControlStateNormal];
            screenButton.enabled = YES;
            [screenButton setBackgroundColor:[UIColor clearColor]];
        }
        
        [self.tagButtonArray addObject:screenButton];
        [self addSubview:screenButton];
        self.lastButtonFrame = screenButtonF;
    }
}

#pragma mark ----- tagButtonClicked:标签的点击事件
- (void)screenButtonClicked:(SLScreenButton *)tagButton
{
    if ([self.delegate respondsToSelector:@selector(tagSelectedView:didSelectedScreenButton:)]) {
        [self.delegate tagSelectedView:self didSelectedScreenButton:tagButton];
    }
}

- (CGFloat)getHeight
{
    return CGRectGetMaxY(self.lastButtonFrame);
}

@end
