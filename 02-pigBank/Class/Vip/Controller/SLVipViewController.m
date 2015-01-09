//
//  SLVipViewController.m
//  02-pigBank
//
//  Created by 陆承东 on 14-9-13.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

#import "SLVipViewController.h"

#import "SLVipParameters.h"
#import "SLVipChildClassParameters.h"
#import "SLVipStatusFrame.h"
#import "SLVipStatus.h"


#import "SLVipStatusCell.h"
#import "SLVipHeadViewButton.h"

#import "SLVipProductViewController.h"
#import "SLVipChildViewController.h"

#import "SLHttpTool.h"
#import "SLVipStatusTool.h"
#import "UIBarButtonItem+SL.h"
#import "SLConsultantTool.h"
#import "SLAccountTool.h"

#import "UIButton+WebCache.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "UIViewController+REXSideMenu.h"

#define ButtonW 64;

@interface SLVipViewController () <UIActionSheetDelegate>

@property (nonatomic, weak) SLVipHeadViewButton *foodHeadButton;
@property (nonatomic, weak) SLVipHeadViewButton *journeyHeadButton;
@property (nonatomic, weak) SLVipHeadViewButton *liveHeadButton;
@property (nonatomic, weak) SLVipHeadViewButton *buyHeadButton;
@property (nonatomic, weak) SLVipHeadViewButton *healthHeadButton;

/** vipStatusFrame */
@property (nonatomic, strong) NSArray *vipStatusFrames;

@property (nonatomic, strong) SLConsultant *consultant;

@end

@implementation SLVipViewController

- (SLConsultant *)consultant
{
    if (_consultant == nil) {
        _consultant = [SLConsultantTool getConsultantAccount];
    }
    return _consultant;
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
    
    self.tableView.rowHeight = 70;
    
    // 设置导航栏
    [self setupNavBar];
    
    // 设置tableHeadView
    [self setupTableHeadView];
    
    [self setupVipViewData];
}

#pragma mark ----- setupNavBar设置导航栏
- (void)setupNavBar
{
    // 设置右上角的barButton
    UIBarButtonItem *callItem = [UIBarButtonItem itemWithImage:@"dianHua" highlightImage:@"dianHua" target:self action:@selector(call)];
    self.navigationItem.rightBarButtonItem = callItem;
    
    // 设置左上角的barButton
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"iconMore" highlightImage:@"iconMorePress" target:self action:@selector(presentLeftMenuViewController:)];
}

#pragma mark ----- call设置打电话的item
- (void)call
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:self.consultant.dispName delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:[NSString stringWithFormat:@"%@", self.consultant.mobile], nil];
    
    [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
}

#pragma mark ----- 点击了call按钮后弹出的actionSheet
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIWebView *callWebView = [[UIWebView alloc] init];
    [self.view addSubview:callWebView];
    
    if (buttonIndex == 0) {
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", self.consultant.mobile]];
        [callWebView loadRequest:[NSURLRequest requestWithURL:url]];
    } else if (buttonIndex == 1) {
    }
}

/**
 *  网络请求
 */
- (void)setupVipViewData
{
    SLVipParameters *parameters = [SLVipParameters parameters];
    
    // 封装请求数据
    parameters.plateId = @1;
    
    // 3.发送请求
    [SLVipStatusTool vipStatusesWithParameters:parameters success:^(NSArray *vipStatusFrameArray) {
        
        self.vipStatusFrames = vipStatusFrameArray;
        
        [self setupTableHeadView];
        
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}

/** setupTableHeadView 设置tableHeadView */
- (void)setupTableHeadView
{
    UIScrollView *tableHeadScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 86)];
    if (self.vipStatusFrames.count > 5) {
        tableHeadScrollView.contentSize = CGSizeMake(self.vipStatusFrames.count * 64, 0);
    }
    
    for (int i = 0; i < self.vipStatusFrames.count; i++) {
        
        SLVipStatusFrame *vsf = self.vipStatusFrames[i];
        
        CGFloat headButtonX = i * ButtonW;
        CGFloat headButtonY = 0;
        CGFloat headButtonW = ButtonW;
        CGFloat headButtonH = 86;
        SLVipHeadViewButton *headButton = [[SLVipHeadViewButton alloc] initWithFrame:CGRectMake(headButtonX, headButtonY, headButtonW, headButtonH)];
        headButton.tag = [vsf.vipStatus.classId intValue];
        
        [headButton setImageWithURL:[NSURL URLWithString:vsf.vipStatus.pictureUrl] forState:UIControlStateNormal];
        [headButton setTitle:vsf.vipStatus.className forState:UIControlStateNormal];
        [headButton addTarget:self action:@selector(headBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [tableHeadScrollView addSubview:headButton];
    }
    
    self.tableView.tableHeaderView = tableHeadScrollView;
}

#pragma mark ----- headBtnClick:tableHeadView按钮点击事件
- (void)headBtnClick:(SLVipHeadViewButton *)headButton
{
    SLVipChildViewController *vcvc = [[SLVipChildViewController alloc] init];
    vcvc.classId = [NSNumber numberWithInteger:headButton.tag];
    
    [self.navigationController pushViewController:vcvc animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.vipStatusFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SLVipStatusFrame *vipStatusFrame = self.vipStatusFrames[indexPath.row];
    
    // 创建cell
    SLVipStatusCell *cell = [SLVipStatusCell cellWithTableView:tableView];
    
    // 给cell传递数据
    cell.vipStatusFrame = vipStatusFrame;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SLVipStatusFrame *vipStatusFrame = self.vipStatusFrames[indexPath.row];
    SLVipStatus *vipStatus = vipStatusFrame.vipStatus;
    
    if ([vipStatus.firstMaterialInfo.templetType intValue] == 2) {
        SLVipProductViewController *vipProductController = [[SLVipProductViewController alloc] init];
        
        vipProductController.materialId = vipStatus.firstMaterialInfo.materialId;
        
        [self.navigationController pushViewController:vipProductController animated:YES];
        
    } else {
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"为您推荐";
}


@end
