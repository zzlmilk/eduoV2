//
//  SLMenuViewController.m
//  02-pigBank
//
//  Created by 陆承东 on 14-9-25.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLMenuViewController.h"
#import "UIImageView+WebCache.h"
#import "MJExtension.h"

#import "SLAccount.h"
#import "SLAccountTool.h"
#import "SLClientPlate.h"
#import "SLClientPlatesTool.h"

#import "SLMenuGroup.h"
#import "SLMenuItem.h"
#import "SLSettingViewController.h"
#import "SLFinancialProductsListController.h"

@interface SLMenuViewController ()

/**
 *  菜单列表
 */
@property (nonatomic, strong) NSArray *menuGroups;

/**
 *  尊享理财
 */
@property (nonatomic, strong) SLClientPlate *financialProductClientPlate;

/**
 *  网点信息
 */
@property (nonatomic, strong) SLClientPlate *outletsClientPlate;

/**
 *  账号信息
 */
@property (nonatomic, strong) SLAccount *account;

@end

@implementation SLMenuViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupMenuGroupsData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self loadClientPlateData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.menuGroups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    SLMenuGroup *mg = self.menuGroups[section];
    return mg.menuItems.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SLMenuGroup *cg = self.menuGroups[indexPath.section];
    SLMenuItem *mi = cg.menuItems[indexPath.row];
    
    static NSString *ID = @"moreItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = mi.title;
    cell.imageView.image = mi.iconImage;
    if (indexPath.section == 0) {
        cell.detailTextLabel.text = mi.mobile;
    }
    
    return cell;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (indexPath.section == 0) {
//        return 60;
//    }
//    return 44;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        SLSettingViewController *settingVC = [[SLSettingViewController alloc] init];
        
        [self.navigationController pushViewController:settingVC animated:YES];
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            SLFinancialProductsListController *financialProductListC = [[SLFinancialProductsListController alloc] init];
            [self.navigationController pushViewController:financialProductListC animated:YES];
        }
    }
}

/**
 *  设置tableView的模型数据
 */
- (void)setupMenuGroupsData
{
    // 获取当前用户信息
    SLAccount *account = [SLAccountTool getAccount];
    self.account = account;
    
    SLMenuGroup *mg1 = [[SLMenuGroup alloc] init];
    
    /** mi11 */
    SLMenuItem *mi11 = [[SLMenuItem alloc] init];
    mi11.title = self.account.accountInfo.dispName;
    mi11.iconImage = [UIImage imageNamed:@"wo"];
    mi11.mobile = [NSString stringWithFormat:@"%@", self.account.accountInfo.mobile];
    
    mg1.menuItems = @[mi11];
    
    SLMenuGroup *mg2 = [[SLMenuGroup alloc] init];
    
    /** mi21 */
    SLMenuItem *mi21 = [[SLMenuItem alloc] init];
    mi21.title = @"尊享理财";
    mi21.iconImage = [UIImage imageNamed:@"zunXiangLiCai"];
    
    /** mi22 */
    SLMenuItem *mi22 = [[SLMenuItem alloc] init];
    mi22.title = @"网点信息";
    mi22.iconImage = [UIImage imageNamed:@"wangDian"];
    
    /** mi23 */
    SLMenuItem *mi23 = [[SLMenuItem alloc] init];
    mi23.title = @"商户信息";
    mi23.iconImage = [UIImage imageNamed:@"shangQuan"];
    
    mg2.menuItems = @[mi21, mi22, mi23];
    
    SLMenuGroup *mg3 = [[SLMenuGroup alloc] init];
    
    /** mi31 */
    SLMenuItem *mi31 = [[SLMenuItem alloc] init];
    mi31.title = @"我的点评";
    mi31.iconImage = [UIImage imageNamed:@"dianPing"];
    
    /** mi32 */
    SLMenuItem *mi32 = [[SLMenuItem alloc] init];
    mi32.title = @"我的收藏";
    mi32.iconImage = [UIImage imageNamed:@"MoreShouCang"];
    
    /** mi33 */
    SLMenuItem *mi33 = [[SLMenuItem alloc] init];
    mi33.title = @"我的顾问";
    mi33.iconImage = [UIImage imageNamed:@"guWen"];
    
    mg3.menuItems = @[mi31, mi32, mi33];
    
    self.menuGroups = @[mg1, mg2, mg3];
}

- (void)loadClientPlateData
{
    // 1.创建请求管理对象
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.封装请求参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    // 2.2封装请求数据
    // Long
//    parameters[@"lastTime"] = @"";
    // Integer
    parameters[@"uid"] = [NSNumber numberWithInteger:self.account.uid];
    // String
    parameters[@"token"] = self.account.token;
    
    // 3.发送请求
    [mgr POST:@"http://117.79.93.100:8013/data2.0/ds/plate/listPlateInfo" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 取出状态字典数组
        NSArray *dictArray = [responseObject[@"info"] lastObject];
        
        SLLog(@"%@", dictArray);
        
        NSArray *clientPlateArray = [SLClientPlate objectArrayWithKeyValuesArray:dictArray];
        
        // 归档
        [SLClientPlatesTool saveClientPlates:clientPlateArray];
        
        // 尊享理财板块信息
        SLClientPlate *financialProductClientPlate = clientPlateArray[1];
        self.financialProductClientPlate = financialProductClientPlate;
        
        // 网点板块信息
        SLClientPlate *outletsClientPlate = clientPlateArray[2];
        self.outletsClientPlate = financialProductClientPlate;
        
        SLLog(@"sdfa");
        //        NSMutableArray *statusFrameArray = [NSMutableArray array];
        //        for (SLHomeStatus *homeStatus in statusArray) {
        //            SLHomeStatusFrame *homeStatusFrame = [[SLHomeStatusFrame alloc] init];
        //
        //            // 将所有homeStatus对象复制给对应的homeStatusFrame对象的homeStatus成员变量
        //            homeStatusFrame.homeStatus = homeStatus;
        //
        //            [statusFrameArray addObject:homeStatusFrame];
        //        }
        //        self.homeStatusFrames = statusFrameArray;
        
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}
@end
