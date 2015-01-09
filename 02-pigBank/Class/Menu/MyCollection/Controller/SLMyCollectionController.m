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
#import "SLVipStatus.h"
#import "SLFinanceProductFrame.h"
#import "SLOutletsInfo.h"

#import "SLMyCollectionHeadButton.h"
#import "SLVipStatusCell.h"
#import "SLFinancialProductListCell.h"
#import "SLOutletsListCell.h"
#import "SLMyCollectedMerchantCell.h"

#import "SLCollectecMaterialTool.h"
#import "SLCollectedMerchantTool.h"

#import "MJExtension.h"

#define ButtonW 80

@interface SLMyCollectionController ()<UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *myCollectedItems;

@property (nonatomic, strong) NSMutableArray *myCollectionButtons;

@property (nonatomic, strong) NSMutableArray *myCollectionTableViews;

@property (nonatomic, strong) NSArray *myCollectedVipArray;

@property (nonatomic, strong) NSArray *myCollectedFinanceProductArray;

@property (nonatomic, strong) NSArray *myCollectedOutletsArray;

@property (nonatomic, strong) NSArray *myCollectedMerchantArray;

@property (nonatomic, weak) UIView *listView;

@property (nonatomic, weak) UIView *colorView;

@property (nonatomic, weak) UIScrollView *scrollView;

@end

@implementation SLMyCollectionController

//- (NSMutableArray *)myCollectedMerchantArray
//{
//    if (_myCollectedMerchantArray == nil) {
//        _myCollectedMerchantArray = [NSMutableArray array];
//    }
//    return _myCollectedMerchantArray;
//}
//
//- (NSMutableArray *)myCollectedOutletsArray
//{
//    if (_myCollectedOutletsArray == nil) {
//        _myCollectedOutletsArray = [NSMutableArray array];
//    }
//    return _myCollectedOutletsArray;
//}
//
//- (NSMutableArray *)myCollectedFinanceProductArray
//{
//    if (_myCollectedFinanceProductArray == nil) {
//        _myCollectedFinanceProductArray = [NSMutableArray array];
//    }
//    return _myCollectedFinanceProductArray;
//}
//
//- (NSMutableArray *)myCollectedVipArray
//{
//    if (_myCollectedVipArray == nil) {
//        _myCollectedVipArray = [NSMutableArray array];
//    }
//    return _myCollectedVipArray;
//}

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
    for (int i = 1; i < 5; i++) {
        if (i < 4) {
            SLCollectedMaterialParameter *parameter = [SLCollectedMaterialParameter parameters];
            parameter.curPage = @1;
            parameter.pageSize = [NSNumber numberWithInt:-99];
            parameter.plateId = [NSNumber numberWithInt:i];
            
            [SLCollectecMaterialTool CollcetedMerchantWithParameters:parameter success:^(NSArray *collectedMaterialArray) {
                
                if (i == 1) {
                    NSArray *myCollectedVipArray = [SLVipStatusFirstMaterialInfo objectArrayWithKeyValuesArray:collectedMaterialArray];
                    self.myCollectedVipArray = nil;
                    self.myCollectedVipArray = myCollectedVipArray;
                    UITableView *tableView = self.myCollectionTableViews[i - 1];
                    [tableView reloadData];
                } else if (i == 2) {
                    NSArray *myCollectedFinanceProductArray = [SLFinanceProduct objectArrayWithKeyValuesArray:collectedMaterialArray];
                    self.myCollectedFinanceProductArray = nil;
                    self.myCollectedFinanceProductArray = myCollectedFinanceProductArray;
                    UITableView *tableView = self.myCollectionTableViews[i - 1];
                    [tableView reloadData];
                } else if (i == 3) {
                    NSArray *myCollectedOutletsArray = [SLOutletsInfo objectArrayWithKeyValuesArray:collectedMaterialArray];
                    self.myCollectedOutletsArray = nil;
                    self.myCollectedOutletsArray = myCollectedOutletsArray;
                    UITableView *tableView = self.myCollectionTableViews[i - 1];
                    [tableView reloadData];
                }
                
                
            } failure:^(NSError *error) {
                
            }];
        } else {
            SLCollectedMerchantParameters *parameter = [SLCollectedMerchantParameters parameters];
            parameter.curPage = @1;
            parameter.pageSize = [NSNumber numberWithInt:-99];
            
            [SLCollectedMerchantTool CollcetedMerchantWithParameters:parameter success:^(NSArray *collectedMerchantArray) {
                
                NSArray *myCollectedMerchantArray = [SLMerchantStatus objectArrayWithKeyValuesArray:collectedMerchantArray];
                
                self.myCollectedMerchantArray = nil;
                self.myCollectedMerchantArray = myCollectedMerchantArray;
                
                UITableView *tableView = self.myCollectionTableViews[i - 1];
                [tableView reloadData];
                
            } failure:^(NSError *error) {
                
            }];
        }
    }
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
    
    for (int i = 0; i < 4; i ++) {
        SLMyCollectedItem *myCollectedItem = [[SLMyCollectedItem alloc] init];
        myCollectedItem.tag = i;
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
    
    for (int i = 0; i < self.myCollectedItems.count; i++) {
        SLMyCollectedItem *myCollectedItem = self.myCollectedItems[i];
        
        CGFloat headButtonX = i * ButtonW;
        CGFloat headButtonY = 0;
        CGFloat headButtonW = ButtonW;
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
}

#pragma mark ----- headButton的点击事件
- (void)headButtonClicked:(SLMyCollectionHeadButton *)headButton
{
    CGFloat offsetX = headButton.tag * screenW;
    CGPoint offset = CGPointMake(offsetX, 0);
    [self.scrollView setContentOffset:offset animated:YES];
//    if (headButton.tag < 3) {
//        SLCollectedMaterialParameter *parameter = [SLCollectedMaterialParameter parameters];
//        parameter.curPage = @1;
//        parameter.pageSize = [NSNumber numberWithInt:-99];
//        parameter.plateId = headButton.myCollectedItem.plateId;
//        
//        [SLCollectecMaterialTool CollcetedMerchantWithParameters:parameter success:^(NSArray *collectedMaterialArray) {
//
//        } failure:^(NSError *error) {
//            
//        }];
//    } else {
//        SLCollectedMerchantParameters *parameter = [SLCollectedMerchantParameters parameters];
//        parameter.curPage = @1;
//        parameter.pageSize = [NSNumber numberWithInt:-99];
//        
//        [SLCollectedMerchantTool CollcetedMerchantWithParameters:parameter success:^(NSArray *collectedMerchantArray) {
//            
//        } failure:^(NSError *error) {
//            
//        }];
//    }
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
        
        [self.myCollectionTableViews addObject:tableView];
        UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 0.5)];
        tableView.tableFooterView = footView;
        
        // 将imageView添加到scrollView里面
        [scrollView addSubview:tableView];
    }
    
    scrollView.contentSize = CGSizeMake(tableViewW * self.myCollectedItems.count, 0);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
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

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
