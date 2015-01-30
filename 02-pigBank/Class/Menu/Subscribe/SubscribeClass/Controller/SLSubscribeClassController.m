//
//  SLSubscribeClassController.m
//  02-pigBank
//
//  Created by 陆承东 on 15/1/23.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import "SLSubscribeClassController.h"

#import "SLSubscribeClass.h"

#import "SLScreenButton.h"
#import "SLBackButton.h"

#import "SLSubscribeTool.h"
#import "NSString+S_LINE.h"
#import "UIImage+S_LINE.h"

#import "MBProgressHUD+MJ.h"

@interface SLSubscribeClassController ()

@property (nonatomic, strong) NSArray *subscribeClassArray;
@property (nonatomic, strong) NSMutableArray *screenButtonArray;

@property (nonatomic, assign) CGRect lastButtonFrame;
@property (nonatomic, assign) CGFloat width;

@end

@implementation SLSubscribeClassController

- (NSMutableArray *)screenButtonArray
{
    if (_screenButtonArray == nil) {
        _screenButtonArray = [NSMutableArray array];
    }
    return _screenButtonArray;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setNavBar];
}

#pragma mark ----- 设置导航栏样式
- (void)setNavBar
{
    SLBackButton *backButton = [SLBackButton button];
    [backButton addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backItem;
}

#pragma mark ----- backButtonClicked返回按钮点击事件
- (void)backButtonClicked:(SLBackButton *)backButton
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];self.lastButtonFrame = CGRectZero;
    self.width = screenW - largeMargin;
    
    [self loadInternetData];
}

#pragma mark ----- 加载网络数据
- (void)loadInternetData
{
    SLBaseParameters *parameters = [SLBaseParameters parameters];
    
    [SLSubscribeTool subscribeClassWithParameters:parameters success:^(NSArray *subscribeClassArray) {
        
        self.subscribeClassArray = subscribeClassArray;
        
        [self addSubViews];
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)addSubViews
{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(middleMargin, middleMargin + 64, screenW - largeMargin, 16)];
    titleLabel.font = SLBoldFont16;
    titleLabel.text = @"订阅选择";
    [self.view addSubview:titleLabel];
    
    UIView *selectBgView = [[UIView alloc] init];
    [self.view addSubview:selectBgView];
    
    for (int i = 0; i < self.subscribeClassArray.count; i++) {
        
        SLSubscribeClass *subscribeClass = self.subscribeClassArray[i];
        SLScreenButton *screenButton = [[SLScreenButton alloc] init];
        [screenButton addTarget:self action:@selector(screenButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        screenButton.subscribeClass = subscribeClass;
        
        [screenButton setTitle:subscribeClass.labelName forState:UIControlStateNormal];
        [screenButton setTitleColor:SLLightGray forState:UIControlStateNormal];
        [screenButton setTitleColor:SLRed forState:UIControlStateSelected];
        screenButton.titleLabel.font = SLFont14;
        
        CGFloat screenButtonW = [subscribeClass.labelName sizeWithFont:SLFont14 maxSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)].width + largeMargin + smallMargin;
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
        
        if ([subscribeClass.isChk intValue] == 0) {
            screenButton.selected = NO;
        } else {
            screenButton.selected = YES;
        }
//        [screenButton.layer setBorderWidth:2];
//        CGColorSpaceRef colorSpace=CGColorSpaceCreateDeviceRGB();
//        CGColorRef colorRef=CGColorCreate(colorSpace, (CGFloat[]){1,0,0,2});
//        [screenButton.layer setBorderColor:colorRef];

        
        [self.screenButtonArray addObject:screenButton];
        [selectBgView addSubview:screenButton];
        self.lastButtonFrame = screenButtonF;
    }
    
    CGFloat selectBgViewX = middleMargin;
    CGFloat selectBgViewY = CGRectGetMaxY(titleLabel.frame) + middleMargin;
    CGFloat selectBgViewW = screenW - largeMargin;
    CGFloat selectBgViewH = self.lastButtonFrame.size.height;
    CGRect selectBgViewF = CGRectMake(selectBgViewX, selectBgViewY, selectBgViewW, selectBgViewH);
    selectBgView.frame = selectBgViewF;
}

#pragma mark ----- screenButton点击事件
- (void)screenButtonClicked:(SLScreenButton *)screenButton
{
    SLSubscribeClassParameters *parameters = [SLSubscribeClassParameters parameters];
    parameters.slId = screenButton.subscribeClass.slId;
    
    [SLSubscribeTool subscribeSelectClassWithParameters:parameters success:^(SLResult *result) {
        if ([result.msg isEqualToString:@"操作成功"]) {
            screenButton.selected = YES;
            [MBProgressHUD showSuccess:@"成功订阅"];
        } else if ([result.msg isEqualToString:@"取消成功"]) {
            screenButton.selected = NO;
            [MBProgressHUD showSuccess:@"成功取消订阅"];
        }
    } failure:^(NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
