//
//  SLConsultantDetailController.m
//  02-pigBank
//
//  Created by 陆承东 on 15/1/12.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import "SLConsultantDetailController.h"

#import "SLSelectConsultantParameters.h"

#import "SLConsultantDetailIconCell.h"
#import "SLConsultantIntroductionCell.h"
#import "SLBackButton.h"
#import "SLClientToolBar.h"

#import "SLMessageListController.h"
#import "SLMessageViewController.h"
#import "SLClientListTableViewController.h"
#import "SLMyConsultantController.h"

#import "SLAccountTool.h"
#import "SLConsultantTool.h"
#import "SLSelectConsultantTool.h"
#import "SLConsultantTool.h"

#import "MBProgressHUD+MJ.h"
#import "NSString+S_LINE.h"

@interface SLConsultantDetailController () <UIActionSheetDelegate, SLConsultantDetailIconCellDelegate, SLClientToolBarDelegate>

@end

@implementation SLConsultantDetailController

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
    
    [self setTableFootView];
    
    [self addSubviews];
}

- (void)addSubviews
{
    CGFloat toolBarW = screenW;
    CGFloat toolBarH = 49;
    CGFloat toolBarX = 0;
    CGFloat toolBarY = screenH - toolBarH - 64;
    SLClientToolBar *toolBar = [[SLClientToolBar alloc] initWithFrame:CGRectMake(toolBarX, toolBarY, toolBarW, toolBarH)];
    toolBar.delegate = self;
    [self.view addSubview:toolBar];
}

- (void)clientToolBar:(SLClientToolBar *)clientToolBar didClickedLeftButton:(SLTabBarButton *)leftButton
{
    SLAccount *account = [SLAccountTool getAccount];
    
    if ([account.accountInfo.userType isEqualToString:@"3"]) {
        SLMessageViewController *messagevc = [[SLMessageViewController alloc] init];
        messagevc.from = @"toolBar";
        [self.navigationController pushViewController:messagevc animated:YES];
    } else if ([account.accountInfo.userType isEqualToString:@"2"]) {
        SLMessageListController *mlvc = [[SLMessageListController alloc] init];
        mlvc.from = @"toolBar";
        [self.navigationController pushViewController:mlvc animated:YES];
    }
}

- (void)clientToolBar:(SLClientToolBar *)clientToolBar didClickedRightButton:(SLTabBarButton *)rightButton
{
    SLAccount *account = [SLAccountTool getAccount];
    
    if ([account.accountInfo.userType isEqualToString:@"2"]) {
        SLClientListTableViewController *clvc = [[SLClientListTableViewController alloc] init];
        clvc.from = @"toolBar";
        [self.navigationController pushViewController:clvc animated:YES];
    } else if ([account.accountInfo.userType isEqualToString:@"3"]) {
        [self setActionSheet];
    }
}

#pragma mark ----- 设置actionSheet
- (void)setActionSheet
{
    SLConsultant *consultant = [SLConsultantTool getConsultantAccount];
    
    UIActionSheet *actionSheet;
    if (consultant.mobile) {
        if (consultant.telephone) {
            actionSheet = [[UIActionSheet alloc] initWithTitle:consultant.dispName delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:consultant.mobile, consultant.telephone, nil];
        } else {
            actionSheet = [[UIActionSheet alloc] initWithTitle:consultant.dispName delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:consultant.mobile, nil];
        }
    } else {
        if (consultant.telephone) {
            actionSheet = [[UIActionSheet alloc] initWithTitle:consultant.dispName delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:consultant.telephone, nil];
        } else {
            actionSheet = [[UIActionSheet alloc] initWithTitle:consultant.dispName delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:nil];
        }
    }
    
    [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIWebView *callWebView = [[UIWebView alloc] init];
    [self.view addSubview:callWebView];
    
    SLConsultant *consultant = [SLConsultantTool getConsultantAccount];
    
    if (consultant.mobile) {
        if (consultant.telephone) {
            if (buttonIndex == 0) {
                NSURL *url = [NSURL URLWithString:consultant.mobile];
                [callWebView loadRequest:[NSURLRequest requestWithURL:url]];
            } else if (buttonIndex == 1) {
                NSURL *url = [NSURL URLWithString:consultant.telephone];
                [callWebView loadRequest:[NSURLRequest requestWithURL:url]];
            } else if (buttonIndex == 2) {
            }
        } else {
            if (buttonIndex == 0) {
                NSURL *url = [NSURL URLWithString:consultant.mobile];
                [callWebView loadRequest:[NSURLRequest requestWithURL:url]];
            } else if (buttonIndex == 1) {
            }
        }
    } else {
        if (consultant.telephone) {
            if (buttonIndex == 0) {
                NSURL *url = [NSURL URLWithString:consultant.telephone];
                [callWebView loadRequest:[NSURLRequest requestWithURL:url]];
            } else if (buttonIndex == 1) {
            }
        } else {
            if (buttonIndex == 0) {
            }
        }
    }
}

- (void)setTableFootView
{
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenW, 0.5)];
    footView.backgroundColor = [UIColor lightGrayColor];
    
    self.tableView.tableFooterView = footView;
}

#pragma mark ----- Tableview datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        SLConsultantDetailIconCell *cell = [SLConsultantDetailIconCell cellWithTableView:tableView];
        
        cell.consultant = self.consultant;
        cell.delegate = self;
        
        return cell;
    } else if (indexPath.row == 1) {
        static NSString *ID = @"SLConsultantIntroductionCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        
        cell.textLabel.font = SLFont14;
        if (self.consultant.introduction == nil) {
            cell.textLabel.text = [NSString stringWithFormat:@"简介：暂无简介"];
        } else {
            cell.textLabel.text = [NSString stringWithFormat:@"简介：%@", self.consultant.introduction];
        }
        
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 60;
    } else {
        CGSize size = [self.consultant.introduction sizeWithFont:SLFont14 maxSize:CGSizeMake(screenW - largeMargin, CGFLOAT_MAX)];
        if (size.height < 44) {
            return 44;
        } else {
            return size.height;
        }
    }
}

#pragma mark ----- SLConsultantDetailIconCell代理方法
- (void)consultantDetailIconCell:(SLConsultantDetailIconCell *)consultantDetailIconCell didClickSelectButton:(UIButton *)selectButton
{
    SLSelectConsultantParameters *parameters = [SLSelectConsultantParameters parameters];
    parameters.consultantId = self.consultant.userId;
    
    [SLSelectConsultantTool selectConsultantWithParameters:parameters success:^(SLResult *result) {
        
        /*
         0000：接口业务调用成功
         9999：接口业务调用失败
         9998：登陆信息验证失败
         9996：逻辑上禁止访。VIP用户无权限修改理财顾问（客户端服务注册方式非开放注册，用户已有理财顾问）
         9001: 找不到指定理财顾问
         9010: VIP功能，非VIP用户无权限使用
         */
        
        if ([result.code intValue] == 0000) {
            
            [MBProgressHUD showSuccess:@"理财顾问设置成功"];
            
            // 归档
            [SLConsultantTool saveConsultantAccount:self.consultant];
            
            for (UIViewController *vc in self.navigationController.viewControllers) {
                if ([vc isKindOfClass:[SLMyConsultantController class]]) {
                    [self.navigationController popToViewController:vc animated:YES];
                }
            }
        }
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
