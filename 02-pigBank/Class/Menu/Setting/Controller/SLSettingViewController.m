//
//  SLSettingViewController.m
//  02-pigBank
//
//  Created by 陆承东 on 14-9-26.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLSettingViewController.h"
#import "AFNetworking.h"
#import "MBProgressHUD+MJ.h"

#import "SLSettingGroup.h"
#import "SLSettingItem.h"

#import "SLChangeMyMobileController.h"
#import "SLModifyPwdController.h"

@interface SLSettingViewController ()

@property (nonatomic, strong) NSMutableArray *settingGroups;

@end

@implementation SLSettingViewController

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
    
    self.tableView.sectionFooterHeight = 0;
    self.tableView.sectionHeaderHeight = 10;
    
    // 请求网络
    [self loadNetData];
    
    // 创建分组数据
    [self setupGroupData];
}

/**
 *  分组懒加载
 */
- (NSArray *)settingGroups
{
    if (_settingGroups == nil) {
        _settingGroups = [NSMutableArray array];
    }
    return _settingGroups;
}

/**
 *  创建分组数据
 */
- (void)setupGroupData
{
    SLSettingGroup *sg0 = [[SLSettingGroup alloc] init];
    
    SLSettingItem *si00 = [[SLSettingItem alloc] init];
    si00.title = @"修改手机";
    
    SLSettingItem *si01 = [[SLSettingItem alloc] init];
    si01.title = @"修改密码";
    
    SLSettingItem *si02 = [[SLSettingItem alloc] init];
    si02.title = @"特权身份";
    
    sg0.settingItems = @[si00, si01, si02];
    [self.settingGroups addObject:sg0];
    
    SLSettingGroup *sg1 = [[SLSettingGroup alloc] init];
    
    SLSettingItem *si10 = [[SLSettingItem alloc] init];
    si10.title = @"版本新特性";
    
    SLSettingItem *si11 = [[SLSettingItem alloc] init];
    si11.title = @"清除缓存";
    NSFileManager *mgr = [NSFileManager defaultManager];
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];

    // 计算缓存文件夹的大小
    NSArray *subpaths = [mgr subpathsAtPath:cachePath];
    double totalSize = 0;
    for (NSString *subpath in subpaths) {
        NSString *fullpath = [cachePath stringByAppendingPathComponent:subpath];
        BOOL dir = NO;
        [mgr fileExistsAtPath:fullpath isDirectory:&dir];
        if (dir == NO) {// 文件
            totalSize += [[mgr attributesOfItemAtPath:fullpath error:nil][NSFileSize] doubleValue];
        }
    }
    si11.info = [NSString stringWithFormat:@"%.2fM", totalSize / 1024 / 1024];
    si11.operation =  ^{
        // 弹框
        [MBProgressHUD showMessage:@"哥正在帮你拼命清理中..."];
        
        // 执行清除缓存
        NSFileManager *mgr = [NSFileManager defaultManager];
        NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        
        NSArray *subpaths = [mgr subpathsAtPath:cachePath];
        for (NSString *subpath in subpaths) {
            NSString *fullpath = [cachePath stringByAppendingPathComponent:subpath];
            [mgr removeItemAtPath:fullpath error:nil];
        }
        
        // 关闭弹框
        [MBProgressHUD hideHUD];
    };
    
    SLSettingItem *si12 = [[SLSettingItem alloc] init];
    si12.title = @"当前版本";
    si12.info = @"2.1";
    
    sg1.settingItems = @[si10, si11, si12];
    [self.settingGroups addObject:sg1];
    
//    [self.tableView reloadData];
}

/**
 *  请求网络
 */
- (void)loadNetData
{
    // 1.创建请求管理对象
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.封装请求参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    // 2.2封装请求数据
    // 固定参数
    parameters[@"appCode"] = @"VIP_IOS";
    
    // 3.发送请求
    [mgr POST:@"http://117.79.93.100:8013/data2.0/ds/version/catchLastVersion" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 取出状态字典数组
        NSArray *dictArray = [responseObject[@"info"] lastObject];
        
        SLLog(@"%@", dictArray);
        
//        NSArray *clientPlateArray = [SLClientPlate objectArrayWithKeyValuesArray:dictArray];
//        
//        // 归档
//        [SLClientPlatesTool saveClientPlates:clientPlateArray];
        
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.settingGroups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    SLSettingGroup *sg = self.settingGroups[section];
    return sg.settingItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SLSettingGroup *sg = self.settingGroups[indexPath.section];
    SLSettingItem *si = sg.settingItems[indexPath.row];
    
    static NSString *ID = @"settingItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        if (si.info) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        } else {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    
    cell.textLabel.text = si.title;
    cell.detailTextLabel.text = si.info;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) { // 修改手机
            SLChangeMyMobileController *changeViewController = [[SLChangeMyMobileController alloc] init];
            [self.navigationController pushViewController:changeViewController animated:YES];
        } else if (indexPath.row == 1) {
            SLModifyPwdController *midifyPwdController = [[SLModifyPwdController alloc] init];
            [self.navigationController pushViewController:midifyPwdController animated:YES];
        }
    }
    SLSettingGroup *sg = self.settingGroups[indexPath.section];
    SLSettingItem *si = sg.settingItems[indexPath.row];
    if (si.operation) {
        si.operation();
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
