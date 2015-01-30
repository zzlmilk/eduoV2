//
//  SLClientBrowseHistoryViewController.m
//  02-pigBank
//
//  Created by 陆承东 on 15/1/20.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import "SLClientBrowseHistoryViewController.h"

#import "SLMaterialBrowseHistoryFrame.h"

#import "SLClientToolBar.h"
#import "SLBackButton.h"
#import "SLClientBrowseHistoryCell.h"
#import "SLConsultant.h"

#import "SLFinanceProductController.h"
#import "SLVipProductViewController.h"
#import "SLClientDetailController.h"
#import "SLMessageListController.h"
#import "SLMessageViewController.h"
#import "SLClientListTableViewController.h"

#import "UIBarButtonItem+SL.h"
#import "SLClientTool.h"
#import "SLAccountTool.h"
#import "SLConsultantTool.h"

#import "MJRefresh.h"
#import "MBProgressHUD+MJ.h"

#define toolBarHeight 44

@interface SLClientBrowseHistoryViewController () <UIActionSheetDelegate, UITableViewDataSource, UITableViewDelegate, SLClientToolBarDelegate, MJRefreshBaseViewDelegate>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) UIView *noDataHintView;
@property (nonatomic, weak) UILabel *hintLabel;
@property (nonatomic, weak) UIToolbar *toolBar;

@property (nonatomic, weak) MJRefreshHeaderView *header;
@property (nonatomic, weak) MJRefreshFooterView *footer;

@property (nonatomic, assign) long currentPage;
@property (nonatomic, strong) SLClientParameters *parameters;
@property (nonatomic, strong) SLClientInfo *clientInfo;
@property (nonatomic, strong) NSMutableArray *materialUserList;

@end

@implementation SLClientBrowseHistoryViewController

- (NSMutableArray *)materialUserList
{
    if (_materialUserList == nil) {
        _materialUserList = [NSMutableArray array];
    }
    return _materialUserList;
}

- (SLClientParameters *)parameters
{
    if (_parameters == nil) {
        _parameters = [SLClientParameters parameters];
        _parameters.userId = self.client.userId;
        _parameters.pageSize = @20;
    }
    return _parameters;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    
    [self setNavBar];
}

#pragma mark ----- setNavBar设置导航栏
- (void)setNavBar
{
    SLBackButton *backButton = [SLBackButton button];
    [backButton addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backItem;
    
    UIBarButtonItem *clientDetailItem = [UIBarButtonItem itemWithImage:@"icon_nav_clientDetail_normal" highlightImage:@"icon_nav_clientDetail_selected" target:self action:@selector(clientDetailItemClick:)];
    self.navigationItem.rightBarButtonItem = clientDetailItem;
}

#pragma mark ----- 客户详情按钮点击事件
- (void)clientDetailItemClick:(UIBarButtonItem *)clientDetailItem
{
    SLClientDetailController *cdvc = [[SLClientDetailController alloc] init];
    cdvc.title = self.client.dispName;
    cdvc.client = self.client;
    [self.navigationController pushViewController:cdvc animated:YES];
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

#pragma mark ----- addSubviews添加所有子控件
- (void)addSubviews
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenW, screenH)];
    self.tableView = tableView;
    tableView.delegate = self;
    tableView.rowHeight = 70;
    tableView.dataSource = self;
    tableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
    [self.view addSubview:tableView];
    
    [self addTableHeadFootView];
    
    UIView *noDataHintView = [[UIView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:noDataHintView];
    self.noDataHintView = noDataHintView;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    imageView.image = [UIImage imageNamed:@"app_bg_default_home_img_normal"];
    imageView.contentMode = UIViewContentModeCenter;
    [noDataHintView addSubview:imageView];
    UILabel *hintLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, screenH * 0.7, screenW, 30)];
    hintLabel.text = @"没有浏览记录";
    hintLabel.font = SLFont18;
    hintLabel.textColor = [UIColor grayColor];
    hintLabel.textAlignment = NSTextAlignmentCenter;
    self.hintLabel = hintLabel;
    [noDataHintView addSubview:hintLabel];
    noDataHintView.hidden = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(noDataHintViewTap)];
    [noDataHintView addGestureRecognizer:tap];
    
    [self setRefreshView];
    
    CGFloat toolBarW = screenW;
    CGFloat toolBarH = 49;
    CGFloat toolBarX = 0;
    CGFloat toolBarY = screenH - toolBarH;
    SLClientToolBar *toolBar = [[SLClientToolBar alloc] initWithFrame:CGRectMake(toolBarX, toolBarY, toolBarW, toolBarH)];
    toolBar.delegate = self;
    [toolBar setRightButtonTitle:@"电联" image:@"icon_tabbar_phone_normal"];
    [self.view addSubview:toolBar];
}

- (void)clientToolBar:(SLClientToolBar *)clientToolBar didClickedLeftButton:(SLTabBarButton *)leftButton
{
    SLMessageViewController *messagevc = [[SLMessageViewController alloc] init];
    messagevc.from = @"toolBar";
    [self.navigationController pushViewController:messagevc animated:YES];
}

- (void)clientToolBar:(SLClientToolBar *)clientToolBar didClickedRightButton:(SLTabBarButton *)rightButton
{
    [self setActionSheet];
}

#pragma mark ----- 设置actionSheet
- (void)setActionSheet
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:self.client.dispName delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:self.client.mobile, nil];
    [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIWebView *callWebView = [[UIWebView alloc] init];
    [self.view addSubview:callWebView];
    NSURL *url = [NSURL URLWithString:self.client.mobile];
    [callWebView loadRequest:[NSURLRequest requestWithURL:url]];
}

#pragma mark ----- 设置tableHeadFootView
- (void)addTableHeadFootView
{
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenW, 0.5)];
    footView.backgroundColor = SLLightGray;
    self.tableView.tableFooterView = footView;
}

- (void)noDataHintViewTap
{
    self.tableView.hidden = NO;
    self.noDataHintView.hidden = YES;
    
    [self.header beginRefreshing];
}

#pragma mark ----- 刷新数据的方法
- (void)setRefreshView
{
    // 1.下拉刷新
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    header.scrollView = self.tableView;
    header.delegate = self;
    // 自动进入刷新状态
    [header beginRefreshing];
    self.header = header;
    
    // 2.上拉刷新(上拉加载更多数据)
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = self.tableView;
    footer.delegate = self;
    self.footer = footer;
}

#pragma mark ----- 代理方法,mj刷新包的代理方法
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if ([refreshView isKindOfClass:[MJRefreshFooterView class]]) { // 上拉刷新
        [self loadMoreData];
    } else { // 下拉刷新
        [self loadNewData];
    }
}

#pragma mark ----- loadMoreData加载更多数据
- (void)loadMoreData
{
    self.currentPage += 1;
    self.parameters.curPage = [NSNumber numberWithLong:self.currentPage];
    
    [SLClientTool clientInfoWithParameters:self.parameters success:^(SLClientInfo *clientInfo) {
        
        // 让刷新控件停止显示刷新状态
        [self.footer endRefreshing];
        
        self.clientInfo = clientInfo;
        if (clientInfo.materialUserList.count == 0) {
            [MBProgressHUD showError:@"没有更多数据了..."];
        } else {
            [self.materialUserList addObjectsFromArray:clientInfo.materialUserList];
        }
        
    } failure:^(NSError *error) {
        [self.footer endRefreshing];
    }];
}

#pragma mark ----- loadNewData向服务器获取最新的数据
- (void)loadNewData
{
    self.currentPage = 1;
    self.parameters.curPage = [NSNumber numberWithLong:self.currentPage];
    
    [SLClientTool clientInfoWithParameters:self.parameters success:^(SLClientInfo *clientInfo) {
        
        // 让刷新控件停止显示刷新状态
        [self.header endRefreshing];
        
        self.clientInfo = clientInfo;
        
        if (self.clientInfo.materialUserList.count == 0) {
            [MBProgressHUD showError:@"没有浏览记录"];
            self.tableView.hidden = YES;
            self.noDataHintView.hidden = NO;
        } else {
            self.tableView.hidden = NO;
            self.noDataHintView.hidden = YES;
            
            [self.materialUserList removeAllObjects];
            [self.materialUserList addObjectsFromArray:clientInfo.materialUserList];
            
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        [self.header endRefreshing];
    }];
}

- (void)dealloc
{
    // 释放内存
    [self.header free];
    [self.footer free];
}

#pragma mark ----- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.materialUserList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SLMaterial *material = self.materialUserList[indexPath.row];
    SLMaterialBrowseHistoryFrame *materialBrowseHistoryFrame = [[SLMaterialBrowseHistoryFrame alloc] init];
    materialBrowseHistoryFrame.material = material;
    
    SLClientBrowseHistoryCell *cell = [SLClientBrowseHistoryCell cellWithTableView:tableView];
    cell.materialBrowseHistoryFrame = materialBrowseHistoryFrame;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SLMaterial *material = self.materialUserList[indexPath.row];
    
    if ([material.materialInfo.templetType intValue] == 3) {
        SLFinanceProductController *financeProductController = [[SLFinanceProductController alloc] init];
        financeProductController.materialId = material.materialId;
        
        [self.navigationController pushViewController:financeProductController animated:YES];
    } else if ([material.materialInfo.templetType intValue] == 2) {
        SLVipProductViewController *vpvc = [[SLVipProductViewController alloc] init];
        vpvc.materialId = material.materialId;
        [self.navigationController pushViewController:vpvc animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
