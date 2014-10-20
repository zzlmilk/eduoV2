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

#import "SLMenuGroup.h"
#import "SLMenuArrowItem.h"
#import "SLBaseParameters.h"

#import "SLMenuCell.h"
#import "SLMyInfoCell.h"

#import "SLSettingViewController.h"
#import "SLFinancialProductsListController.h"
#import "SLOutletsViewController.h"
#import "SLMerchantControllerController.h"

#import "SLAccount.h"
#import "SLAccountTool.h"
#import "SLClientPlate.h"
#import "SLClientPlatesTool.h"
#import "SLHttpTool.h"


@interface SLMenuViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate>

/** 菜单列表 */
@property (nonatomic, strong) NSMutableArray *menuGroups;

/** 尊享理财 */
@property (nonatomic, strong) SLClientPlate *financialProductClientPlate;

/** 网点信息 */
@property (nonatomic, strong) SLClientPlate *outletsClientPlate;

/** 账号信息 */
@property (nonatomic, strong) SLAccount *account;

/** 账号信息 */
@property (nonatomic, strong) UIImage *iconImage;

@end

@implementation SLMenuViewController

- (NSMutableArray *)menuGroups
{
    if (_menuGroups == nil) {
        _menuGroups = [NSMutableArray array];
    }
    return _menuGroups;
}

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
    self.tableView.contentInset = UIEdgeInsetsMake(-30, 0, 0, 0);
    
    [self setupGroup0];
    [self setupGroup1];
    [self setupGroup2];
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
    
    if (indexPath.section == 0) {
        SLMyInfoCell *cell = [SLMyInfoCell cellWithTableView:tableView];
        cell.menuItem = mi;
        cell.imageView.userInteractionEnabled = YES;
        [cell.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconImageTaped:)]];
        return cell;
    } else {
        SLMenuCell *cell = [SLMenuCell cellWithTableView:tableView];
        cell.menuItem = mi;
        return cell;
    }
}

- (void)iconImageTaped:(UIImageView *)imageView
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从手机相册选择", nil];
    
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
    self.tabBarController.selectedIndex = 3;
    
    // 1.销毁picker控制器
    [picker dismissViewControllerAnimated:YES completion:^{
        self.tabBarController.selectedIndex = 3;
    }];
    
    NSString *url = [SLHttpUrl stringByAppendingString:@"/user/uploadAndChangeUserPhoto"];
    
    SLBaseParameters *parameters = [SLBaseParameters parameters];
    // 2.去的图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    NSMutableArray *formDataArray = [NSMutableArray array];
    SLFormData *formData = [[SLFormData alloc] init];
    formData.data = UIImageJPEGRepresentation(image, 0.000001);
    formData.name = @"photo";
    formData.mimeType = @"image/jpeg";
    formData.filename = @"";
    [formDataArray addObject:formData];
    
    [SLHttpTool postWithUrlstr:url parameters:parameters.keyValues formDataArray:formDataArray success:^(id responseObject) {
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
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
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SLMenuGroup *menuGroup = self.menuGroups[indexPath.section];
    SLMenuItem *menuItem = menuGroup.menuItems[indexPath.row];
    
    if ([menuItem isKindOfClass:[SLMenuArrowItem class]]) {
        SLMenuArrowItem *arrowItem = (SLMenuArrowItem *)menuItem;
        if (arrowItem.destVcClass) {
            UIViewController *vc = [[arrowItem.destVcClass alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    
//    if (indexPath.section == 0) {
//        SLSettingViewController *settingVC = [[SLSettingViewController alloc] init];
//        
//        [self.navigationController pushViewController:settingVC animated:YES];
//    } else if (indexPath.section == 1) {
//        if (indexPath.row == 0) {
//            SLFinancialProductsListController *financialProductListC = [[SLFinancialProductsListController alloc] init];
//            [self.navigationController pushViewController:financialProductListC animated:YES];
//        }
//    }
}


- (SLMenuGroup *)addGroup
{
    SLMenuGroup *group = [[SLMenuGroup alloc] init];
    [self.menuGroups addObject:group];
    return group;
}

- (void)setupGroup0
{
    SLMenuGroup *menuGroup = [self addGroup];
    
    SLMenuArrowItem *mai1 = [SLMenuArrowItem itemWithIcon:@"wo" title:[SLAccountTool getAccount].accountInfo.dispName destVcClass:[SLSettingViewController class]];
    menuGroup.menuItems = @[mai1];
}
- (void)setupGroup1
{
    SLMenuGroup *menuGroup = [self addGroup];
    
    SLMenuArrowItem *mai1 = [SLMenuArrowItem itemWithIcon:@"zunXiangLiCai" title:@"尊享理财" destVcClass:[SLFinancialProductsListController class]];
    SLMenuArrowItem *mai2 = [SLMenuArrowItem itemWithIcon:@"wangDian" title:@"网点信息" destVcClass:[SLOutletsViewController class]];
    SLMenuArrowItem *mai3 = [SLMenuArrowItem itemWithIcon:@"shangQuan" title:@"商户信息" destVcClass:[SLMerchantControllerController class]];
    
    
    menuGroup.menuItems = @[mai1, mai2, mai3];
}
- (void)setupGroup2
{
    SLMenuGroup *menuGroup = [self addGroup];
    
    SLMenuArrowItem *mai1 = [SLMenuArrowItem itemWithIcon:@"dianPing" title:@"我的点评" destVcClass:nil];
    SLMenuArrowItem *mai2 = [SLMenuArrowItem itemWithIcon:@"MoreShouCang" title:@"我的收藏" destVcClass:nil];
    SLMenuArrowItem *mai3 = [SLMenuArrowItem itemWithIcon:@"guWen" title:@"我的顾问" destVcClass:[SLSettingViewController class]];
    
    menuGroup.menuItems = @[mai1, mai2, mai3];
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
    SLBaseParameters *parameters = [SLBaseParameters parameters];
    
    [SLClientPlatesTool clientPlateWithParameters:parameters success:^(NSArray *clientPlateArray) {
        
        // 尊享理财板块信息
        SLClientPlate *financialProductClientPlate = clientPlateArray[1];
        self.financialProductClientPlate = financialProductClientPlate;
        
        // 网点板块信息
        SLClientPlate *outletsClientPlate = clientPlateArray[2];
        self.outletsClientPlate = outletsClientPlate;
        
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}
@end
