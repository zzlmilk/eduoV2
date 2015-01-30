//
//  SLClientListTableViewController.m
//  02-pigBank
//
//  Created by 陆承东 on 15/1/19.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import "SLClientListTableViewController.h"

#import "SLClientListParameters.h"
#import "SLClientGroup.h"
#import "SLClientTag.h"

#import "SLClientListCell.h"
#import "SLClientGroupHeaderView.h"
#import "SLClientTagHeaderView.h"
#import "SLBackButton.h"

#import "SLClientBrowseHistoryViewController.h"

#import "SLClientListTool.h"
#import "UIBarButtonItem+SL.h"

#import "UIViewController+REXSideMenu.h"

@interface SLClientListTableViewController ()<SLClientGroupHeaderViewDegegate, SLClientTagHeaderViewDegegate>

@property (nonatomic, weak) UISegmentedControl *segmentedControl;

@property (nonatomic, strong) NSArray *clientListInAllArray;
@property (nonatomic, strong) NSArray *clientListInGroupArray;
@property (nonatomic, strong) NSArray *clientListInTagArray;

@property (nonatomic, assign) NSInteger selectedSegmentIndex;

@end

@implementation SLClientListTableViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self loadAllClientsData];
    
    [self setNavBar];
}

#pragma mark ----- setNavBar设置导航栏
- (void)setNavBar
{
    self.title = @"客户列表";
    
    if ([self.from isEqualToString:@"toolBar"]) {
        SLBackButton *backButton = [SLBackButton button];
        [backButton addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        self.navigationItem.leftBarButtonItem = backItem;
    } else {
        // 设置左上角的barButton
        self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"icon_nav_more_normal" highlightImage:@"" target:self action:@selector(presentLeftMenuViewController:)];
    }
}

#pragma mark ----- backButtonClicked返回按钮点击事件
- (void)backButtonClicked:(SLBackButton *)backButton
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = 60;
    
    [self addSubviews];
    
    [self setTableHeadFootView];
}

#pragma mark ----- 设置tableFootView
- (void)setTableHeadFootView
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenW, 50)];
    
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] init];
    segmentedControl.bounds = CGRectMake(0, 0, screenW - largeMargin, 30);
    segmentedControl.center = headView.center;
    [segmentedControl insertSegmentWithTitle:@"全部" atIndex:0 animated:YES];
    [segmentedControl insertSegmentWithTitle:@"按组" atIndex:1 animated:YES];
    [segmentedControl insertSegmentWithTitle:@"标签" atIndex:2 animated:YES];
    [segmentedControl addTarget:self action:@selector(segmentedControlValueChanged:) forControlEvents:UIControlEventValueChanged];
    [segmentedControl setTintColor:SLRed];
    segmentedControl.selectedSegmentIndex = 0;
    [headView addSubview:segmentedControl];
    
    UIView *headSeparatorView = [[UIView alloc] init];
    CGRect headSeparatorViewF = SLTableFootViewFrame;
    headSeparatorViewF.origin.y = 49.5;
    headSeparatorView.frame = headSeparatorViewF;
    headSeparatorView.backgroundColor = SLLightGray;
    [headView addSubview:headSeparatorView];
    
    self.tableView.tableHeaderView = headView;
    
    UIView *footView = [[UIView alloc] initWithFrame:SLTableFootViewFrame];
//    footView.backgroundColor = SLLightGray;
    self.tableView.tableFooterView = footView;
}

- (void)addSubviews
{
}

#pragma mark ----- segmentedControl响应方法
- (void)segmentedControlValueChanged:(UISegmentedControl *)segmentedControl
{
    if (segmentedControl.selectedSegmentIndex == 0) {
        self.selectedSegmentIndex = 0;
        [self loadAllClientsData];
    } else if (segmentedControl.selectedSegmentIndex == 1) {
        self.selectedSegmentIndex = 1;
        [self loadClientListInGroup];
    } else if (segmentedControl.selectedSegmentIndex == 2) {
        self.selectedSegmentIndex = 2;
        [self loadClientListInTag];
    }
}

#pragma mark ----- 加载所有用户数据
- (void)loadAllClientsData
{
    SLClientListParameters *parameters = [SLClientListParameters parameters];
    parameters.curPage = @1;
    
    [SLClientListTool clientListInAllWithParameters:parameters success:^(NSArray *clientListInAllArray) {
        self.clientListInAllArray = clientListInAllArray;
        
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark ----- loadClientListInGroup按组加载数据
- (void)loadClientListInGroup
{
    SLClientListParameters *parameters = [SLClientListParameters parameters];
    
    [SLClientListTool clientListInGroupWithParameters:parameters success:^(NSArray *clientListInGroupArray) {
        self.clientListInGroupArray = clientListInGroupArray;
        
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark ----- 按标签加载数据
- (void)loadClientListInTag
{
    SLClientListParameters *parameters = [SLClientListParameters parameters];
    
    [SLClientListTool clientListInTagWithParameters:parameters success:^(NSArray *clientListInTagArray) {
        self.clientListInTagArray = clientListInTagArray;
        
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.selectedSegmentIndex == 0) {
        return 1;
    } else if (self.selectedSegmentIndex == 1) {
        return self.clientListInGroupArray.count;
    } else if (self.selectedSegmentIndex == 2) {
        return self.clientListInTagArray.count;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.selectedSegmentIndex == 0) {
        return self.clientListInAllArray.count;
    } else if (self.selectedSegmentIndex == 1) {
        SLClientGroup *clientGroup = self.clientListInGroupArray[section];
        if (clientGroup.open == YES)
        {
            return clientGroup.userList.count;
        }
        return 0;
    } else if (self.selectedSegmentIndex == 2) {
        SLClientTag *clientTag = self.clientListInTagArray[section];
        if (clientTag.open == YES)
        {
            return clientTag.userList.count;
        }
        return 0;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.selectedSegmentIndex == 0) {
        SLClient *client = self.clientListInAllArray[indexPath.row];
        SLClientFrame *clientFrame = [[SLClientFrame alloc] init];
        clientFrame.client = client;
        
        SLClientListCell *cell = [SLClientListCell cellWithTableView:tableView];
        
        cell.clientFrame = clientFrame;
        
        return cell;
    } else if (self.selectedSegmentIndex == 1) {
        SLClientGroup *clientGroup = self.clientListInGroupArray[indexPath.section];
        SLClient *client = clientGroup.userList[indexPath.row];
        SLClientFrame *clientFrame = [[SLClientFrame alloc] init];
        clientFrame.client = client;
        
        SLClientListCell *cell = [SLClientListCell cellWithTableView:tableView];
        
        cell.clientFrame = clientFrame;
        
        return cell;
    } else if (self.selectedSegmentIndex == 2) {
        SLClientTag *clientTag = self.clientListInTagArray[indexPath.section];
        SLClient *client = clientTag.userList[indexPath.row];
        SLClientFrame *clientFrame = [[SLClientFrame alloc] init];
        clientFrame.client = client;
        
        SLClientListCell *cell = [SLClientListCell cellWithTableView:tableView];
        
        cell.clientFrame = clientFrame;
        
        return cell;
    }
    
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.selectedSegmentIndex == 1) {
        // 创建一个view
        SLClientGroupHeaderView *clientGroupHeaderView = [SLClientGroupHeaderView headerViewWithTableView:tableView];
        
        // 给view传递数据
        SLClientGroup *clientGroup = self.clientListInGroupArray[section];
        clientGroupHeaderView.clientGroup = clientGroup;
        clientGroupHeaderView.delegate = self;
        
        // 返回view
        return clientGroupHeaderView;
    } else if (self.selectedSegmentIndex == 2) {
        // 创建一个view
        SLClientTagHeaderView *clientTagHeaderView = [SLClientTagHeaderView headerViewWithTableView:tableView];
        
        // 给view传递数据
        SLClientTag *clientTag = self.clientListInTagArray[section];
        clientTagHeaderView.clientTag = clientTag;
        clientTagHeaderView.delegate = self;
        
        // 返回view
        return clientTagHeaderView;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.selectedSegmentIndex == 1 | self.selectedSegmentIndex == 2) {
        return 44;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SLClientBrowseHistoryViewController *bhvc = [[SLClientBrowseHistoryViewController alloc] init];
    
    if (self.selectedSegmentIndex == 0) {
        SLClient *client = self.clientListInAllArray[indexPath.row];
        
        bhvc.client = client;
        bhvc.title = client.dispName;
        [self.navigationController pushViewController:bhvc animated:YES];
    } else if (self.selectedSegmentIndex == 1) {
        SLClientGroup *clientGroup = self.clientListInGroupArray[indexPath.section];
        SLClient *client = clientGroup.userList[indexPath.row];
        
        bhvc.client = client;
        bhvc.title = client.dispName;
        [self.navigationController pushViewController:bhvc animated:YES];
    } else if (self.selectedSegmentIndex == 2) {
        SLClientTag *clientTag = self.clientListInTagArray[indexPath.section];
        SLClient *client = clientTag.userList[indexPath.row];
        
        bhvc.client = client;
        bhvc.title = client.dispName;
        [self.navigationController pushViewController:bhvc animated:YES];
    }
}

#pragma mark ----- SLClientGroupHeaderView代理方法
- (void)clientGroupHeaderViewDidClickTitleButton:(SLClientGroupHeaderView *)clientGroupHeaderView
{
    [self.tableView reloadData];
}

#pragma mark ----- SLClientTagHeaderView代理方法
- (void)clientTagHeaderViewDidClickTitleButton:(SLClientTagHeaderView *)clientTagHeaderView
{
    [self.tableView reloadData];
}

@end
