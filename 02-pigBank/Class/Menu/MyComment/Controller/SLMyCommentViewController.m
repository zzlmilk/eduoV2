//
//  SLMyCommentViewController.m
//  02-pigBank
//
//  Created by 陆承东 on 14/12/12.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLMyCommentViewController.h"

#import "SLMyCommentParameters.h"

#import "SLMyCommentCell.h"
#import "SLMyCommentSectionFootView.h"

#import "SLMerchantDetailController.h"

#import "SLMyCommentTool.h"

#import "UIViewController+REXSideMenu.h"

@interface SLMyCommentViewController ()<UITableViewDataSource, UITableViewDelegate, SLNoNetReloadViewDelegate, MJRefreshBaseViewDelegate>

@property (nonatomic, strong) NSMutableArray *myCommentStatusFrames;

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) SLNoNetReloadView *noNetReloadView;
@property (nonatomic, weak) MJRefreshHeaderView *header;
@property (nonatomic, weak) MJRefreshFooterView *footer;
@property (nonatomic, strong) SLMyCommentParameters *parameters;

@end

@implementation SLMyCommentViewController

- (NSMutableArray *)myCommentStatusFrames
{
    if (_myCommentStatusFrames == nil) {
        _myCommentStatusFrames = [NSMutableArray array];
    }
    return _myCommentStatusFrames;
}

- (SLMyCommentParameters *)parameters
{
    if (_parameters == nil) {
        _parameters = [SLMyCommentParameters parameters];
        _parameters.pageSize = @20;
    }
    return _parameters;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.tableView) {
        [self loadNewData];
    }
    
    [self setNavBar];
}

#pragma mark ----- setNavBar设置导航栏
- (void)setNavBar
{
    // 设置左上角的barButton
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"iconMorePress" highlightImage:@"iconMore" target:self action:@selector(presentLeftMenuViewController:)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addSubviews];
}

#pragma mark ----- 添加子控件
- (void)addSubviews
{
    self.view.backgroundColor = SLWhite;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView = tableView;
    [self.view addSubview:tableView];
    
    SLNoNetReloadView *noNetReloadView = [[SLNoNetReloadView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    noNetReloadView.center = self.view.center;
    noNetReloadView.delegate = self;
    noNetReloadView.hidden = YES;
    self.noNetReloadView = noNetReloadView;
    [self.view addSubview:noNetReloadView];
    
    // 集成刷新控件
    [self setupRefreshView];
}

#pragma mark ----- SLNoNetReloadView代理方法
- (void)noNetReloadView:(SLNoNetReloadView *)noNetReloadView didClickedReloadButton:(UIButton *)reloadButton
{
    noNetReloadView.hidden = YES;
    self.tableView.hidden = NO;
    
    [self.header beginRefreshing];
}

#pragma mark ----- 刷新数据的方法
- (void)setupRefreshView
{
    // 1.下拉刷新
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    header.scrollView = self.tableView;
    header.delegate = self;
    self.header = header;
    // 加载网络数据
    [header beginRefreshing];
    
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
    int currentPage = [self.parameters.curPage intValue];
    currentPage += 1;
    self.parameters.curPage = [NSNumber numberWithInt:currentPage];
    
    [SLMyCommentTool myCommentsWithParameters:self.parameters success:^(SLResult *result) {
        
        if ([result.code isEqualToString:@"0000"]) {
            if (result.info.count > 0) {// 取出状态字典数组
                NSArray *dictArray = [result.info lastObject];
                
                if (dictArray.count > 0) {
                    NSArray *myComentStatusArray = [SLMyCommentStatus objectArrayWithKeyValuesArray:dictArray];
                    for (SLMyCommentStatus *myCommentStatus in myComentStatusArray) {
                        
                        SLMyCommentStatusFrame *myCommentStatusFrame = [[SLMyCommentStatusFrame alloc] init];
                        myCommentStatusFrame.myCommentStatus = myCommentStatus;
                        [self.myCommentStatusFrames addObject:myCommentStatusFrame];
                    }
                } else {
                    [MBProgressHUD showError:@"没有更多数据了..."];
                    int currentPage = [self.parameters.curPage intValue];
                    currentPage -= 1;
                    self.parameters.curPage = [NSNumber numberWithInt:currentPage];
                }
            } else {
                [MBProgressHUD showError:@"没有更多数据了..."];
                int currentPage = [self.parameters.curPage intValue];
                currentPage -= 1;
                self.parameters.curPage = [NSNumber numberWithInt:currentPage];
            }
        } else {
            [MBProgressHUD showError:result.msg];
            int currentPage = [self.parameters.curPage intValue];
            currentPage -= 1;
            self.parameters.curPage = [NSNumber numberWithInt:currentPage];
        }
        [self.tableView reloadData];
        // 让刷新控件停止显示刷新状态
        [self.footer endRefreshing];
    } failure:^(NSError *error) {
        [self.footer endRefreshing];
    }];
}

#pragma mark ----- loadNewData向服务器获取最新的数据
- (void)loadNewData
{
    self.parameters.curPage = @1;
    
    [SLMyCommentTool myCommentsWithParameters:self.parameters success:^(SLResult *result) {
        
        [self.myCommentStatusFrames removeAllObjects];
        
        if ([result.code isEqualToString:@"0000"]) {
            if (result.info.count > 0) {
                NSArray *dictArray = [result.info lastObject];
                
                if (dictArray.count > 0) {
                    NSArray *myComentStatusArray = [SLMyCommentStatus objectArrayWithKeyValuesArray:dictArray];
                    for (SLMyCommentStatus *myCommentStatus in myComentStatusArray) {
                        
                        SLMyCommentStatusFrame *myCommentStatusFrame = [[SLMyCommentStatusFrame alloc] init];
                        myCommentStatusFrame.myCommentStatus = myCommentStatus;
                        [self.myCommentStatusFrames addObject:myCommentStatusFrame];
                    }
                } else {
                    [MBProgressHUD showError:@"没有相关数据"];
                }
            } else {
                [MBProgressHUD showError:@"没有相关数据"];
            }
        } else {
            [MBProgressHUD showError:result.msg];
        }
        
        [self.tableView reloadData];
        // 让刷新控件停止显示刷新状态
        [self.header endRefreshing];
    } failure:^(NSError *error) {
        [self.header endRefreshing];
        self.tableView.hidden = YES;
        self.noNetReloadView.hidden = NO;
    }];
}

#pragma mark ----- Tableview datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.myCommentStatusFrames.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 创建cell
    SLMyCommentCell *cell = [SLMyCommentCell cellWithTableView:tableView];
    
    SLMyCommentStatusFrame *myCommentStatusFrame = self.myCommentStatusFrames[indexPath.section];
    cell.myCommentStatusFrame = myCommentStatusFrame;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SLMyCommentStatusFrame *frame = self.myCommentStatusFrames[indexPath.section];
    return frame.cellHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    SLMyCommentStatusFrame *myCommentStatusFrame = self.myCommentStatusFrames[section];
    SLMyCommentSectionFootView *myCommentSectionFootView = [[SLMyCommentSectionFootView alloc] initWithFrame:myCommentStatusFrame.sectionFootViewF];
    myCommentSectionFootView.backgroundColor = [UIColor whiteColor];
    myCommentSectionFootView.myCommentStatusFrame = myCommentStatusFrame;
    return myCommentSectionFootView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    SLMyCommentStatusFrame *myCommentStatusFrame = self.myCommentStatusFrames[section];
    return myCommentStatusFrame.sectionHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
}

#pragma mark ----- Tableview delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SLMyCommentStatusFrame *frame = self.myCommentStatusFrames[indexPath.section];
    SLMerchantInDetail *merchantDetail = frame.myCommentStatus.merchantDetail;
    
    SLMerchantDetailController *vc = [[SLMerchantDetailController alloc] init];
    vc.merchantId = merchantDetail.merchantId;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
