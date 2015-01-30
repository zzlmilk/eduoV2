//
//  SLMyCollectionController.m
//  02-pigBank
//
//  Created by 陆承东 on 14/10/21.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLMyCollectionController.h"

#import "SLMyCollectedItem.h"
#import "SLCollectedMaterialParameter.h"
#import "SLPlateInfo.h"

#import "SLMyCollectionHeadButton.h"
#import "SLVipStatusCell.h"
#import "SLFinancialProductListCell.h"
#import "SLOutletsListCell.h"
#import "SLMyCollectedMerchantCell.h"

#import "SLVipProductViewController.h"
#import "SLFinanceProductController.h"
#import "SLOutletDetialController.h"
#import "SLMerchantDetailController.h"

#import "SLCollectecMaterialTool.h"
#import "SLCollectedMerchantTool.h"
#import "SLPlateInfoTool.h"
#import "SLCollectMaterialTool.h"

#import "UIBarButtonItem+SL.h"

#import "MBProgressHUD+MJ.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "UIViewController+REXSideMenu.h"

#define ButtonW 80

@interface SLMyCollectionController ()<UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate, MJRefreshBaseViewDelegate>

@property (nonatomic, strong) NSMutableArray *myCollectedItems;

@property (nonatomic, strong) NSMutableArray *myCollectionButtons;

@property (nonatomic, strong) NSMutableArray *myCollectionTableViews;

@property (nonatomic, strong) NSMutableArray *myCollectedVipArray;
@property (nonatomic, strong) NSMutableArray *myCollectedFinanceProductArray;
@property (nonatomic, strong) NSMutableArray *myCollectedOutletsArray;
@property (nonatomic, strong) NSMutableArray *myCollectedMerchantArray;

@property (nonatomic, weak) UIView *listView;

@property (nonatomic, weak) UIView *colorView;

@property (nonatomic, weak) UIScrollView *scrollView;

@property (nonatomic, assign) BOOL flag;

@property (nonatomic, strong) NSMutableArray *headerArray;
@property (nonatomic, strong) NSMutableArray *footerArray;

@property (nonatomic, strong) NSMutableArray *currentPageArray;
@property (nonatomic, strong) NSMutableArray *paremetersArray;

@end

@implementation SLMyCollectionController

- (NSMutableArray *)myCollectedMerchantArray
{
    if (_myCollectedMerchantArray == nil) {
        _myCollectedMerchantArray = [NSMutableArray array];
    }
    return _myCollectedMerchantArray;
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

- (NSMutableArray *)paremetersArray
{
    if (_paremetersArray == nil) {
        _paremetersArray = [NSMutableArray array];
    }
    return _paremetersArray;
}

- (NSMutableArray *)currentPageArray
{
    if (_currentPageArray == nil) {
        _currentPageArray = [NSMutableArray array];
    }
    return _currentPageArray;
}

- (NSMutableArray *)headerArray
{
    if (_headerArray == nil) {
        _headerArray = [NSMutableArray array];
    }
    return _headerArray;
}

- (NSMutableArray *)footerArray
{
    if (_footerArray == nil) {
        _footerArray = [NSMutableArray array];
    }
    return _footerArray;
}

- (NSMutableArray *)myCollectedItems
{
    if (_myCollectedItems == nil) {
        _myCollectedItems = [NSMutableArray array];
    }
    return _myCollectedItems;
}

- (NSMutableArray *)myCollectionTableViews
{
    if (_myCollectionTableViews == nil) {
        _myCollectionTableViews = [NSMutableArray array];
    }
    return _myCollectionTableViews;
}

- (NSMutableArray *)myCollectionButtons
{
    if (_myCollectionButtons == nil) {
        _myCollectionButtons = [NSMutableArray array];
    }
    return _myCollectionButtons;
}

#pragma mark ----- viewWillAppear
- (void)viewWillAppear:(BOOL)animated
{
    if (self.flag == NO) {
        [MBProgressHUD showMessage:@"收藏列表加载中..."];
        self.flag = YES;
    }
    
    [self setNavBar];
    
    for (int i = 1; i < 6; i++) {
        if (i < 5) {
            SLCollectedMaterialParameter *parameter = [SLCollectedMaterialParameter parameters];
            parameter.curPage = @1;
            parameter.pageSize = [NSNumber numberWithInt:-99];
            parameter.plateId = [NSNumber numberWithInt:i];
            
            [SLCollectecMaterialTool CollcetedMerchantWithParameters:parameter success:^(NSArray *collectedMaterialArray) {
                
                if (i == 1) {
                    NSArray *myCollectedVipArray = [SLVipStatusFirstMaterialInfo objectArrayWithKeyValuesArray:collectedMaterialArray];
                    [self.myCollectedVipArray removeAllObjects];
                    [self.myCollectedVipArray addObjectsFromArray:myCollectedVipArray];
                    UITableView *tableView = self.myCollectionTableViews[i - 1];
                    [tableView reloadData];
                } else if (i == 2) {
                    NSArray *myCollectedFinanceProductArray = [SLFinanceProduct objectArrayWithKeyValuesArray:collectedMaterialArray];
                    [self.myCollectedFinanceProductArray removeAllObjects];
                    [self.myCollectedFinanceProductArray addObjectsFromArray:myCollectedFinanceProductArray];
                    UITableView *tableView = self.myCollectionTableViews[i - 1];
                    [tableView reloadData];
                } else if (i == 3) {
                    NSArray *myCollectedOutletsArray = [SLOutletsInfo objectArrayWithKeyValuesArray:collectedMaterialArray];
                    [self.myCollectedOutletsArray removeAllObjects];
                    [self.myCollectedOutletsArray addObjectsFromArray:myCollectedOutletsArray];
                    UITableView *tableView = self.myCollectionTableViews[i - 1];
                    [tableView reloadData];
                }
                
                [MBProgressHUD hideHUD];
                
                
            } failure:^(NSError *error) {
                
            }];
        } else {
            SLCollectedMerchantParameters *parameter = [SLCollectedMerchantParameters parameters];
            parameter.curPage = @1;
            parameter.pageSize = [NSNumber numberWithInt:-99];
            
            [SLCollectedMerchantTool CollcetedMerchantWithParameters:parameter success:^(NSArray *collectedMerchantArray) {
                
                NSArray *myCollectedMerchantArray = [SLMerchantStatus objectArrayWithKeyValuesArray:collectedMerchantArray];
                
                [self.myCollectedMerchantArray removeAllObjects];
                [self.myCollectedMerchantArray addObjectsFromArray:myCollectedMerchantArray];
                
                UITableView *tableView = self.myCollectionTableViews[i - 2];
                [tableView reloadData];
                
            } failure:^(NSError *error) {
                
            }];
        }
    }
}

#pragma mark ----- setNavBar设置导航栏
- (void)setNavBar
{
    // 设置左上角的barButton
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"iconMorePress" highlightImage:@"iconMore" target:self action:@selector(presentLeftMenuViewController:)];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

#pragma mark ----- viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setItems];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupTableHeadView];
    
    [self setListView];
}

#pragma mark ----- setItems设置所有按钮
- (void)setItems
{
    [self.myCollectedItems removeAllObjects];
    [self.paremetersArray removeAllObjects];
    
    NSArray *plateInfoArray = [SLPlateInfoTool getPlateInfoList];
    
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
            } else {
                myCollectedItem.urlstr = @"/material/listCollectMaterial";
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
            myCollectedItem.imageURLStr = [SLPicHttpUrl stringByAppendingString:@"/plate/shangQuan@2x.png"];
            myCollectedItem.urlstr = @"/merchant/listCollectMerchantInfo";
        }
        switch (i) {
            case 0:
                myCollectedItem.title = @"VIP特权";
                myCollectedItem.imageName = @"vip";
                myCollectedItem.urlstr = @"/material/listCollectMaterial";
                myCollectedItem.plateId = @1;
                break;
            case 1:
                myCollectedItem.title = @"尊享理财";
                myCollectedItem.imageName = @"zunXiangLiCai";
                myCollectedItem.urlstr = @"/material/listCollectMaterial";
                myCollectedItem.plateId = @2;
                break;
            case 2:
                myCollectedItem.title = @"网点信息";
                myCollectedItem.imageName = @"wangDian";
                myCollectedItem.urlstr = @"/material/listCollectMaterial";
                myCollectedItem.plateId = @3;
                break;
            case 3:
                myCollectedItem.title = @"商户信息";
                myCollectedItem.imageName = @"shangQuan";
                myCollectedItem.urlstr = @"/merchant/listCollectMerchantInfo";
                myCollectedItem.plateId = @4;
                break;
                
            default:
                break;
        }
        [self.myCollectedItems addObject:myCollectedItem];
    }
    
}

#pragma mark ----- setupTableHeadView设置tableHeadView
- (void)setupTableHeadView
{
    UIView *tableHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, screenW, 86)];
    
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
        headButton.tag = [myCollectedItem.plateType integerValue];
        [headButton addTarget:self action:@selector(headButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.myCollectionButtons addObject:headButton];
        [tableHeadView addSubview:headButton];
    }
    
    [self.view addSubview:tableHeadView];
}

#pragma mark ----- headButton的点击事件
- (void)headButtonClicked:(SLMyCollectionHeadButton *)headButton
{
    CGFloat offsetX = headButton.tag * screenW;
    CGPoint offset = CGPointMake(offsetX, 0);
    [self.scrollView setContentOffset:offset animated:YES];
}

#pragma mark ----- setListView设置展示的view
- (void)setListView
{
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
    CGFloat colorViewX = largeMargin;
    CGFloat colorViewY = 0;
    CGFloat colorViewW = 40;
    CGFloat colorViewH = 5;
    CGRect colorViewF = CGRectMake(colorViewX, colorViewY, colorViewW, colorViewH);
    colorView.frame = colorViewF;
    self.colorView = colorView;
    [listView addSubview:colorView];
    colorView.backgroundColor = [UIColor orangeColor];
    
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
    
    CGFloat tableViewW = listView.frame.size.width;
    CGFloat tableViewH = listView.frame.size.height;
    // 给scrollView添加tableView
    for (int i = 0; i < self.myCollectedItems.count; i++) {
        UITableView *tableView = [[UITableView alloc] init];
        tableView.tag = i;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.backgroundColor = [UIColor whiteColor];
        
        // 设置tableView的frame
        CGFloat tableViewX = i * tableViewW;
        tableView.frame = CGRectMake(tableViewX, 0, tableViewW, tableViewH);
        tableView.contentInset = UIEdgeInsetsMake(0, 0, 54, 0);
        
        [self.myCollectionTableViews addObject:tableView];
        UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenW, 0.5)];
        footView.backgroundColor = SLLightGray;
        tableView.tableFooterView = footView;
        
        [self.currentPageArray addObject:@1];
        
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
        
        // 将imageView添加到scrollView里面
        [scrollView addSubview:tableView];
    }
    
    scrollView.contentSize = CGSizeMake(tableViewW * self.myCollectedItems.count, 0);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
}

#pragma mark ----- 代理方法,mj刷新包的代理方法
#pragma mark ----- 刷新控件进入开始刷新状态的时候调用
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if ([refreshView isKindOfClass:[MJRefreshFooterView class]]) { // 上拉刷新
        [self loadMoreData];
    } else { // 下拉刷新
        [self loadNewData];
    }
}

/**
 *  发送请求加载更多的数据
 */
- (void)loadMoreData
{
    for (int i = 0; i < self.myCollectedItems.count; i++) {
        MJRefreshFooterView *footer = self.footerArray[i];
        SLMyCollectedItem *collectItem = self.myCollectedItems[i];
        if (i == 0) {
            
            SLCollectedMaterialParameter *parameters = self.paremetersArray[i];
            NSNumber *currentPageNumber = parameters.curPage;
            int currentPage = [currentPageNumber intValue] + 1;
            parameters.curPage = [NSNumber numberWithInt:currentPage];
            
            self.paremetersArray[i] = parameters;
            
            [SLCollectMaterialTool collcetedMaterialWithParameters:parameters urlStr:collectItem.urlstr success:^(SLResult *result) {
                
                if (result.info.count > 0) {
                    if ([collectItem.plateType isEqualToString:@"2"]) {
                        NSArray *dictArray = [result.info lastObject];
                        if (dictArray.count > 0) {
                            NSArray *myCollectedVipArray = [SLVipStatusFirstMaterialInfo objectArrayWithKeyValuesArray:dictArray];
                            [self.myCollectedVipArray addObjectsFromArray:myCollectedVipArray];
                            UITableView *tableView = self.myCollectionTableViews[[collectItem.plateType integerValue]];
                            [tableView reloadData];
                        }
                    } else if ([collectItem.plateType isEqualToString:@"3"]) {
                        NSArray *dictArray = [result.info lastObject];
                        if (dictArray.count > 0) {
                            NSArray *myCollectedFinanceProductArray = [SLFinanceProduct objectArrayWithKeyValuesArray:dictArray];
                            [self.myCollectedFinanceProductArray addObjectsFromArray:myCollectedFinanceProductArray];
                            UITableView *tableView = self.myCollectionTableViews[[collectItem.plateType integerValue]];
                            [tableView reloadData];
                        }
                    } else if ([collectItem.plateType isEqualToString:@"4"]) {
                        NSArray *dictArray = [result.info lastObject];
                        if (dictArray.count > 0) {
                            NSArray *myCollectedOutletsArray = [SLOutletsInfo objectArrayWithKeyValuesArray:dictArray];
                            [self.myCollectedOutletsArray addObjectsFromArray:myCollectedOutletsArray];
                            UITableView *tableView = self.myCollectionTableViews[[collectItem.plateType integerValue]];
                            [tableView reloadData];
                        }
                    } else if ([collectItem.plateType isEqualToString:@"4"]) {
                        NSArray *dictArray = [result.info lastObject];
                        if (dictArray.count > 0) {
                            NSArray *myCollectedOutletsArray = [SLOutletsInfo objectArrayWithKeyValuesArray:dictArray];
                            [self.myCollectedOutletsArray addObjectsFromArray:myCollectedOutletsArray];
                            UITableView *tableView = self.myCollectionTableViews[[collectItem.plateType integerValue]];
                            [tableView reloadData];
                        }
                    } else {
                        NSArray *dictArray = [result.info lastObject];
                        if (dictArray.count > 0) {
                            NSArray *myCollectedMerchantArray = [SLMerchantStatus objectArrayWithKeyValuesArray:dictArray];
                            [self.myCollectedMerchantArray addObjectsFromArray:myCollectedMerchantArray];
                            UITableView *tableView = [self.myCollectionTableViews lastObject];
                            [tableView reloadData];
                        }
                    }
                }
                // 让刷新控件停止显示刷新状态
                [footer endRefreshing];
                
            } failure:^(NSError *error) {
                
                // 让刷新控件停止显示刷新状态
                [footer endRefreshing];
                
            }];
        }
    }
}
/**
 *  // 刷新数据(向服务器获取更新的数据)
 */
- (void)loadNewData
{
//    self.currentPage = 1;
//    
//    self.parameters.curPage = [NSNumber numberWithLong:self.currentPage];
//    
//    [SLSubscribeTool subscribeListWithParameters:self.parameters success:^(SLResult *result) {
//        
//        if ([result.code isEqualToString:@"0000"]) {
//            if (result.info.count > 0) {
//                NSArray *dictArray = [result.info lastObject];
//                NSArray *subscribeStatusList = [SLSubscribeList objectArrayWithKeyValuesArray:dictArray];
//                [self.subscribeStatusList removeAllObjects];
//                
//                if (subscribeStatusList.count > 0) {
//                    [self.subscribeStatusList addObjectsFromArray:subscribeStatusList];
//                } else {
//                    [MBProgressHUD showError:@"没有相关数据"];
//                }
//                [self.tableView reloadData];
//            }
//        }
//        
//        // 让刷新控件停止显示刷新状态
//        [self.header endRefreshing];
//        
//    } failure:^(NSError *error) {
//        [self.header endRefreshing];
//    }];
}

#pragma mark ----- scrollView的代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.tag == 10) {
        // 取出当前offset的x值
        CGFloat offsetX = scrollView.contentOffset.x;
        
        CGRect colorViewF = CGRectMake(largeMargin, 0, 40, 5);
        colorViewF.origin.x += (offsetX / screenW) * 80;
        
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
    switch (tableView.tag) {
        case 0:
            return self.myCollectedVipArray.count;
            break;
        case 1:
            return self.myCollectedFinanceProductArray.count;
            break;
        case 2:
            return self.myCollectedOutletsArray.count;
            break;
        case 3:
            return self.myCollectedMerchantArray.count;
            break;
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 0) {
        SLVipStatusFirstMaterialInfo *firstMaterialInfo = self.myCollectedVipArray[indexPath.row];
        SLVipStatus *vipStatus = [[SLVipStatus alloc] init];
        vipStatus.firstMaterialInfo = firstMaterialInfo;
        SLVipStatusFrame *vipStatusFrame = [[SLVipStatusFrame alloc] init];
        vipStatusFrame.vipStatus = vipStatus;
        
        // 创建cell
        SLVipStatusCell *cell = [SLVipStatusCell cellWithTableView:tableView];
        
        // 给cell传递数据
        cell.vipStatusFrame = vipStatusFrame;
        
        return cell;
    } else if (tableView.tag == 1) {
        
        SLFinanceProduct *financeProduct = self.myCollectedFinanceProductArray[indexPath.row];
        SLFinancialStatusFrame *financialStatusFrame = [[SLFinancialStatusFrame alloc] init];
        financialStatusFrame.financeProduct = financeProduct;
        
        // 1.创建cell
        SLFinancialProductListCell *cell = [SLFinancialProductListCell cellWithTableView:tableView];
        
        // 2.给cell传递模型数据
        cell.financialStatusFrame = financialStatusFrame;
        
        return cell;
    } else if (tableView.tag == 2) {
        
        SLOutletsInfo *outlets = self.myCollectedOutletsArray[indexPath.row];
        SLOutletsListFrame *frame = [[SLOutletsListFrame alloc] init];
        frame.outletsInfo = outlets;
        
        SLOutletsListCell *cell = [SLOutletsListCell cellWithTableView:tableView];
        
        cell.outletsListFrame = frame;
        
        return cell;
        
    } else{
        
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
    switch (tableView.tag) {
        case 0:
            return 70;
            break;
        case 1:
            return 75;
            break;
        case 2:
            return 44;
            break;
        case 3:
            return 70;
            break;
        default:
            break;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 0) {
        
        SLVipStatusFirstMaterialInfo *firstMaterialInfo = self.myCollectedVipArray[indexPath.row];
        SLVipProductViewController *vpvc = [[SLVipProductViewController alloc] init];
        vpvc.materialId = firstMaterialInfo.materialId;
        vpvc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vpvc animated:YES];
        
    } else if (tableView.tag == 1) {
        
        SLFinanceProduct *financeProduct = self.myCollectedFinanceProductArray[indexPath.row];
        SLFinanceProductController *fpvc = [[SLFinanceProductController alloc] init];
        fpvc.materialId = financeProduct.financialProductsDetail.materialId;
        fpvc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:fpvc animated:YES];
        
    } else if (tableView.tag == 2) {
        
        SLOutletsInfo *outlets = self.myCollectedOutletsArray[indexPath.row];
        SLOutletDetialController *odvc = [[SLOutletDetialController alloc] init];
        odvc.materialId = outlets.materialId;
        odvc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:odvc animated:YES];
        
    } else{
        
        SLMerchantStatus *merchantDetail = self.myCollectedMerchantArray[indexPath.row];
        SLMerchantDetailController *mdvc = [[SLMerchantDetailController alloc] init];
        mdvc.merchantId = merchantDetail.merchantId;
        mdvc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:mdvc animated:YES];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
