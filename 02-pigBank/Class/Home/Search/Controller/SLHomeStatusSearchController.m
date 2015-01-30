//
//  SLHomeStatusSearchController.m
//  02-pigBank
//
//  Created by 陆承东 on 15/1/14.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import "SLHomeStatusSearchController.h"

#import "SLHomeStatusParameters.h"
#import "SLHomeStatusFrame.h"

#import "SLHomeStatusCell.h"

#import "SLFinanceProductController.h"
#import "SLVipProductViewController.h"

#import "SLHomeStatusSearchTool.h"

@interface SLHomeStatusSearchController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) UISearchBar *searchBar;

@property (nonatomic, strong) NSMutableArray *homeStatusFrames;

@end

@implementation SLHomeStatusSearchController

- (NSMutableArray *)homeStatusFrames
{
    if (_homeStatusFrames == nil) {
        _homeStatusFrames = [NSMutableArray array];
    }
    return _homeStatusFrames;
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
    // 隐藏返回按钮
    self.navigationItem.hidesBackButton = YES;
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = item;
    
    // searchBar
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    searchBar.delegate = self;
    searchBar.placeholder = @"搜索";
    self.searchBar = searchBar;
    self.navigationItem.titleView = searchBar;
}

#pragma mark ----- 取消按钮点击事件
- (void)cancel
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        nil;
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addSubviews];
}

- (void)addSubviews
{
    self.view.backgroundColor = SLWhite;

    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    tableView.delegate = self;
    tableView.dataSource = self;
    self.tableView = tableView;
    [self.view addSubview:tableView];
    
    [self setTableHeadFootView];
}

- (void)setTableHeadFootView
{
    UIView *footView = [[UIView alloc] initWithFrame:SLTableFootViewFrame];
    self.tableView.tableFooterView = footView;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    
    [MBProgressHUD showMessage:@"搜索中..."];
    
    // 2.2封装请求数据
    SLHomeStatusParameters *parameters = [SLHomeStatusParameters parameters];
    parameters.search = self.searchBar.text;
    parameters.pageSize = [NSNumber numberWithInt:-99];
    parameters.curPage = @1;
    
    [SLHomeStatusSearchTool homeStatusesWithParameters:parameters success:^(NSArray *homeStatusArray) {
        
        [self.homeStatusFrames removeAllObjects];
        
        if (homeStatusArray.count > 0) {
            for (int i = 0; i < homeStatusArray.count; i++) {
                
                SLHomeStatus *homeStatus = homeStatusArray[i];
                
                SLHomeStatusFrame *last = [self.homeStatusFrames lastObject];
                SLHomeStatus *lastHomeStatus = last.homeStatus;
                
                homeStatus.hideTime = [homeStatus.verifyTimeData isEqualToString:lastHomeStatus.verifyTimeData];
                
                SLHomeStatusFrame *homeStatusFrame = [[SLHomeStatusFrame alloc] init];
                homeStatusFrame.homeStatus = homeStatus;
                
                [self.homeStatusFrames addObject:homeStatusFrame];
            }
            [MBProgressHUD hideHUD];
        } else {
            [MBProgressHUD hideHUD];
            
            [MBProgressHUD showError:@"没有相关数据"];
        }
        
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Tableview datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.homeStatusFrames.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 创建cell
    SLHomeStatusCell *cell = [SLHomeStatusCell cellWithTableView:tableView];
    
    // 传递frame模型数据
    SLHomeStatusFrame *homeStatusFrame = self.homeStatusFrames[indexPath.row];
    cell.homeStatusFrame = homeStatusFrame;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SLHomeStatusFrame *homeStatusFrame = self.homeStatusFrames[indexPath.row];
    SLHomeStatus *homeStatus = homeStatusFrame.homeStatus;
    
    if ([homeStatus.templetType intValue] == 3) {
        SLFinanceProductController *financeProductController = [[SLFinanceProductController alloc] init];
        financeProductController.materialId = homeStatus.materialId;
        
        [self.navigationController pushViewController:financeProductController animated:YES];
    } else if ([homeStatus.templetType intValue] == 2) {
        SLVipProductViewController *vpvc = [[SLVipProductViewController alloc] init];
        vpvc.materialId = homeStatus.materialId;
        [self.navigationController pushViewController:vpvc animated:YES];
    }
}

#pragma mark - 代理方法 - 设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SLHomeStatusFrame *homeStatusFrame = self.homeStatusFrames[indexPath.row];
    return homeStatusFrame.cellHeight;
}

@end
