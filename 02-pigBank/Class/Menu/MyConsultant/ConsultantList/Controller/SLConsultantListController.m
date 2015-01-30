//
//  SLConsultantListController.m
//  02-pigBank
//
//  Created by 陆承东 on 15/1/10.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import "SLConsultantListController.h"

#import "SLConsultantListParameters.h"

#import "SLConsultantListCell.h"
#import "SLBackButton.h"

#import "SLConsultantDetailController.h"

#import "SLConsultantListTool.h"

#import "MBProgressHUD+MJ.h"

@interface SLConsultantListController ()<UISearchBarDelegate>

@property (nonatomic, strong) NSArray *consultantList;

@property (nonatomic, weak) UISearchBar *searchBar;

@end

@implementation SLConsultantListController

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
}

#pragma mark ----- backButtonClicked返回按钮点击事件
- (void)backButtonClicked:(SLBackButton *)backButton
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [MBProgressHUD showMessage:@"列表加载中"];
    
    self.tableView.rowHeight = 60;
    
    [self loadInternetData];
    
    [self setTableHeadFootView];
}

#pragma mark ----- setTableHeadView设置tableHeadView
- (void)setTableHeadFootView
{
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, screenW, 30)];
    searchBar.delegate = self;
    searchBar.searchBarStyle = UISearchBarStyleMinimal;
    searchBar.barTintColor = [UIColor clearColor];
    self.tableView.tableHeaderView = searchBar;
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenW, 0.5)];
    footView.backgroundColor = SLLightGray;
    self.tableView.tableFooterView = footView;
}

#pragma mark ----- searchBar代理方法：当searchBar的文字改变时调用
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    SLConsultantListParameters *parameters = [SLConsultantListParameters parameters];
    parameters.pageSize = [NSNumber numberWithInt:-99];
    parameters.curPage = @1;
    parameters.search = searchText;
    
    [SLConsultantListTool consultantListWithParameters:parameters success:^(NSArray *consultantList) {
        
        self.consultantList = consultantList;
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark ----- loadInternetData加载网络数据
- (void)loadInternetData
{
    SLConsultantListParameters *parameters = [SLConsultantListParameters parameters];
    parameters.pageSize = [NSNumber numberWithInt:-99];
    parameters.curPage = @1;
    
    [SLConsultantListTool consultantListWithParameters:parameters success:^(NSArray *consultantList) {
        
        self.consultantList = consultantList;
        [self.tableView reloadData];
        
        [MBProgressHUD hideHUD];
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark ------ Tableview datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.consultantList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SLConsultant *consultant = self.consultantList[indexPath.row];
    
    SLConsultantListCell *cell = [SLConsultantListCell cellWithTableView:tableView];
    
    cell.userId = self.userId;
    cell.consultant = consultant;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SLConsultant *consultant = self.consultantList[indexPath.row];
    
    SLConsultantDetailController *cdvc = [[SLConsultantDetailController alloc] init];
    cdvc.consultant = consultant;
    [self.navigationController pushViewController:cdvc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
