//
//  SLVipViewController.m
//  02-pigBank
//
//  Created by 陆承东 on 14-9-13.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLVipViewController.h"
#import "UIBarButtonItem+SL.h"
#import "SLVipHeadViewButton.h"
#import "AFNetworking.h"
#import "SLAccountTool.h"
#import "SLAccount.h"
#import "SLVipStatus.h"
#import "SLVipStatusFrame.h"
#import "MJExtension.h"
#import "SLVipStatusCell.h"
#import "SLVipProductViewController.h"

@interface SLVipViewController ()

@property (nonatomic, weak) SLVipHeadViewButton *foodHeadButton;
@property (nonatomic, weak) SLVipHeadViewButton *journeyHeadButton;
@property (nonatomic, weak) SLVipHeadViewButton *liveHeadButton;
@property (nonatomic, weak) SLVipHeadViewButton *buyHeadButton;
@property (nonatomic, weak) SLVipHeadViewButton *healthHeadButton;

/** vipStatusFrame */
@property (nonatomic, strong) NSMutableArray *vipStatusFrames;

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
    
    // 设置左上角的barButton
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"iconMore" highlightImage:@"iconMorePress" target:self action:@selector(more)];
    
    /**
     *  设置tableHeadView
     */
    [self setupTableHeadView];
    
    [self setupVipViewData];
    
    self.tableView.rowHeight = 70;
}

/**
 *  网络请求
 */
- (void)setupVipViewData
{
    // 1.创建请求管理对象
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.封装请求参数
    // 2.1获取当前用户信息
    SLAccount *account = [SLAccountTool getAccount];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    // 2.2封装请求数据
    parameters[@"plateId"] = @1;
    parameters[@"uid"] = [NSNumber numberWithInteger:account.uid];
    parameters[@"token"] = account.token;
    
    // 3.发送请求
    [mgr POST:@"http://117.79.93.100:8013/data2.0/ds/plate/listPlateClass" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
    
        // 取出状态字典数组
        NSArray *dictArray = [responseObject[@"info"] lastObject];
        SLLog(@"%@", dictArray[0]);
        NSMutableArray *vipStatusFrameArray = [NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            SLVipStatus *vipStatus = [SLVipStatus objectWithKeyValues:dict];
            SLVipStatusFrame *vipStatusFrame = [[SLVipStatusFrame alloc] init];
            vipStatusFrame.vipStatus = vipStatus;
            [vipStatusFrameArray addObject:vipStatusFrame];
        }
        
        self.vipStatusFrames = vipStatusFrameArray;
        
//        NSArray *statusArray = [SLVipStatus objectArrayWithKeyValuesArray:dictArray];
//        NSMutableArray *statusFrameArray = [NSMutableArray array];
//        for (SLVipStatus *vipStatus in statusArray) {
//            SLVipStatusFrame *vipStatusFrame = [[SLVipStatusFrame alloc] init];
//
//            // 将所有homeStatus对象复制给对应的homeStatusFrame对象的homeStatus成员变量
//            vipStatusFrame.vipStatus = vipStatus;
//            
//            [statusFrameArray addObject:vipStatusFrame];
//        }
//        self.vipStatusFrames = statusFrameArray;
        
        SLLog(@"---------------%@", self.vipStatusFrames);
        
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

/** setupTableHeadView 设置tableHeadView */
- (void)setupTableHeadView
{
    UIView *tableHeadView = [[UIView alloc] init];
    tableHeadView.frame = CGRectMake(0, 0, self.view.frame.size.width, 86);
    
    /** food 食 */
    SLVipHeadViewButton *foodHeadButton = [[SLVipHeadViewButton alloc] initWithFrame:CGRectMake(0, 0, 64, 86)];
    [foodHeadButton setImage:[UIImage imageNamed:@"meiShi"] forState:UIControlStateNormal];
    [foodHeadButton setTitle:@"食" forState:UIControlStateNormal];
    [foodHeadButton addTarget:self action:@selector(foodBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.foodHeadButton = foodHeadButton;
    [tableHeadView addSubview:foodHeadButton];
    
    /** journey 行 */
    SLVipHeadViewButton *journeyHeadButton = [[SLVipHeadViewButton alloc] initWithFrame:CGRectMake(64 * 1, 0, 64, 86)];
    [journeyHeadButton setImage:[UIImage imageNamed:@"chuXing"] forState:UIControlStateNormal];
    [journeyHeadButton setTitle:@"行" forState:UIControlStateNormal];
    [journeyHeadButton addTarget:self action:@selector(journeyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.journeyHeadButton = journeyHeadButton;
    [tableHeadView addSubview:journeyHeadButton];
    
    /** live 住 */
    SLVipHeadViewButton *liveHeadButton = [[SLVipHeadViewButton alloc] initWithFrame:CGRectMake(64 * 2, 0, 64, 86)];
    [liveHeadButton setImage:[UIImage imageNamed:@"jiuDian"] forState:UIControlStateNormal];
    [liveHeadButton setTitle:@"住" forState:UIControlStateNormal];
    [liveHeadButton addTarget:self action:@selector(liveBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.liveHeadButton = liveHeadButton;
    [tableHeadView addSubview:liveHeadButton];
    
    /** buy 购 */
    SLVipHeadViewButton *buyHeadButton = [[SLVipHeadViewButton alloc] initWithFrame:CGRectMake(64 * 3, 0, 64, 86)];
    [buyHeadButton setImage:[UIImage imageNamed:@"GouWu"] forState:UIControlStateNormal];
    [buyHeadButton setTitle:@"购" forState:UIControlStateNormal];
    [buyHeadButton addTarget:self action:@selector(buyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.buyHeadButton = buyHeadButton;
    [tableHeadView addSubview:buyHeadButton];
    
    /** health 健康 */
    SLVipHeadViewButton *healthHeadButton = [[SLVipHeadViewButton alloc] initWithFrame:CGRectMake(64 * 4, 0, 64, 86)];
    [healthHeadButton setImage:[UIImage imageNamed:@"jianKang"] forState:UIControlStateNormal];
    [healthHeadButton setTitle:@"健康" forState:UIControlStateNormal];
    [healthHeadButton addTarget:self action:@selector(healthBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.healthHeadButton = healthHeadButton;
    [tableHeadView addSubview:healthHeadButton];
    
    self.tableView.tableHeaderView = tableHeadView;
}


/**
 *  healthBtnClick
 */
- (void)healthBtnClick:(SLVipHeadViewButton *)healthHeadButton
{
    SLLog(@"health-----------click");
}
/**
 *  buyBtnClick
 */
- (void)buyBtnClick:(SLVipHeadViewButton *)buyHeadButton
{
    SLLog(@"buy-----------click");
}
/**
 *  liveBtnClick
 */
- (void)liveBtnClick:(SLVipHeadViewButton *)liveHeadButton
{
    SLLog(@"live-----------click");
}
/**
 *  journeyBtnClick
 */
- (void)journeyBtnClick:(SLVipHeadViewButton *)journeyHeadButton
{
    SLLog(@"journey-----------click");
}
/**
 *  foodBtnClick
 */
- (void)foodBtnClick:(SLVipHeadViewButton *)foodHeadButton
{
    SLLog(@"food-----------click");
    
    self.tabBarController.selectedIndex = 0;
//    self.tabBarController
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
