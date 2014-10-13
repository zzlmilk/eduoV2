//
//  SLFinancialProductsListController.m
//  02-pigBank
//
//  Created by 陆承东 on 14-9-25.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLFinancialProductsListController.h"
#import "MJExtension.h"

#import "SLAccount.h"
#import "SLAccountTool.h"
#import "SLClientPlate.h"
#import "SLClientPlatesTool.h"
#import "UIImage+S_LINE.h"
#import "UIBarButtonItem+SL.h"

#import "SLFinanceProduct.h"
#import "SLFinancialProductListStatus.h"
#import "SLFinancialStatusFrame.h"
#import "SLFinancialProductListCell.h"
#import "SLFinanceProductController.h"
#import "SLFinanceProductFrame.h"
#import "SLFinancialProductListTableHeadView.h"

@interface SLFinancialProductsListController ()<SLFinancialProductListTableHeadViewDelegate>

@property (nonatomic, strong) NSMutableArray *financialProductStatusFrameArray;

/** headView */
@property (nonatomic, weak) UIView *headView;
/** 预期收益率 */
@property (nonatomic, weak) UIButton *expectedYieldButton;
/** 剩余时间 */
@property (nonatomic, weak) UIButton *leftTimeButton;

/** orderType 网络参数 */
@property (nonatomic, copy) NSString *orderType;

@end

@implementation SLFinancialProductsListController

- (NSMutableArray *)financialProductStatusFrameArray
{
    if (_financialProductStatusFrameArray == nil) {
        _financialProductStatusFrameArray = [[NSMutableArray alloc] init];
    }
    return _financialProductStatusFrameArray;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /**
     *  添加tableHeadView
     */
    SLFinancialProductListTableHeadView *headView = [[SLFinancialProductListTableHeadView alloc] init];
    headView.delegate = self;
    self.tableView.tableHeaderView = headView;
    self.headView = headView;
    
    if (self.tag == 1) {
        // 设置左上角的barButton
        UIImage *iconMore = [UIImage imageNamed:@"iconMore"];
        NSParameterAssert(iconMore);
        
        self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"iconMore" highlightImage:@"iconMorePress" target:self action:@selector(more:)];
    }
}
- (void)more:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(financialProductListController:didClickMoreButton:)]) {
        [self.delegate financialProductListController:self didClickMoreButton:self.navigationItem.leftBarButtonItem];
    }
    [self.drawer open];
}

- (void)financialProductListTableHeadView:(SLFinancialProductListTableHeadView *)financialProductListTableHeadView didClickExpectedYieldButton:(UIButton *)expectedYieldButton
{
    self.orderType = @"2";
    [self loadFinancialProductsListData];
}

-(void)financialProductListTableHeadView:(SLFinancialProductListTableHeadView *)financialProductListTableHeadView didClickLeftTimeButton:(UIButton *)leftTimeButton
{
    self.orderType = @"1";
    [self loadFinancialProductsListData];
}

- (void)viewWillAppear:(BOOL)animated
{
    /**
     *  请求网络数据
     */
//    [self expectedYieldButtonClick:self.expectedYieldButton];
    self.orderType = @"2";
    [self loadFinancialProductsListData];
}

#pragma mark ----- 请求网络数据
- (void)loadFinancialProductsListData
{
    // 1.创建请求管理对象
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.封装请求参数
    // 2.1获取当前用户信息
    SLAccount *account = [SLAccountTool getAccount];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    // 2.2获取当前板块信息
    SLClientPlate *financialProductClientPlate = [SLClientPlatesTool getFinancialProductClientPlate];
    
    // 2.2封装请求数据
    // Long
    parameters[@"plateId"] = [NSNumber numberWithInteger:financialProductClientPlate.plateId];
    // Long
    //    parameters[@"classId"] = @"";
    // String
    parameters[@"orderType"] = self.orderType;
    // Integer
    parameters[@"pageSize"] = @20;
    // Integer
    parameters[@"curPage"] = @1;
    // Integer
    parameters[@"uid"] = [NSNumber numberWithInteger:account.uid];
    // String
    parameters[@"token"] = account.token;
    
    // 3.发送请求
    [mgr POST:@"http://117.79.93.100:8013/data2.0/ds/material/listFPMaterialInfo" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // 取出状态字典数组
        NSArray *dictArray = [responseObject[@"info"] lastObject];
        
        SLLog(@"%@", dictArray);
        
        NSMutableArray *financialProductStatusFrameArray = [NSMutableArray array];
        
        for (NSDictionary *dict in dictArray) {
            SLFinanceProduct *financeProduct = [SLFinanceProduct objectWithKeyValues:dict];
            SLFinancialStatusFrame *financialStatusFrame = [[SLFinancialStatusFrame alloc] init];
            financialStatusFrame.financeProduct = financeProduct;
            [financialProductStatusFrameArray addObject:financialStatusFrame];
        }
        
        _financialProductStatusFrameArray = financialProductStatusFrameArray;
        
        //        NSArray *financialProductArray = [SLFinanceProduct objectArrayWithKeyValuesArray:dictArray];
        //
        //        NSMutableArray *financialProductFrameArray = [NSMutableArray array];
        //
        //        for (SLFinanceProduct *financialProduct in financialProductArray) {
        //            SLFinancialStatusFrame *financialStatusFrame = [[SLFinancialStatusFrame alloc] init];
        //
        //            // 将所有homeStatus对象复制给对应的homeStatusFrame对象的homeStatus成员变量
        //            financialStatusFrame.financialProduct = financialProduct;
        //
        //            [financialProductFrameArray addObject:financialStatusFrame];
        //        }
        //        self.financialStatusFrameArray = financialProductFrameArray;
        
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _financialProductStatusFrameArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.创建cell
    SLFinancialProductListCell *cell = [SLFinancialProductListCell cellWithTableView:tableView];
    
    SLFinancialStatusFrame *financialStatusFrame = _financialProductStatusFrameArray[indexPath.row];
    
    // 2.给cell传递模型数据
    cell.financialStatusFrame = financialStatusFrame;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SLFinancialStatusFrame *fsf = self.financialProductStatusFrameArray[indexPath.row];
    
    return fsf.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SLFinancialStatusFrame *fsf = self.financialProductStatusFrameArray[indexPath.row];
    SLFinanceProduct *financeProduct = fsf.financeProduct;
    
    SLFinanceProductFrame *financeProductFrame = [[SLFinanceProductFrame alloc] init];
    financeProductFrame.financeProduct = financeProduct;
    
    SLFinanceProductController *financeProductController = [[SLFinanceProductController alloc] init];
    
    financeProductController.financeProductFrame = financeProductFrame;
    
    [self.navigationController pushViewController:financeProductController animated:YES];
    
}

@end
