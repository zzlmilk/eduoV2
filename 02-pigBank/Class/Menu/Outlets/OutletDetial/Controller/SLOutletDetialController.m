//
//  SLOutletDetialController.m
//  02-pigBank
//
//  Created by 陆承东 on 14/10/22.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLOutletDetialController.h"

#import "SLMeterialDetialParameters.h"
#import "SLOutletsInfo.h"

#import "SLPraiseButton.h"
#import "SLCollectButton.h"

#import "SLMapViewController.h"

#import "SLMeterialDetialTool.h"

#import "MBProgressHUD+MJ.h"
#import "MJExtension.h"

@interface SLOutletDetialController () <UIWebViewDelegate>

@property (nonatomic, weak) UIWebView *telWebView;

@property (nonatomic, strong) SLOutletsInfo *outletsInfo;

@end

@implementation SLOutletDetialController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [MBProgressHUD showMessage:@"数据加载中"];
    
    [self loadInternetData];
}

#pragma mark ----- 加载网络数据
- (void)loadInternetData
{
    SLMeterialDetialParameters *parameters = [SLMeterialDetialParameters parameters];
    parameters.materialId = self.materialId;
    
    [SLMeterialDetialTool meterialDetialWithParameters:parameters success:^(SLResult *result) {
        
        NSDictionary *dict = [result.info lastObject];
        SLOutletsInfo *outletsInfo = [SLOutletsInfo objectWithKeyValues:dict];
        self.outletsInfo = outletsInfo;
        
        [self setNavBar];
        
        [self initTableHeadView];
        
        [self initTableFootView];
        
        [MBProgressHUD hideHUD];
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark ----- setNavBar设置导航栏
- (void)setNavBar
{
    UINavigationBar *navBar = self.navigationController.navigationBar;
    // 设置背景
    [navBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    
    // 设置右上角的barButton
    SLPraiseButton *priseButton = [SLPraiseButton button];
    [priseButton setMaterialId:self.outletsInfo.materialId praiseCounts:self.outletsInfo.praiseCounts praiseFlag:self.outletsInfo.materialUser.praiseFlag];
    UIBarButtonItem *priseItem = [[UIBarButtonItem alloc] initWithCustomView:priseButton];
    
    SLCollectButton *collectButton = [SLCollectButton button];
    [collectButton setMaterialId:self.outletsInfo.materialId collectFlag:self.outletsInfo.materialUser.collectFlag];
    UIBarButtonItem *collectItem = [[UIBarButtonItem alloc] initWithCustomView:collectButton];
    //    UIBarButtonItem *callItem = [UIBarButtonItem itemWithImage:@"dianHua" highlightImage:@"dianHua" target:self action:@selector(call)];
    NSArray *rightBarButtonItems = @[priseItem, collectItem];
    self.navigationItem.rightBarButtonItems = rightBarButtonItems;
}

- (void)initTableFootView
{
    UITableViewHeaderFooterView *footView = [[UITableViewHeaderFooterView alloc] init];
    
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = CGRectMake(0, 1, 320, 320);
    webView.delegate = self;
    webView.backgroundColor = [UIColor clearColor];
    webView.scrollView.bounces = NO;//禁止滑动
    [webView loadHTMLString:self.outletsInfo.content baseURL:nil];
    
    UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 1)];
    separator.backgroundColor = SLColorRGBA(0, 0, 0, 0.7);
    
    [footView addSubview:separator];
    
    [footView addSubview:webView];
    
    self.tableView.tableFooterView = webView;
}

- (void)initTableHeadView
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = self.outletsInfo.title;
    label.font = SLFont18;
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 43);
    [headView addSubview:label];
    
    UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(0, 43, [UIScreen mainScreen].bounds.size.width, 0.5)];
    separator.backgroundColor = SLColorRGBA(0, 0, 0, 0.2);
    [headView addSubview:separator];
    
    self.tableView.tableHeaderView = headView;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 创建cell
    static NSString *ID = @"outletDetialCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    // 给cell赋值
    if (indexPath.row == 0) {
        cell.textLabel.text = self.outletsInfo.outletsDetail.serviceTypeDisp;
        cell.imageView.image = [UIImage imageNamed:@"fuWu"];
    } else if (indexPath.row == 1) {
        cell.textLabel.text = self.outletsInfo.outletsDetail.address;
        cell.imageView.image = [UIImage imageNamed:@"diZhi"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else if (indexPath.row == 2) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@", self.outletsInfo.outletsDetail.telephone];
        cell.imageView.image = [UIImage imageNamed:@"dianHua"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 拨打电话首先要创建一个uiwebview
    UIWebView *telWebView = [[UIWebView alloc] init];
    [self.view addSubview:telWebView];
    self.telWebView = telWebView;
    
    SLMapViewController *mvc = [[SLMapViewController alloc] init];
    mvc.outletsInfo = self.outletsInfo;
    
    if (indexPath.row == 1) {
        [self.navigationController pushViewController:mvc animated:YES];
    } else if (indexPath.row == 2) {
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", self.outletsInfo.outletsDetail.telephone]];
        [telWebView loadRequest:[NSURLRequest requestWithURL:url]];
    }
}

- (void)setOutletsInfo:(SLOutletsInfo *)outletsInfo
{
    _outletsInfo = outletsInfo;
    
    [self.tableView reloadData];
}

#pragma mark ----- uiwebview的代理方法
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [webView sizeToFit];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
