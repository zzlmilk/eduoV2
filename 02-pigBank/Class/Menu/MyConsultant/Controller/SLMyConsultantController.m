//
//  SLMyConsultantController.m
//  02-pigBank
//
//  Created by 陆承东 on 14/10/21.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLMyConsultantController.h"

#import "SLConsultant.h"

#import "SLMyConsultantIconCell.h"

#import "SLConsultantListController.h"

#import "SLMyConsultantTool.h"
#import "SLConsultantTool.h"
#import "UIBarButtonItem+SL.h"

#import "MBProgressHUD+MJ.h"
#import "UIViewController+REXSideMenu.h"

@interface SLMyConsultantController ()

@property (nonatomic, strong) SLConsultant *myConsultant;

@end

@implementation SLMyConsultantController

- (void)viewWillAppear:(BOOL)animated
{
    self.myConsultant = [SLConsultantTool getConsultantAccount];
    
    [self.tableView reloadData];
    
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
    
    [self setTableHeadFootView];
}

#pragma mark ----- 设置tableHeadFootView
- (void)setTableHeadFootView
{
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenW, 0.5)];
    footView.backgroundColor = SLLightGray;
    self.tableView.tableFooterView = footView;
}

#pragma mark ----- Tableview datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        SLMyConsultantIconCell *cell = [SLMyConsultantIconCell cellWithTableView:tableView];
        
        cell.myConsultant = self.myConsultant;
        
        return cell;
    } else if (indexPath.row == 1) {
        static NSString *ID = @"MyConsultantIntroductionCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        cell.textLabel.font = SLFont16;
        if (self.myConsultant.introduction == nil) {
            cell.textLabel.text = [NSString stringWithFormat:@"简介：暂无简介"];
        } else {
            cell.textLabel.text = [NSString stringWithFormat:@"简介：%@", self.myConsultant.introduction];
        }
        
        return cell;
        
    } else {static NSString *ID = @"MyConsultantCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        cell.textLabel.font = SLFont16;
        cell.textLabel.text = @"更改理财顾问";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 80;
    } else {
        return 44;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2) {
        SLConsultantListController *clvc = [[SLConsultantListController alloc] init];
        clvc.userId = self.myConsultant.userId;
        clvc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:clvc animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
