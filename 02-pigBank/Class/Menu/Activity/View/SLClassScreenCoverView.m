//
//  SLClassScreenCoverView.m
//  02-pigBank
//
//  Created by 陆承东 on 15/1/22.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import "SLClassScreenCoverView.h"

#import "SLClassInfo.h"

#import "SLScreenButton.h"

#import "NSString+S_LINE.h"
#import "UIImage+S_LINE.h"

@interface SLClassScreenCoverView ()

@property (nonatomic, strong) NSMutableArray *screenButtonArray;
@property (nonatomic, weak) SLScreenButton *selectedScreenButton;

@property (nonatomic, weak) UIView *bgView;

@property (nonatomic, assign) CGRect lastButtonFrame;
@property (nonatomic, assign) CGFloat width;

@end

@implementation SLClassScreenCoverView

- (NSMutableArray *)screenButtonArray
{
    if (_screenButtonArray == nil) {
        _screenButtonArray = [NSMutableArray array];
    }
    return _screenButtonArray;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = SLColorRGBA(0, 0, 0, 0.5);
    }
    return self;
}

- (void)setClassesArray:(NSArray *)classesArray
{
    _classesArray = classesArray;
    
    self.lastButtonFrame = CGRectMake(0, 10, 0, 0);
    self.width = screenW - largeMargin;
    
    [self addSubviews];
}

- (void)addSubviews
{
    UIView *bgView = [[UIView alloc] init];
    self.bgView = bgView;
    [self addSubview:bgView];
    
    for (int i = 0; i < self.classesArray.count; i++) {
        SLClassInfo *classInfo = self.classesArray[i];
        SLScreenButton *screenButton = [[SLScreenButton alloc] init];
        [screenButton addTarget:self action:@selector(screenButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        screenButton.classInfo = classInfo;
        [self.screenButtonArray addObject:screenButton];
        [self addSubview:screenButton];
    }
    
    [self setSubviewsData];
}

#pragma mark ----- 设置所有子控件数据
- (void)setSubviewsData
{
    for (int i = 0; i < self.classesArray.count; i++) {
        
        SLClassInfo *classInfo = self.classesArray[i];
        SLScreenButton *screenButton = self.screenButtonArray[i];
        [screenButton setTitle:classInfo.className forState:UIControlStateNormal];
        [screenButton setTitleColor:SLLightGray forState:UIControlStateNormal];
        [screenButton setTitleColor:SLRed forState:UIControlStateSelected];
        screenButton.titleLabel.font = SLFont14;
        
        CGFloat screenButtonW = [classInfo.className sizeWithFont:SLFont14 maxSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)].width + largeMargin + smallMargin;
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
        [screenButton setBackgroundImage:[UIImage resizableImageWithImageName:@"icon_button_screen"] forState:UIControlStateNormal];
        
        if ([screenButton.titleLabel.text isEqualToString:@"全部"]) {
            screenButton.selected = YES;
            self.selectedScreenButton = screenButton;
        }
        
        self.lastButtonFrame = screenButtonF;
    }
    
    self.bgView.frame = CGRectMake(0, 0, screenW, CGRectGetMaxY(self.lastButtonFrame) + middleMargin);
    self.bgView.backgroundColor = [UIColor whiteColor];
}

- (void)screenButtonClicked:(SLScreenButton *)screenButton
{
    self.selectedScreenButton.selected = NO;
    screenButton.selected = YES;
    self.selectedScreenButton = screenButton;
    
    if ([self.delegate respondsToSelector:@selector(classScreenCoverView:didSelectedClassId:)]) {
        [self.delegate classScreenCoverView:self didSelectedClassId:screenButton.classInfo.classId];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([self.delegate respondsToSelector:@selector(classScreenCoverViewDidTouchCoverView:)]) {
        [self.delegate classScreenCoverViewDidTouchCoverView:self];
    }
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{}

@end
