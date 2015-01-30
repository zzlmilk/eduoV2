//
//  SLCollectViewController.m
//  02-pigBank
//
//  Created by 陆承东 on 15/1/26.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import "SLCollectViewController.h"

#import "SLMyCollectedItem.h"
#import "SLPlateInfo.h"

#import "SLMyCollectionHeadButton.h"
#import "SLVipStatusCell.h"
#import "SLFinancialProductListCell.h"
#import "SLOutletsListCell.h"
#import "SLMyCollectedMerchantCell.h"
#import "SLActivityListCell.h"

#import "SLVipProductViewController.h"
#import "SLFinanceProductController.h"
#import "SLOutletDetialController.h"
#import "SLMerchantDetailController.h"
#import "SLActivityDetailController.h"

#import "SLPlateInfoTool.h"
#import "SLCollectMaterialTool.h"

#import "UIBarButtonItem+SL.h"

#import "UIViewController+REXSideMenu.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "MBProgressHUD+MJ.h"

@interface SLCollectViewController ()<UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate, MJRefreshBaseViewDelegate>

@property (nonatomic, strong) NSMutableArray *paremetersArray;
@property (nonatomic, strong) NSMutableArray *myCollectedItems;

@property (nonatomic, strong) NSMutableArray *headerArray;
@property (nonatomic, strong) NSMutableArray *footerArray;

@property (nonatomic, strong) NSMutableArray *myCollectionButtons;
@property (nonatomic, strong) NSMutableArray *tableViews;
@property (nonatomic, weak) UIView *listView;
@property (nonatomic, weak) UIView *colorView;
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UITableView *selectedTableView;

@property (nonatomic, strong) NSMutableArray *myCollectedVipArray;
@property (nonatomic, strong) NSMutableArray *myCollectedFinanceProductArray;
@property (nonatomic, strong) NSMutableArray *myCollectedOutletsArray;
@property (nonatomic, strong) NSMutableArray *myCollectedActivityArray;
@property (nonatomic, strong) NSMutableArray *myCollectedMerchantArray;

@property (nonatomic, assign) BOOL refresh;

@end

@implementation SLCollectViewController

- (NSMutableArray *)myCollectedMerchantArray
{
    if (_myCollectedMerchantArray == nil) {
        _myCollectedMerchantArray = [NSMutableArray array];
    }
    return _myCollectedMerchantArray;
}

- (NSMutableArray *)myCollectedActivityArray
{
    if (_myCollectedActivityArray == nil) {
        _myCollectedActivityArray = [NSMutableArray array];
    }
    return _myCollectedActivityArray;
}

- (NSMutableArray *)myCollectedOutletsArray
{
    if (_myCollectedOutletsArray == nil) {
        _myCollectedOutletsArray = [NSMutableArray array];
    }
    return _myCollectedOutletsArray;
}

- (NSMutableArray *)myCollectedFinanceProductArray
{
    if (_myCollectedFinanceProductArray == nil) {
        _myCollectedFinanceProductArray = [NSMutableArray array];
    }
    return _myCollectedFinanceProductArray;
}

- (NSMutableArray *)myCollectedVipArray
{
    if (_myCollectedVipArray == nil) {
        _myCollectedVipArray = [NSMutableArray array];
    }
    return _myCollectedVipArray;
}

- (NSMutableArray *)tableViews
{
    if (_tableViews == nil) {
        _tableViews = [NSMutableArray array];
    }
    return _tableViews;
}

- (NSMutableArray *)footerArray
{
    if (_footerArray == nil) {
        _footerArray = [NSMutableArray array];
    }
    return _footerArray;
}

- (NSMutableArray *)headerArray
{
    if (_headerArray == nil) {
        _headerArray = [NSMutableArray array];
    }
    return _headerArray;
}

- (NSMutableArray *)myCollectionButtons
{
    if (_myCollectionButtons == nil) {
        _myCollectionButtons = [NSMutableArray array];
    }
    return _myCollectionButtons;
}

- (NSMutableArray *)myCollectedItems
{
    if (_myCollectedItems == nil) {
        _myCollectedItems = [NSMutableArray array];
    }
    return _myCollectedItems;
}

- (NSMutableArray *)paremetersArray
{
    if (_paremetersArray == nil) {
        _paremetersArray = [NSMutableArray array];
    }
    return _paremetersArray;
}

#pragma mark ----- viewWillAppear
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.selectedTableView deselectRowAtIndexPath:[self.selectedTableView indexPathForSelectedRow] animated:YES];
    
    [self setNavBar];
    
    [self refreshData];
}

#pragma mark ----- setNavBar设置导航栏
- (void)setNavBar
{
    // 设置左上角的barButton
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"iconMorePress" highlightImage:@"iconMore" target:self action:@selector(presentLeftMenuViewController:)];
}

#pragma mark ----- 刷新数据
- (void)refreshData
{
    for (UITableView *tableView in self.tableViews) {
        [self loadNewDataWithTag:tableView.tag];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setItems];
}

#pragma mark ----- 一共展示多少个列表
- (void)setItems
{
    [self.myCollectedItems removeAllObjects];
    [self.paremetersArray removeAllObjects];
    
    NSArray *plateInfoArray = [SLPlateInfoTool getInternetPlateList];
    
    for (int i = 0; i < plateInfoArray.count + 1; i ++) {
    
        SLMyCollectedItem *myCollectedItem = [[SLMyCollectedItem alloc] init];
        myCollectedItem.tag = i;
        if (i < plateInfoArray.count) {
            SLPlateInfo *plateInfo = plateInfoArray[i];
            myCollectedItem.title = plateInfo.dispName;
            myCollectedItem.imageURLStr = plateInfo.pictureUrl;
            SLCollectedMaterialParameter *parameter = [SLCollectedMaterialParameter parameters];
            parameter.pageSize = @20;
            parameter.curPage = @1;
            parameter.plateId = plateInfo.plateId;
            [self.paremetersArray addObject:parameter];
            if ([plateInfo.plateType isEqualToString:@"5"]) {
                myCollectedItem.urlstr = @"/material/collectActivityInfo";
                myCollectedItem.imageName = @"vip";
            } else {
                myCollectedItem.urlstr = @"/material/listCollectMaterial";
                if ([plateInfo.plateType isEqualToString:@"2"]) {
                    myCollectedItem.imageName = @"vip";
                } else if ([plateInfo.plateType isEqualToString:@"3"]) {
                    myCollectedItem.imageName = @"zunXiangLiCai";
                } else if ([plateInfo.plateType isEqualToString:@"4"]) {
                    myCollectedItem.imageName = @"wangDian";
                }
            }
            myCollectedItem.plateId = plateInfo.plateId;
            myCollectedItem.plateType = plateInfo.plateType;
            [self.myCollectedItems addObject:myCollectedItem];
        } else {
            SLCollectedMaterialParameter *parameter = [SLCollectedMaterialParameter parameters];
            parameter.pageSize = @20;
            parameter.curPage = @1;
            [self.paremetersArray addObject:parameter];
            myCollectedItem.title = @"商圈";
            myCollectedItem.imageName = @"shangQuan";
            myCollectedItem.imageURLStr = [SLPicHttpUrl stringByAppendingString:@"/plate/shangQuan@2x.png"];
            myCollectedItem.urlstr = @"/merchant/listCollectMerchantInfo";
            [self.myCollectedItems addObject:myCollectedItem];
        }
    }
    
    [self addSubviews];
}

#pragma mark ----- 添加子控件
- (void)addSubviews
{
    self.view.backgroundColor = [UIColor whiteColor];
    
//    for (id view in self.view.subviews) {
//        [view removeFromSuperview];
//    }
    
    UIView *tableHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, screenW, 86)];
    [self.myCollectionButtons removeAllObjects];
    CGFloat buttonW = screenW / self.myCollectedItems.count;
    for (int i = 0; i < self.myCollectedItems.count; i++) {
        SLMyCollectedItem *myCollectedItem = self.myCollectedItems[i];
        
        CGFloat headButtonX = i * buttonW;
        CGFloat headButtonY = 0;
        CGFloat headButtonW = buttonW;
        CGFloat headButtonH = 86;
        SLMyCollectionHeadButton *headButton = [[SLMyCollectionHeadButton alloc] initWithFrame:CGRectMake(headButtonX, headButtonY, headButtonW, headButtonH)];
        headButton.myCollectedItem = myCollectedItem;
        [headButton setTitle:myCollectedItem.title forState:UIControlStateNormal];
        [headButton setImage:[UIImage imageNamed:myCollectedItem.imageName] forState:UIControlStateNormal];
        headButton.tag = myCollectedItem.tag;
        [headButton addTarget:self action:@selector(headButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.myCollectionButtons addObject:headButton];
        [tableHeadView addSubview:headButton];
    }
    
    [self.view addSubview:tableHeadView];
    
    UIView *listView = [[UIView alloc] init];
    self.listView = listView;
    CGFloat listViewX = 0;
    CGFloat listViewY = 64 + 86;
    CGFloat listViewW = screenW;
    CGFloat listViewH = screenH - listViewY;
    CGRect listViewF = CGRectMake(listViewX, listViewY, listViewW, listViewH);
    listView.frame = listViewF;
    [self.view addSubview:listView];
    
    UIView *colorView = [[UIView alloc] init];
    CGFloat colorViewW = 40;
    CGFloat colorViewH = 5;
    CGFloat colorViewX = (buttonW - colorViewW) / 2;
    CGFloat colorViewY = 0;
    CGRect colorViewF = CGRectMake(colorViewX, colorViewY, colorViewW, colorViewH);
    colorView.frame = colorViewF;
    self.colorView = colorView;
    [listView addSubview:colorView];
    colorView.backgroundColor = [UIColor orangeColor];
    
    UIView *colorBgView = [[UIView alloc] init];
    CGFloat colorBgViewX = 0;
    CGFloat colorBgViewY = 4;
    CGFloat colorBgViewW = screenW;
    CGFloat colorBgViewH = 1;
    CGRect colorBgViewF = CGRectMake(colorBgViewX, colorBgViewY, colorBgViewW, colorBgViewH);
    colorBgView.frame = colorBgViewF;
    [listView addSubview:colorBgView];
    colorBgView.backgroundColor = [UIColor orangeColor];
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    self.scrollView = scrollView;
    scrollView.tag = 10;
    // 设置代理:可以通知pageControl什么时候应该切换页面
    scrollView.delegate = self;
    // 给scrollView设置frame
    CGRect scrollViewF = listView.bounds;
    scrollViewF.origin.y += 5;
    scrollViewF.size.height -= 5;
    scrollView.frame = scrollViewF;
    [listView addSubview:scrollView];
    
    [self.tableViews removeAllObjects];
    [self.headerArray removeAllObjects];
    [self.footerArray removeAllObjects];
    CGFloat tableViewW = listView.frame.size.width;
    CGFloat tableViewH = listView.frame.size.height;
    // 给scrollView添加tableView
    for (int i = 0; i < self.myCollectedItems.count; i++) {
        SLMyCollectedItem *myCollectItem = self.myCollectedItems[i];
        
        UITableView *tableView = [[UITableView alloc] init];
        tableView.tag = myCollectItem.tag;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.backgroundColor = [UIColor whiteColor];
        
        // 设置tableView的frame
        CGFloat tableViewX = i * tableViewW;
        tableView.frame = CGRectMake(tableViewX, 0, tableViewW, tableViewH);
        tableView.contentInset = UIEdgeInsetsMake(0, 0, 54, 0);
        UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenW, 0.5)];
        footView.backgroundColor = SLLightGray;
        tableView.tableFooterView = footView;
        
        // 1.下拉刷新
        MJRefreshHeaderView *header = [MJRefreshHeaderView header];
        header.scrollView = tableView;
        header.delegate = self;
        // 自动进入刷新状态
        [header beginRefreshing];
        [self.headerArray addObject:header];
        
        // 2.上拉刷新(上拉加载更多数据)
        MJRefreshFooterView *footer = [MJRefreshFooterView footer];
        footer.scrollView = tableView;
        footer.delegate = self;
        [self.footerArray addObject:footer];
        
        [self.tableViews addObject:tableView];
        // 将imageView添加到scrollView里面
        [scrollView addSubview:tableView];
    }
    
    scrollView.contentSize = CGSizeMake(tableViewW * self.myCollectedItems.count, 0);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
}

#pragma mark ----- headButton的点击事件
- (void)headButtonClicked:(SLMyCollectionHeadButton *)headButton
{
    CGFloat offsetX = headButton.tag * screenW;
    CGPoint offset = CGPointMake(offsetX, 0);
    [self.scrollView setContentOffset:offset animated:YES];
}

#pragma mark ----- 代理方法,mj刷新包的代理方法
#pragma mark ----- 刷新控件进入开始刷新状态的时候调用
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    UITableView *tableView = (UITableView *)refreshView.scrollView;
    if ([refreshView isKindOfClass:[MJRefreshFooterView class]]) { // 上拉刷新
        [self loadMoreDataWithTag:tableView.tag];
    } else { // 下拉刷新
        [self loadNewDataWithTag:tableView.tag];
    }
}

#pragma mark ----- 发送请求加载更多的数据
- (void)loadMoreDataWithTag:(NSInteger)tag
{
    MJRefreshFooterView *footer = self.footerArray[tag];
    
    SLCollectedMaterialParameter *parameters = self.paremetersArray[tag];
    int currentPage = [parameters.curPage intValue];
    currentPage += 1;
    parameters.curPage = [NSNumber numberWithInt:currentPage];
    self.paremetersArray[tag] = parameters;
    SLMyCollectedItem *item = self.myCollectedItems[tag];
    
    [SLCollectMaterialTool collcetedMaterialWithParameters:parameters urlStr:item.urlstr success:^(SLResult *result) {
        
        if ([result.code isEqualToString:@"0000"]) {
            if (result.info.count > 0) {
                NSArray *dictArray = [result.info lastObject];
                if (dictArray.count > 0) {
                    
                    UITableView *tableView = self.tableViews[tag];
                    
                    if ([item.plateType isEqualToString:@"2"]) {
                        NSArray *myCollectedVipArray = [SLVipStatusFirstMaterialInfo objectArrayWithKeyValuesArray:dictArray];
                        [self.myCollectedVipArray addObjectsFromArray:myCollectedVipArray];
                        [tableView reloadData];
                    } else if ([item.plateType isEqualToString:@"3"]) {
                        NSArray *myCollectedFinanceProductArray = [SLFinanceProduct objectArrayWithKeyValuesArray:dictArray];
                        [self.myCollectedFinanceProductArray addObjectsFromArray:myCollectedFinanceProductArray];
                        [tableView reloadData];
                    } else if ([item.plateType isEqualToString:@"4"]) {
                        NSArray *myCollectedOutletsArray = [SLOutletsInfo objectArrayWithKeyValuesArray:dictArray];
                        [self.myCollectedOutletsArray addObjectsFromArray:myCollectedOutletsArray];
                        [tableView reloadData];
                    } else if ([item.plateType isEqualToString:@"5"]) {
                        NSArray *myCollectedActivityArray = [SLActivityList objectArrayWithKeyValuesArray:dictArray];
                        [self.myCollectedActivityArray addObjectsFromArray:myCollectedActivityArray];
                    } else {
                        NSArray *myCollectedMerchantArray = [SLMerchantStatus objectArrayWithKeyValuesArray:dictArray];
                        [self.myCollectedMerchantArray addObjectsFromArray:myCollectedMerchantArray];
                        [tableView reloadData];
                    }
                } else {
                    [MBProgressHUD showError:@"没有更多数据了"];
                }
            }
        }
        [footer endRefreshing];
    } failure:^(NSError *error) {
        [footer endRefreshing];
    }];
}
/**
 *  // 刷新数据(向服务器获取更新的数据)
 */
- (void)loadNewDataWithTag:(NSInteger)tag
{
    MJRefreshHeaderView *header = self.headerArray[tag];
    
    SLCollectedMaterialParameter *parameters = self.paremetersArray[tag];
    parameters.curPage = @1;
    SLMyCollectedItem *item = self.myCollectedItems[tag];
    
    [SLCollectMaterialTool collcetedMaterialWithParameters:parameters urlStr:item.urlstr success:^(SLResult *result) {
        
        if ([result.code isEqualToString:@"0000"]) {
            if (result.info.count > 0) {
                NSArray *dictArray = [result.info lastObject];
                
                UITableView *tableView = self.tableViews[tag];
                
                if (dictArray.count > 0) {
                    
                    if ([item.plateType isEqualToString:@"2"]) {
                        NSArray *myCollectedVipArray = [SLVipStatusFirstMaterialInfo objectArrayWithKeyValuesArray:dictArray];
                        [self.myCollectedVipArray removeAllObjects];
                        [self.myCollectedVipArray addObjectsFromArray:myCollectedVipArray];
                    } else if ([item.plateType isEqualToString:@"3"]) {
                        NSArray *myCollectedFinanceProductArray = [SLFinanceProduct objectArrayWithKeyValuesArray:dictArray];
                        [self.myCollectedFinanceProductArray removeAllObjects];
                        [self.myCollectedFinanceProductArray addObjectsFromArray:myCollectedFinanceProductArray];
                        [tableView reloadData];
                    } else if ([item.plateType isEqualToString:@"4"]) {
                        NSArray *myCollectedOutletsArray = [SLOutletsInfo objectArrayWithKeyValuesArray:dictArray];
                        [self.myCollectedOutletsArray removeAllObjects];
                        [self.myCollectedOutletsArray addObjectsFromArray:myCollectedOutletsArray];
                    } else if ([item.plateType isEqualToString:@"5"]) {
                        NSArray *myCollectedActivityArray = [SLActivityList objectArrayWithKeyValuesArray:dictArray];
                        
                        for (SLActivityList *activityList in myCollectedActivityArray) {
                            NSDate *date = [NSDate dateWithTimeIntervalSince1970: [activityList.startTime longLongValue]/1000];
                            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                            [dateFormat setDateFormat:@"yyyy/MM/dd hh:mm"];
                            activityList.activityTime = [dateFormat stringFromDate:date];
                            
                            NSDate *now = [NSDate date];
                            NSTimeInterval nowTimeInterval = [now timeIntervalSince1970];
                            long long endTime = ([activityList.endTime longLongValue] / 1000 - nowTimeInterval) / 60 / 60 / 24;
                            if (endTime <= 0) {
                                activityList.status = @"已结束";
                            } else {
                                long long sign = ([activityList.startTime longLongValue] / 1000 - nowTimeInterval) / 60 / 60 / 24;
                                if (sign <= 0) {
                                    activityList.status = @"进行中";
                                } else {
                                    activityList.status = @"报名中";
                                }
                            }
                        }
                        
                        [self.myCollectedActivityArray removeAllObjects];
                        [self.myCollectedActivityArray addObjectsFromArray:myCollectedActivityArray];
                    } else {
                        NSArray *myCollectedMerchantArray = [SLMerchantStatus objectArrayWithKeyValuesArray:dictArray];
                        [self.myCollectedMerchantArray removeAllObjects];
                        [self.myCollectedMerchantArray addObjectsFromArray:myCollectedMerchantArray];
                    }
                } else {
                    if ([item.plateType isEqualToString:@"2"]) {
                        [self.myCollectedVipArray removeAllObjects];
                    } else if ([item.plateType isEqualToString:@"3"]) {
                        [self.myCollectedFinanceProductArray removeAllObjects];
                    } else if ([item.plateType isEqualToString:@"4"]) {
                        [self.myCollectedOutletsArray removeAllObjects];
                    } else if ([item.plateType isEqualToString:@"5"]) {
                        [self.myCollectedActivityArray removeAllObjects];
                    } else {
                        [self.myCollectedMerchantArray removeAllObjects];
                    }
                }
                
                [tableView reloadData];
            }
        }
        [header endRefreshing];
    } failure:^(NSError *error) {
        [header endRefreshing];
    }];
}

- (void)dealloc
{
    for (MJRefreshHeaderView *header in self.headerArray) {
        [header free];
    };
    for (MJRefreshFooterView *footer in self.headerArray) {
        [footer free];
    };
}

#pragma mark ----- scrollView的代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.tag == 10) {
        // 取出当前offset的x值
        CGFloat offsetX = scrollView.contentOffset.x;
        CGFloat buttonW = screenW / self.myCollectedItems.count;
        CGRect colorViewF = CGRectMake(buttonW, 0, 40, 5);
        colorViewF.origin.x = (offsetX / screenW) * buttonW + (buttonW - 40) / 2;
        
        self.colorView.frame = colorViewF;
    }
}

#pragma mark ----- scrollView代理方法,当scrollView滚动停下时调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.tag == 10) {
        int index = scrollView.contentOffset.x / screenW;
        SLMyCollectionHeadButton *headButton = self.myCollectionButtons[index];
        [self headButtonClicked:headButton];
    }
}

#pragma mark ----- tableView的dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    SLMyCollectedItem *item = self.myCollectedItems[tableView.tag];
    
    if ([item.plateType isEqualToString:@"2"]) {
        return self.myCollectedVipArray.count;
    } else if ([item.plateType isEqualToString:@"3"]) {
        return self.myCollectedFinanceProductArray.count;
    } else if ([item.plateType isEqualToString:@"4"]) {
        return self.myCollectedOutletsArray.count;
    } else if ([item.plateType isEqualToString:@"5"]) {
        return self.myCollectedActivityArray.count;
    } else {
        return self.myCollectedMerchantArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SLMyCollectedItem *item = self.myCollectedItems[tableView.tag];
    
    if ([item.plateType isEqualToString:@"2"]) {
        SLVipStatusFirstMaterialInfo *firstMaterialInfo = self.myCollectedVipArray[indexPath.row];
        SLVipStatus *vipStatus = [[SLVipStatus alloc] init];
        vipStatus.firstMaterialInfo = firstMaterialInfo;
        SLVipStatusFrame *vipStatusFrame = [[SLVipStatusFrame alloc] init];
        vipStatusFrame.vipStatus = vipStatus;
        
        // 创建cell
        SLVipStatusCell *cell = [SLVipStatusCell cellWithTableView:tableView];
        
        // 给cell传递数据
        cell.vipStatusFrame = vipStatusFrame;
        
        return cell;;
    } else if ([item.plateType isEqualToString:@"3"]) {
        SLFinanceProduct *financeProduct = self.myCollectedFinanceProductArray[indexPath.row];
        SLFinancialStatusFrame *financialStatusFrame = [[SLFinancialStatusFrame alloc] init];
        financialStatusFrame.financeProduct = financeProduct;
        
        // 1.创建cell
        SLFinancialProductListCell *cell = [SLFinancialProductListCell cellWithTableView:tableView];
        
        // 2.给cell传递模型数据
        cell.financialStatusFrame = financialStatusFrame;
        
        return cell;
    } else if ([item.plateType isEqualToString:@"4"]) {
        SLOutletsInfo *outlets = self.myCollectedOutletsArray[indexPath.row];
        SLOutletsListFrame *frame = [[SLOutletsListFrame alloc] init];
        frame.outletsInfo = outlets;
        
        SLOutletsListCell *cell = [SLOutletsListCell cellWithTableView:tableView];
        
        cell.outletsListFrame = frame;
        
        return cell;
    } else if ([item.plateType isEqualToString:@"5"]) {
        SLActivityList *activityList = self.myCollectedActivityArray[indexPath.row];
        SLActivityListCellFrame *activityListCellFrame = [[SLActivityListCellFrame alloc] init];
        activityListCellFrame.activityList = activityList;
        
        SLActivityListCell *cell = [SLActivityListCell cellWithTableView:tableView];
        cell.activityListCellFrame = activityListCellFrame;
        return cell;
    } else {
        SLMerchantStatus *merchantDetail = self.myCollectedMerchantArray[indexPath.row];
        SLMyMerchantCellFrame *merchantStatusFrame = [[SLMyMerchantCellFrame alloc] init];
        merchantStatusFrame.merchantDetial = merchantDetail;
        
        SLMyCollectedMerchantCell *cell = [SLMyCollectedMerchantCell cellWithTableView:tableView];
        
        cell.merchantStatusFrame = merchantStatusFrame;
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SLMyCollectedItem *item = self.myCollectedItems[tableView.tag];
    
    if ([item.plateType isEqualToString:@"2"]) {
        return 70;
    } else if ([item.plateType isEqualToString:@"3"]) {
        return 75;
    } else if ([item.plateType isEqualToString:@"4"]) {
        return 44;
    } else if ([item.plateType isEqualToString:@"5"]) {
        return 72;
    } else {
        return 70;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedTableView = tableView;
    SLMyCollectedItem *item = self.myCollectedItems[tableView.tag];
    
    if ([item.plateType isEqualToString:@"2"]) {
        SLVipStatusFirstMaterialInfo *firstMaterialInfo = self.myCollectedVipArray[indexPath.row];
        SLVipProductViewController *vpvc = [[SLVipProductViewController alloc] init];
        vpvc.materialId = firstMaterialInfo.materialId;
        vpvc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vpvc animated:YES];
    } else if ([item.plateType isEqualToString:@"3"]) {
        SLFinanceProduct *financeProduct = self.myCollectedFinanceProductArray[indexPath.row];
        SLFinanceProductController *fpvc = [[SLFinanceProductController alloc] init];
        fpvc.materialId = financeProduct.financialProductsDetail.materialId;
        fpvc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:fpvc animated:YES];
    } else if ([item.plateType isEqualToString:@"4"]) {
        SLOutletsInfo *outlets = self.myCollectedOutletsArray[indexPath.row];
        SLOutletDetialController *odvc = [[SLOutletDetialController alloc] init];
        odvc.materialId = outlets.materialId;
        odvc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:odvc animated:YES];
    } else if ([item.plateType isEqualToString:@"5"]) {
        SLActivityList *activityList = self.myCollectedActivityArray[indexPath.row];
        SLActivityDetailController *advc = [[SLActivityDetailController alloc] init];
        advc.materialId = activityList.materialId;
        advc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:advc animated:YES];
    } else {
        SLMerchantStatus *merchantDetail = self.myCollectedMerchantArray[indexPath.row];
        SLMerchantDetailController *mdvc = [[SLMerchantDetailController alloc] init];
        mdvc.merchantId = merchantDetail.merchantId;
        mdvc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:mdvc animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
