//
//  SLSubscribeDetailController.m
//  02-pigBank
//
//  Created by 陆承东 on 15/1/23.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import "SLSubscribeDetailController.h"

#import "SLBackButton.h"

#import "SLSubscribeTool.h"
#import "NSString+S_LINE.h"

#import "MBProgressHUD+MJ.h"
#import "UIImageView+MJWebCache.h"

@interface SLSubscribeDetailController ()<UIWebViewDelegate>

@property (nonatomic, weak) UIScrollView *backgroundView;
@property (nonatomic, weak) UIView *headBgView;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *subTitleLabel;
@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, weak) UIWebView *webView;
@property (nonatomic, assign) CGFloat webViewHeight;

@property (nonatomic, strong) SLSubscribeDetail *subscribeDetail;

@end

@implementation SLSubscribeDetailController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setNavBar];
}

#pragma mark ----- 设置导航栏样式
- (void)setNavBar
{
    self.title = @"订阅详情";
    
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
    
    [self addSubviews];
}

#pragma mark ----- 添加子控件
- (void)addSubviews
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIScrollView *backgroundView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    backgroundView.backgroundColor = [UIColor whiteColor];
    self.backgroundView = backgroundView;
    [self.view addSubview:backgroundView];
    
    UIView *headBgView = [[UIView alloc] init];
    self.headBgView = headBgView;
    [backgroundView addSubview:headBgView];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    self.titleLabel = titleLabel;
    [headBgView addSubview:titleLabel];
    
    UILabel *subTitleLabel = [[UILabel alloc] init];
    self.subTitleLabel = subTitleLabel;
    [headBgView addSubview:subTitleLabel];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    self.imageView = imageView;
    [backgroundView addSubview:imageView];
    
    UIWebView *webView = [[UIWebView alloc] init];
    self.webView = webView;
    [backgroundView addSubview:webView];
    
    [self loadInternetData];
}

#pragma mark ----- 加载订阅详情数据
- (void)loadInternetData
{
    [MBProgressHUD showMessage:@"订阅详情加载中"];
    
    SLSubscribeDetailParameters *parameters = [SLSubscribeDetailParameters parameters];
    parameters.siId = self.siId;
    
    [SLSubscribeTool subscribeDetailWithParameters:parameters success:^(SLSubscribeDetail *subscribeDetail) {
        
        self.subscribeDetail = subscribeDetail;
        
        [self setSubviewsData];
        
        [MBProgressHUD hideHUD];
        
    } failure:^(NSError *error) {
        
        [MBProgressHUD hideHUD];
    }];
}

#pragma mark ----- 设置子控件数据
- (void)setSubviewsData
{
    CGFloat headBgViewX = 0;
    CGFloat headBgViewY = 0;
    CGFloat headBgViewW = screenW;
    
    CGFloat titleLabelX = middleMargin;
    CGFloat titleLabelY = middleMargin;
    CGFloat titleLabelW = screenW - largeMargin;
    CGSize titleLabelS = [self.subscribeDetail.title sizeWithFont:SLFont16 maxSize:CGSizeMake(titleLabelW, CGFLOAT_MAX)];
    CGRect titleLabelF = CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelS.height);
    self.titleLabel.frame = titleLabelF;
    self.titleLabel.font = SLBoldFont16;
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.text = self.subscribeDetail.title;
    
    CGFloat subTitleLabelX = titleLabelX;
    CGFloat subTitleLabelY = CGRectGetMaxY(titleLabelF) + middleMargin;
    CGFloat subTitleLabelW = titleLabelW;
    CGFloat subTitleLabelH = 12;
    CGRect subTitleLabelF = CGRectMake(subTitleLabelX, subTitleLabelY, subTitleLabelW, subTitleLabelH);
    self.subTitleLabel.frame = subTitleLabelF;
    self.subTitleLabel.font = SLFont12;
    self.subTitleLabel.text = [NSString stringWithFormat:@"%@ %@", self.subscribeDetail.labelName, self.subscribeDetail.updateTimeStr];
    
    CGFloat headBgViewH = CGRectGetMaxY(subTitleLabelF) + middleMargin;
    CGRect headBgViewF = CGRectMake(headBgViewX, headBgViewY, headBgViewW, headBgViewH);
    self.headBgView.frame = headBgViewF;
    self.headBgView.backgroundColor = SLLightGray;
    
    CGFloat imageViewX = middleMargin;
    CGFloat imageViewY = CGRectGetMaxY(headBgViewF) + middleMargin;
    CGFloat imageViewW = screenW - largeMargin;
    CGFloat imageViewH = 150;
    CGRect imageViewF = CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
    self.imageView.frame = imageViewF;
    [self.imageView setImageURLStr:self.subscribeDetail.pictureUrl placeholder:[UIImage imageNamed:@"bjLogin"]];
    
    UIWebView *webview = [[UIWebView alloc]initWithFrame:CGRectMake(-screenW, 0, screenW, 1)];
    webview.delegate = self;
    webview.tag = 1;
    [webview loadHTMLString:self.subscribeDetail.content baseURL:nil];
    [self.view addSubview:webview];
}

#pragma mark ----- 设置webview
- (void)setWebView
{
    CGFloat webViewX = 0;
    CGFloat webViewY = CGRectGetMaxY(self.imageView.frame) + middleMargin;
    CGFloat webViewW = screenW;
    CGFloat webViewH = self.webViewHeight;
    CGRect webViewF = CGRectMake(webViewX, webViewY, webViewW, webViewH);
    self.webView.frame = webViewF;
    [self.webView loadHTMLString:self.subscribeDetail.content baseURL:nil];
    self.webView.scrollView.bounces = NO;
    self.webView.scrollView.scrollEnabled = NO;
    self.webView.userInteractionEnabled = NO;
    self.backgroundView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.webView.frame));
}

#pragma mark ----- uiwebview代理方法
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    if (webView.tag == 1) {
        CGSize actualSize = [webView sizeThatFits:CGSizeZero];
        CGRect newFrame = webView.frame;
        newFrame.size.height = actualSize.height;
        self.webViewHeight = actualSize.height;
        
        [self setWebView];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
