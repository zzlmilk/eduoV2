//
//  SLVipProductViewController.m
//  02-pigBank
//
//  Created by 陆承东 on 14-9-24.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLVipProductViewController.h"

#import "SLVipStatus.h"
#import "SLMeterialDetialParameters.h"
#import "SLResult.h"
#import "SLPrivilegeProduct.h"

#import "SLVipProductHeadView.h"
#import "SLVipProductArrorCell.H"
#import "SLPraiseButton.h"
#import "SLCollectButton.h"
#import "SLBackButton.h"

#import "SLMapViewController.h"

#import "SLMeterialDetialTool.h"
#import "SLUserOperateTool.h"

@interface SLVipProductViewController () <UIWebViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UIWebView *telWebView;

@property (nonatomic, weak) UIWebView *footWebView;
@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, assign) CGFloat footHeight;

@property (nonatomic, strong) SLPrivilegeProduct *privilegeProduct;

@end

@implementation SLVipProductViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setNavBar];
}

#pragma mark ----- 设置导航栏样式
- (void)setNavBar
{
    UINavigationBar *navBar = self.navigationController.navigationBar;
    // 设置背景
    [navBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [navBar setBarTintColor:SLColor(246, 246, 246)];
    
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

#pragma mark ----- viewDidLoad
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [MBProgressHUD showMessage:@"数据加载中"];
    
    [self addSubviews];
}

#pragma mark ----- 添加所有子控件
- (void)addSubviews
{
    self.view.backgroundColor = SLWhite;

    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.hidden = YES;
    self.tableView = tableView;
    [self.view addSubview:tableView];
    
    [self loadInternetData];
}

#pragma mark ----- 加载网络数据
- (void)loadInternetData
{
    SLMeterialDetialParameters *parameters = [SLMeterialDetialParameters parameters];
    parameters.materialId = self.materialId;
    
    [SLMeterialDetialTool meterialDetialWithParameters:parameters success:^(SLResult *result) {
        
        [MBProgressHUD hideHUD];
        
        if ([result.code isEqualToString:successStr]) {
            if (result.info.count > 0) {
                NSDictionary *dict = [result.info lastObject];
                SLPrivilegeProduct *privilegeProduct = [SLPrivilegeProduct objectWithKeyValues:dict];
                self.privilegeProduct = privilegeProduct;
                
                // 计算foot的高度
                [self calculateFootHeight];
                [self setCollectAndPrise];
                [self.tableView reloadData];
                self.tableView.hidden = NO;
            } else {
                [MBProgressHUD showError:@"数据源错误..."];
            }
        } else {
            [MBProgressHUD showError:result.msg];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
    }];
}

#pragma mark ----- setCollectAndPrise设置赞和收藏按钮
- (void)setCollectAndPrise
{
    // 设置右上角的barButton
    SLPraiseButton *praiseButton = [SLPraiseButton button];
    [praiseButton setMaterialId:self.privilegeProduct.materialId praiseCounts:self.privilegeProduct.praiseCounts praiseFlag:self.privilegeProduct.materialUser.praiseFlag];
    UIBarButtonItem *praiseItem = [[UIBarButtonItem alloc] initWithCustomView:praiseButton];
    
    SLCollectButton *collectButton = [SLCollectButton button];
    [collectButton setMaterialId:self.privilegeProduct.materialId collectFlag:self.privilegeProduct.materialUser.collectFlag];
    UIBarButtonItem *collectItem = [[UIBarButtonItem alloc] initWithCustomView:collectButton];
    
    NSArray *rightBarButtonItems = @[praiseItem, collectItem];
    self.navigationItem.rightBarButtonItems = rightBarButtonItems;
}

#pragma mark ----- 计算webview的高度
- (void)calculateFootHeight
{
    UIWebView *webview = [[UIWebView alloc]initWithFrame:CGRectMake(screenW, 0, screenW, 1)];
    webview.delegate = self;
    webview.tag = 1;
    [webview loadHTMLString:self.privilegeProduct.content baseURL:nil];
    [self.view addSubview:webview];
}

#pragma mark ----- 设置tableHeadFootView
- (void)setupTableHeadFootView
{
    // headView
    SLVipProductHeadView *headView = [[SLVipProductHeadView alloc] init];
    
    headView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200);
    
    headView.privilegeProduct = self.privilegeProduct;
    
    self.tableView.tableHeaderView = headView;
    
    // footView
    UITableViewHeaderFooterView *footView = [[UITableViewHeaderFooterView alloc] init];
    
    UIWebView *webView = [[UIWebView alloc] init];
    
    webView.frame = CGRectMake(0, 0, 320, self.footHeight);
    webView.delegate = self;
    webView.backgroundColor = [UIColor clearColor];
    webView.scrollView.bounces = NO;//禁止滑动
    self.footWebView = webView;
    [webView loadHTMLString:self.privilegeProduct.content baseURL:nil];
    
    footView.textLabel.font = SLVipStatusTitleFont;
    footView.textLabel.textColor = [UIColor blackColor];
    footView.textLabel.text = self.privilegeProduct.content;
    CGSize footViewS = [self.privilegeProduct.content sizeWithFont:SLVipStatusTitleFont constrainedToSize:CGSizeMake(300, MAXFLOAT)];
    footView.frame = (CGRect){{0, 0}, footViewS};
    
    self.tableView.tableFooterView = webView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.privilegeProduct.privilegeDetail.saleDescript isEqualToString:@""]) {
        return 3;
    } else {
        return 4;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"vipProductCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    switch (indexPath.row) {
        case 0:
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            cell.textLabel.text = self.privilegeProduct.privilegeDetail.merchantDetail.fullName;
            break;
        case 1:
            [cell setSelectionStyle:UITableViewCellSelectionStyleDefault];
            if ([self.privilegeProduct.privilegeDetail.saleDescript isEqualToString:@""]) {
                cell.imageView.image = [UIImage imageNamed:@"diZhi"];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.textLabel.text = self.privilegeProduct.privilegeDetail.merchantDetail.address;
                break;
            } else {
                cell.imageView.image = [UIImage imageNamed:@"youHui"];
                cell.textLabel.text = [NSString stringWithFormat:@"(%@)%@", self.privilegeProduct.privilegeDetail.saleTypes, self.privilegeProduct.privilegeDetail.saleDescript];
                break;
            }
        case 2:
            [cell setSelectionStyle:UITableViewCellSelectionStyleDefault];
            if ([self.privilegeProduct.privilegeDetail.saleDescript isEqualToString:@""]) {
                cell.imageView.image = [UIImage imageNamed:@"dianHua"];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.textLabel.text = [NSString stringWithFormat:@"%@", self.privilegeProduct.privilegeDetail.merchantDetail.merchantUserInfo.telephone];
                break;
            } else {
                cell.imageView.image = [UIImage imageNamed:@"diZhi"];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.textLabel.text = self.privilegeProduct.privilegeDetail.merchantDetail.address;
                break;
            }
        case 3:
            [cell setSelectionStyle:UITableViewCellSelectionStyleDefault];
            if ([self.privilegeProduct.privilegeDetail.saleDescript isEqualToString:@""]) {
                break;
            } else {
                cell.imageView.image = [UIImage imageNamed:@"dianHua"];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.textLabel.text = [NSString stringWithFormat:@"%@", self.privilegeProduct.privilegeDetail.merchantDetail.merchantUserInfo.telephone];
                break;
            }
            
        default:
            break;
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
    mvc.privilegeProduct = self.privilegeProduct;
    if ([self.privilegeProduct.privilegeDetail.saleDescript isEqualToString:@""]) {
        if (indexPath.row == 1) {
            [self.navigationController pushViewController:mvc animated:YES];
        } else if (indexPath.row == 2) {// 利用创建好的uiwebview加载request
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", self.privilegeProduct.privilegeDetail.merchantDetail.merchantUserInfo.telephone]];
            [telWebView loadRequest:[NSURLRequest requestWithURL:url]];
        }
        
    } else {
        if (indexPath.row == 2) {
            [self.navigationController pushViewController:mvc animated:YES];
        } else if (indexPath.row == 3) {
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", self.privilegeProduct.privilegeDetail.merchantDetail.merchantUserInfo.telephone]];
            [telWebView loadRequest:[NSURLRequest requestWithURL:url]];
        }
    }
    
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}

#pragma mark ----- uiwebview代理方法
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    if (webView.tag == 1) {
        CGSize actualSize = [webView sizeThatFits:CGSizeZero];
        CGRect newFrame = webView.frame;
        newFrame.size.height = actualSize.height;
        self.footHeight = actualSize.height;
        [self.tableView.tableFooterView reloadInputViews];
        
        /**
         *  设置tableHeadView
         */
        [self setupTableHeadFootView];
    }
}

@end
