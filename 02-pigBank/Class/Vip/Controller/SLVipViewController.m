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

#import "UIButton+WebCache.h"
#import "MJExtension.h"
#import "MJRefresh.h"

#define ButtonW 64;

@interface SLVipViewController () 

@property (nonatomic, weak) SLVipHeadViewButton *foodHeadButton;
@property (nonatomic, weak) SLVipHeadViewButton *journeyHeadButton;
@property (nonatomic, weak) SLVipHeadViewButton *liveHeadButton;
@property (nonatomic, weak) SLVipHeadViewButton *buyHeadButton;
@property (nonatomic, weak) SLVipHeadViewButton *healthHeadButton;

/** vipStatusFrame */
@property (nonatomic, strong) NSArray *vipStatusFrames;

@end

@implementation SLVipViewController

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
    
    // 设置左上角的barButton
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"iconMore" highlightImage:@"iconMorePress" target:self action:@selector(more)];
    
    /**
     *  设置tableHeadView
     */
    [self setupTableHeadView];
    
    [self setupVipViewData];
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

- (void)headBtnClick:(SLVipHeadViewButton *)headButton
{
    SLVipChildViewController *vcvc = [[SLVipChildViewController alloc] init];
    vcvc.classId = [NSNumber numberWithInt:headButton.tag];
    
    [self.navigationController pushViewController:vcvc animated:YES];
}


/**
 *  点击更多按钮弹出侧滑菜单
 */
- (void)more
{
    if ([self.delegate respondsToSelector:@selector(vipViewController:didClickMoreButton:)]) {
        [self.delegate vipViewController:self didClickMoreButton:self.navigationItem.leftBarButtonItem];
    }
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
    
    if (vipStatus.firstMaterialInfo.templetType == 2) {
        SLVipProductViewController *vipProductController = [[SLVipProductViewController alloc] init];
        
        vipProductController.vipStatus = vipStatus;
        
        [self.navigationController pushViewController:vipProductController animated:YES];
        
    } else {
        //        self.titleLabel.text = [NSString stringWithFormat:@"【VIP特权】%@", homeStatus.title];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"为您推荐";
}


@end
