//
//  SLSettingViewController.m
//  02-pigBank
//
//  Created by 陆承东 on 14-9-26.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "sys/utsname.h"

#import "SLSettingViewController.h"

#import "SLSettingGroup.h"
#import "SLSettingItem.h"
#import "SLAccountInfo.h"

#import "SLLoginButton.h"

#import "SLChangeMyMobileController.h"
#import "SLModifyPwdController.h"
#import "SLLoginViewController.h"
#import "SLTabBarViewController.h"
#import "SLNavigationController.h"

#import "SLLogoutTool.h"
#import "SLUploadPicTool.h"

#import "UIViewController+REXSideMenu.h"

#define margin 6

@interface SLSettingViewController ()<UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) NSMutableArray *settingGroups;
@property (nonatomic, copy) NSString *userType;

@end

@implementation SLSettingViewController

- (NSString *)userType
{
    if (_userType == nil) {
        _userType = [SLAccountTool getAccount].accountInfo.userType;
    }
    return _userType;
}

- (NSArray *)settingGroups
{
    if (_settingGroups == nil) {
        _settingGroups = [NSMutableArray array];
    }
    return _settingGroups;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setNavBar];
}

#pragma mark ----- setNavBar设置导航栏
- (void)setNavBar
{
    // 设置左上角的barButton
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"iconMorePress" highlightImage:@"iconMore" target:self action:@selector(presentLeftMenuViewController:)];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addSubviews];
    
    self.tableView.sectionFooterHeight = 0;
    self.tableView.sectionHeaderHeight = 10;
    
    // 请求网络
    [self loadNetData];
    
    // 创建分组数据
    [self setupGroupData];
}

#pragma mark ----- 添加所有子控件
- (void)addSubviews
{
    [self setTableHeadFootView];
}

#pragma mark ----- 设置tableHeadFootView
- (void)setTableHeadFootView
{
    CGFloat headViewX = 0;
    CGFloat headViewY = 0;
    CGFloat headViewW = screenW;
    UIView *headView = [[UIView alloc] init];
    
    CGFloat iconImageViewX = middleMargin;
    CGFloat iconImageViewY = middleMargin;
    CGFloat iconImageViewW = 50;
    CGFloat iconImageViewH = iconImageViewW;
    CGRect iconImageViewF = CGRectMake(iconImageViewX, iconImageViewY, iconImageViewW, iconImageViewH);
    UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:iconImageViewF];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@", [SLAccountTool getAccount].accountInfo.pictureUrl]];
    iconImageView.layer.cornerRadius = 5;
    iconImageView.layer.masksToBounds = YES;
    iconImageView.userInteractionEnabled = YES;
    [iconImageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"wo"]];
    [iconImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconImageViewTaped:)]];
    [headView addSubview:iconImageView];
    
    CGFloat accessoryImageViewW = 60;
    CGFloat accessoryImageViewH = iconImageViewH;
    CGFloat accessoryImageViewX = screenW - accessoryImageViewW;
    CGFloat accessoryImageViewY = iconImageViewY;
    CGRect accessoryImageViewF = CGRectMake(accessoryImageViewX, accessoryImageViewY, accessoryImageViewW, accessoryImageViewH);
    UIImageView *accessoryImageView = [[UIImageView alloc] initWithFrame:accessoryImageViewF];
    accessoryImageView.image = [UIImage imageNamed:@"icon_button_rightd_normal"];
    accessoryImageView.contentMode = UIViewContentModeCenter;
    [headView addSubview:accessoryImageView];
    
    CGFloat titleLabelX = CGRectGetMaxX(iconImageViewF) + smallMargin;
    CGFloat titleLabelY = iconImageViewY + margin;
    CGFloat titleLabelW = accessoryImageViewX - titleLabelX;
    CGFloat titleLabelH = 16;
    CGRect titleLabelF = CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:titleLabelF];
    titleLabel.font = SLFont16;
    titleLabel.text = [SLAccountTool getAccount].accountInfo.dispName;
    [headView addSubview:titleLabel];
    
    CGFloat mobileLabelX = titleLabelX;
    CGFloat mobileLabelY = CGRectGetMaxY(titleLabelF) + margin;
    CGFloat mobileLabelW = titleLabelW;
    CGFloat mobileLabelH = titleLabelH;
    CGRect mobileLabelF = CGRectMake(mobileLabelX, mobileLabelY, mobileLabelW, mobileLabelH);
    UILabel *mobileLabel = [[UILabel alloc] initWithFrame:mobileLabelF];
    mobileLabel.font = SLFont16;
    mobileLabel.text = [SLAccountTool getAccount].accountInfo.mobile;
    [headView addSubview:mobileLabel];
    
    CGFloat headViewH = CGRectGetMaxY(iconImageViewF) + middleMargin;
    CGRect headViewF = CGRectMake(headViewX, headViewY, headViewW, headViewH);
    headView.frame = headViewF;
    headView.backgroundColor = SLColor(245, 245, 245);
    self.tableView.tableHeaderView = headView;
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenW, 80)];
    SLLoginButton *logoutButton = [SLLoginButton buttonWithTitle:@"登出" backgroundImage:@"login_loginButtonBg_normal" highlightBackgroundImage:@"login_loginButtonBg_highlight"];
    logoutButton.center = footView.center;
    [logoutButton addTarget:self action:@selector(logoutButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:logoutButton];
    
    self.tableView.tableFooterView = footView;
}

#pragma mark ----- 登出按钮点击事件
- (void)logoutButtonClick:(SLLoginButton *)logoutButton
{
    SLLogoutParameters *parameters = [SLLogoutParameters parameters];
    parameters.appCode = @"VIP_IOS";
    NSDictionary *infoDictionary =[[NSBundle mainBundle]infoDictionary];
    parameters.clientInfo = [NSString stringWithFormat:@"[ios][理财VIP][%@]", [infoDictionary objectForKey:@"CFBundleVersion"]];
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceModel = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    parameters.deviceInfo = [NSString stringWithFormat:@"[ios][%@][%@]", [infoDictionary objectForKey:@"CFBundleDisplayName"], deviceModel];
    
    [SLLogoutTool logoutWithWithParameters:parameters success:^(SLResult *result) {
        if ([result.code isEqualToString:@"0000"]) {
            
            SLAccount *account = [SLAccountTool getAccount];
            account.token = nil;
            [SLAccountTool saveAccount:account];
            
            [[SLTabBarViewController sharedTabbarController] dead];
            
            SLLoginViewController *loginvc = [[SLLoginViewController alloc] init];
            SLNavigationController *nav = [[SLNavigationController alloc] initWithRootViewController:loginvc];
            self.view.window.rootViewController = nav;
            
            [MBProgressHUD showSuccess:@"成功登出"];
        }
    } failure:^(NSError *error) {
        
    }];
}

- (void)iconImageViewTaped:(UITapGestureRecognizer *)tap
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从手机相册选择", nil];
    actionSheet.tag = 1;
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
        ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
        ipc.delegate = self;
        ipc.allowsEditing = YES;
        [self presentViewController:ipc animated:YES completion:nil];
        
    } else if (buttonIndex == 1) {
        
        UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
        ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        ipc.delegate = self;
        ipc.allowsEditing = YES;
        [self presentViewController:ipc animated:YES completion:nil];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // 1.销毁picker控制器
    [picker dismissViewControllerAnimated:YES completion:^{
    }];
    
    SLBaseParameters *parameters = [SLBaseParameters parameters];
    // 2.去的图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    [SLUploadPicTool uploadPicWithParameters:parameters image:image success:^(SLResult *result) {
        
    } failure:^(NSError *error) {
        
    }];
}

/**
 *  创建分组数据
 */
- (void)setupGroupData
{
    SLAccountInfo *accountInfo = [SLAccountTool getAccount].accountInfo;
    
    SLSettingGroup *sg0 = [[SLSettingGroup alloc] init];
    
    SLSettingItem *si00 = [[SLSettingItem alloc] init];
    si00.title = @"修改手机";
    
    SLSettingItem *si01 = [[SLSettingItem alloc] init];
    si01.title = @"修改密码";
    
    if ([self.userType isEqualToString:@"3"]) {
        SLSettingItem *si02 = [[SLSettingItem alloc] init];
        si02.title = @"特权身份";
        si02.info = accountInfo.vipDetail.levelSignText;
        sg0.settingItems = @[si00, si01, si02];
    } else if ([self.userType isEqualToString:@"2"]) {
        sg0.settingItems = @[si00, si01];
    }
    
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
    NSString *key = @"CFBundleVersion";
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    si12.info = currentVersion;
    
    sg1.settingItems = @[si10, si11, si12];
    [self.settingGroups addObject:sg1];
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
    
    if (indexPath.section == 0 | indexPath.section == 1) {
        if (indexPath.row == 2) {
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryNone;
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
            changeViewController.title = @"修改手机号";
            [self.navigationController pushViewController:changeViewController animated:YES];
        } else if (indexPath.row == 1) {
            SLModifyPwdController *midifyPwdController = [[SLModifyPwdController alloc] init];
            midifyPwdController.title = @"修改密码";
            [self.navigationController pushViewController:midifyPwdController animated:YES];
        }
    } else if (indexPath.section == 1) {
        if (indexPath.row == 1) {
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
            
            SLSettingGroup *sg = self.settingGroups[indexPath.section];
            SLSettingItem *si = sg.settingItems[indexPath.row];
            double totalSize = 0;
            for (NSString *subpath in subpaths) {
                NSString *fullpath = [cachePath stringByAppendingPathComponent:subpath];
                BOOL dir = NO;
                [mgr fileExistsAtPath:fullpath isDirectory:&dir];
                if (dir == NO) {// 文件
                    totalSize += [[mgr attributesOfItemAtPath:fullpath error:nil][NSFileSize] doubleValue];
                }
            }
            si.info = [NSString stringWithFormat:@"%.2fM", totalSize / 1024 / 1024];
            [tableView reloadData];
        }
    }
//    SLSettingGroup *sg = self.settingGroups[indexPath.section];
//    SLSettingItem *si = sg.settingItems[indexPath.row];
//    if (si.operation) {
//        si.operation();
//    }
//    [self.tableView reloadData];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
