//
//  SLManageViewController.m
//  02-pigBank
//
//  Created by 陆承东 on 15/1/28.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import "SLManageViewController.h"

#import "SLClientFrame.h"

#import "SLBackButton.h"
#import "SLManageHeadView.h"
#import "SLManageClientListCell.h"

#import "SLManagerTool.h"


@interface SLManageViewController ()<UITableViewDataSource, UITableViewDelegate, SLManageHeadViewDelegate>

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) NSArray *clientListArray;
@property (nonatomic, strong) NSMutableArray *tableViewDataArray;

@end

@implementation SLManageViewController

- (NSMutableArray *)tableViewDataArray
{
    if (_tableViewDataArray == nil) {
        _tableViewDataArray = [NSMutableArray array];
    }
    return _tableViewDataArray;
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
    
    self.title = @"管理";
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

#pragma mark ----- 添加所有子控件
- (void)addSubviews
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = SLWhite;
    tableView.rowHeight = 60;
    self.tableView = tableView;
    [self.view addSubview:tableView];
    
    [self setTableHeadFootView];
}

#pragma mark ----- 设置tableViewHeadFootView
- (void)setTableHeadFootView
{
    SLManageHeadView *head = [[SLManageHeadView alloc] initWithFrame:CGRectMake(0, 0, screenW, 30)];
    head.delegate = self;
    self.tableView.tableHeaderView = head;
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenW, 0.5)];
    footView.backgroundColor = SLLightGray;
    self.tableView.tableFooterView = footView;
    
    [self loadInternetData];
}

#pragma mark ----- 加载网络数据
- (void)loadInternetData
{
    SLManageParameters *parameters = [SLManageParameters parameters];
    parameters.materialId = self.materialId;
    
    [SLManagerTool managerCustomerListForMaterialWithParameters:parameters success:^(SLResult *result) {
        
        if ([result.code isEqualToString:@"0000"]) {
            if (result.info.count > 0) {
                NSArray *dictArray = [result.info lastObject];
                
                NSArray *clientListArray = [SLClient objectArrayWithKeyValuesArray:dictArray];
                [self.tableViewDataArray removeAllObjects];
                self.clientListArray = clientListArray;
                for (SLClient *client in clientListArray) {
                    if ([client.materialUser.readFlag integerValue] > 0) {
                        [self.tableViewDataArray addObject:client];
                    }
                }
                
                [self.tableView reloadData];
            }
        }
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark ----- SLManageHeadView代理方法
- (void)manageHeadView:(SLManageHeadView *)manageHeadView didClickedFirstButton:(UIButton *)firstButton
{
    [self.tableViewDataArray removeAllObjects];
    for (SLClient *client in self.clientListArray) {
        if ([client.materialUser.readFlag integerValue] > 0) {
            [self.tableViewDataArray addObject:client];
        }
    }
    [self.tableView reloadData];
}
- (void)manageHeadView:(SLManageHeadView *)manageHeadView didClickedSecondButton:(UIButton *)secondButton
{
    [self.tableViewDataArray removeAllObjects];
    for (SLClient *client in self.clientListArray) {
        if ([client.materialUser.praiseFlag integerValue] > 0) {
            [self.tableViewDataArray addObject:client];
        }
    }
    [self.tableView reloadData];
}
- (void)manageHeadView:(SLManageHeadView *)manageHeadView didClickedThirdButton:(UIButton *)thirdButton
{
    [self.tableViewDataArray removeAllObjects];
    for (SLClient *client in self.clientListArray) {
        if ([client.materialUser.collectFlag integerValue] > 0) {
            [self.tableViewDataArray addObject:client];
        }
    }
    [self.tableView reloadData];
}
- (void)manageHeadView:(SLManageHeadView *)manageHeadView didClickedforthButton:(UIButton *)forthButton
{
    [self.tableViewDataArray removeAllObjects];
    for (SLClient *client in self.clientListArray) {
        if (client.materialUser == nil | [client.materialUser.readFlag intValue] == 0) {
            [self.tableViewDataArray addObject:client];
        }
    }
    [self.tableView reloadData];
}

#pragma mark ----- tableView Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableViewDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SLClient *client = self.tableViewDataArray[indexPath.row];
    SLManageClientFrame *manageClientFrame = [[SLManageClientFrame alloc] init];
    manageClientFrame.client = client;
    
    SLManageClientListCell *cell = [SLManageClientListCell cellWithTableView:tableView];
    
    cell.manageClientFrame = manageClientFrame;
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
