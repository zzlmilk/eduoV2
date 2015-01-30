//
//  SLMerchantDetailController.m
//  02-pigBank
//
//  Created by 陆承东 on 14/10/22.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

#import "SLMerchantDetailController.h"

#import "SLMerchantDetailPatameters.h"
#import "SLMerchantDetail.h"
#import "SLMerchantDetailGroup.h"
#import "SLMerchantDetailItem.h"
#import "SLMaterialInfo.h"
#import "SLMerchantCommentFrame.h"
#import "SLVipStatus.h"

#import "SLMerchantHeadCell.h"
#import "SLBaseArrowCell.h"
#import "SLMerchantPhotosCell.h"
#import "SLWebViewCell.h"
#import "SLCommentCell.h"
#import "SLPostCommentView.h"
#import "SLPraiseButton.h"
#import "SLCollectButton.h"
#import "SLBackButton.h"

#import "SLMapViewController.h"
#import "SLVipProductViewController.h"
#import "SLCommentViewController.h"

#import "SLMerchantDetailTool.h"

#import "MBProgressHUD+MJ.h"

@interface SLMerchantDetailController () <UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate, UIWebViewDelegate, SLPostCommentViewDelegate>

/** 位置管理者 */
@property (nonatomic, strong) CLLocationManager *locMgr;

@property (nonatomic, strong) CLLocation *location;

@property (nonatomic, strong) SLMerchantDetailPatameters *parameters;

@property (nonatomic, strong) SLMerchantDetail *merchantDetail;

@property (nonatomic, strong) NSMutableArray *sectionArray;

@property (nonatomic, weak) UIWebView *detailInfoWebView;

@property (nonatomic, weak) UIWebView *telWebView;

@property (nonatomic, strong) NSArray *vipStatusArray;

@property (nonatomic, assign) CGFloat webViewCellHeight;

@property (nonatomic, weak) SLPostCommentView *postCommentView;

@property (nonatomic, weak) UITableView *tableView;

@end

@implementation SLMerchantDetailController

- (SLMerchantDetailPatameters *)parameters
{
    if (_parameters == nil) {
        _parameters = [SLMerchantDetailPatameters parameters];
    }
    return _parameters;
}
- (CLLocationManager *)locMgr
{
    if (![CLLocationManager locationServicesEnabled]) return nil;
    
    if (_locMgr == nil) {
        _locMgr = [[CLLocationManager alloc] init];
        _locMgr.delegate = self;
    }
    return _locMgr;
}
- (NSMutableArray *)sectionArray
{
    if (_sectionArray == nil) {
        _sectionArray = [NSMutableArray array];
    }
    return _sectionArray;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    [self.locMgr startUpdatingLocation];

    
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
    
    [MBProgressHUD showMessage:@"数据加载中"];
    
    // 开始定位
    [self.locMgr startUpdatingLocation];
    
    [self addSubviews];
}

#pragma mark ----- addSubviews添加子控件
- (void)addSubviews
{
    CGRect newFrame = CGRectMake(0, 0, screenW, screenH - 44);
    UITableView *tableView = [[UITableView alloc] initWithFrame:newFrame style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    self.tableView.sectionFooterHeight = 0;
    self.tableView.sectionHeaderHeight = 20;
    
    // 发表评论的按钮
    CGFloat commentViewX = 0;
    CGFloat commentViewW = screenW;
    CGFloat commentViewH = 44;
    CGFloat commentViewY = screenH - 44;
    SLPostCommentView *postCommentView = [[SLPostCommentView alloc] initWithFrame:CGRectMake(commentViewX, commentViewY, commentViewW, commentViewH)];
    self.postCommentView = postCommentView;
    postCommentView.delegate = self;
    [self.view addSubview:postCommentView];
}

#pragma mark ----- postView的代理方法
- (void)postCommentView:(SLPostCommentView *)postCommentView didClickPostCommentButton:(UIButton *)button
{
    SLCommentViewController *vc = [[SLCommentViewController alloc] init];
    vc.merchantId = self.merchantDetail.merchantId;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    SLMerchantDetailGroup *group = self.sectionArray[section];
    return group.merchantDetailItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SLMerchantDetailGroup *group = self.sectionArray[indexPath.section];
    SLMerchantDetailItem *item = group.merchantDetailItems[indexPath.row];
    
    SLMerchantDetail *merchantDetail = item.merchantDetailFrame.merchantDetail;
    
    if ([[[item.cellClass alloc] init] isKindOfClass:[SLMerchantHeadCell class]]) {
        SLMerchantHeadCell *cell = [SLMerchantHeadCell cellWithTableView:tableView];
        cell.item = item;
        return cell;
    } else if ([[[item.cellClass alloc] init] isKindOfClass:[SLBaseArrowCell class]]) {
        SLBaseArrowCell *cell = [SLBaseArrowCell cellWithTableView:tableView];
        if (indexPath.section == 0) {
            if (indexPath.row == 1) {
                cell.textLabel.text = merchantDetail.address;
                cell.imageView.image = [UIImage imageNamed:@"diZhi"];
                return cell;
            } else if (indexPath.row == 2) {
                cell.textLabel.text = [NSString stringWithFormat:@"%@", merchantDetail.merchantUserInfo.telephone];
                cell.imageView.image = [UIImage imageNamed:@"dianHua"];
                return cell;
            }
        } else if (merchantDetail.materialInfoList.count) {
            if (indexPath.section == 2) {
                for (int i = 0; i < merchantDetail.materialInfoList.count; i++) {
                    if (indexPath.row == i) {
                        SLMaterialInfo *materialInfo = merchantDetail.materialInfoList[i];
                        cell.textLabel.text = materialInfo.title;
                        return cell;
                    }
                }
            }
        }
    } else if ([[[item.cellClass alloc] init] isKindOfClass:[SLMerchantPhotosCell class]]) {
        SLMerchantPhotosCell *cell = [SLMerchantPhotosCell cellWithTableView:tableView];
        cell.item = item;
        return cell;
    } else if ([[[item.cellClass alloc] init] isKindOfClass:[SLWebViewCell class]]) {
        SLWebViewCell *cell = [SLWebViewCell cellWithTableView:tableView];
        UIWebView *webview = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 320, self.webViewCellHeight)];
        webview.delegate = self;
        webview.backgroundColor = [UIColor clearColor];
        webview.scrollView.bounces = NO;//禁止滑动
        self.detailInfoWebView = webview;
        [webview loadHTMLString:merchantDetail.Description baseURL:nil];
        [cell.contentView addSubview:webview];
        return cell;
    } else if ([[[item.cellClass alloc] init] isKindOfClass:[SLCommentCell class]]) {
        SLCommentCell *cell = [SLCommentCell cellWithTableView:tableView];
        if (indexPath.section == 4) {
//            for (int i = 0; i < merchantDetail.myCommentList.count; i++) {
//                SLMerchantCommentFrame *merchantCommentFrame = [[SLMerchantCommentFrame alloc] init];
//                merchantCommentFrame.myComment = merchantDetail.myCommentList[i];
//                cell.commentFrame = merchantCommentFrame;
//            }
            cell.item = item;
            return cell;
        } else if (indexPath.section == 5) {
            cell.item = item;
            return cell;
        }
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 拨打电话首先要创建一个uiwebview
    UIWebView *telWebView = [[UIWebView alloc] init];
    [self.view addSubview:telWebView];
    self.telWebView = telWebView;
    
    SLMerchantDetailGroup *group = self.sectionArray[indexPath.section];
    SLMerchantDetailItem *item = group.merchantDetailItems[indexPath.row];
    SLMerchantDetail *merchantDetail = item.merchantDetailFrame.merchantDetail;
    
    if (indexPath.section == 0) {
        if (indexPath.row == 1) {
            SLMapViewController *mvc = [[SLMapViewController alloc] init];
            mvc.merchantDetail = merchantDetail;
            [self.navigationController pushViewController:mvc animated:YES];
        }
        else if (indexPath.row == 2){
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", merchantDetail.merchantUserInfo.telephone]];
            [telWebView loadRequest:[NSURLRequest requestWithURL:url]];
        }
    } else if (indexPath.section == 2) {
        if (merchantDetail.materialInfoList.count) {
            for (int i = 0; i < merchantDetail.materialInfoList.count; i++) {
                if (indexPath.row == i) {
                    SLVipProductViewController *vpvc = [[SLVipProductViewController alloc] init];
                    SLMaterialInfo *materialInfo = self.merchantDetail.materialInfoList[i];
                    vpvc.materialId = materialInfo.materialId;
                    [self.navigationController pushViewController:vpvc animated:YES];
                }
            }
        }
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    SLMerchantDetailGroup *group = self.sectionArray[section];
    return group.title;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SLMerchantDetailGroup *group = self.sectionArray[indexPath.section];
    SLMerchantDetailItem *item = group.merchantDetailItems[indexPath.row];
    SLMerchantDetailFrame *merchantDetailFrame = item.merchantDetailFrame;
    if ([[[item.cellClass alloc] init] isKindOfClass:[SLMerchantHeadCell class]]) {
        return merchantDetailFrame.merchantHeadCellFrame.cellHeight;
    } else if ([[[item.cellClass alloc] init] isKindOfClass:[SLBaseArrowCell class]]) {
        return 44;
    } else if ([[[item.cellClass alloc] init] isKindOfClass:[SLMerchantPhotosCell class]]) {
        return merchantDetailFrame.merchantPhotoFrame.cellHeight;
    } else if ([[[item.cellClass alloc] init] isKindOfClass:[SLWebViewCell class]]) {
        return self.webViewCellHeight;//self.detailInfoWebView.frame.size.height;
    } else if ([[[item.cellClass alloc] init] isKindOfClass:[SLCommentCell class]]) {
        return merchantDetailFrame.merchantCommentFrame.cellHeight;
    }
    return 0;
}

#pragma mark ------ CLLocationManager的代理方法
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    self.location = [locations firstObject];
    
    [self loadInternetData];
    
    [self.locMgr stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    [self loadInternetData];
}

#pragma mark ----- loadInternetData加载网络数据
- (void)loadInternetData
{
    if (self.location) {
        self.parameters.latitude = [NSNumber numberWithDouble:self.location.coordinate.latitude];
        self.parameters.longitude = [NSNumber numberWithDouble:self.location.coordinate.longitude];
    }
    self.parameters.merchantId = self.merchantId;
    
    [SLMerchantDetailTool merchantDetailWithParameters:self.parameters success:^(NSArray *merchantDetailAndVipStatuses) {
        
        self.merchantDetail = merchantDetailAndVipStatuses[0];
        self.vipStatusArray = merchantDetailAndVipStatuses[1];
        
        UIWebView *webview = [[UIWebView alloc]initWithFrame:CGRectMake(-3200, 0, screenW, 300)];
        webview.delegate = self;
        webview.tag = 1;
        [webview loadHTMLString:self.merchantDetail.Description baseURL:nil];
        [self.view addSubview:webview];
        
        [MBProgressHUD hideHUD];
        
        [self setCollectAndPrise];
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark ----- setCollectAndPrise设置收藏和赞的按钮
- (void)setCollectAndPrise
{
    UINavigationBar *navBar = self.navigationController.navigationBar;
    // 设置背景
    [navBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    
    // 设置右上角的barButton
    SLPraiseButton *priseButton = [SLPraiseButton button];
    [priseButton setMerchantId:self.merchantDetail.merchantId praiseCounts:self.merchantDetail.praiseCounts praiseFlag:[NSString stringWithFormat:@"%@", self.merchantDetail.merchantUser.praiseFlag]];
    UIBarButtonItem *priseItem = [[UIBarButtonItem alloc] initWithCustomView:priseButton];
    
    SLCollectButton *collectButton = [SLCollectButton button];
    [collectButton setMerchantId:self.merchantDetail.merchantId collectFlag:[NSString stringWithFormat:@"%@", self.merchantDetail.merchantUser.collectFlag]];
    UIBarButtonItem *collectItem = [[UIBarButtonItem alloc] initWithCustomView:collectButton];
    
    NSArray *rightBarButtonItems = @[priseItem, collectItem];
    self.navigationItem.rightBarButtonItems = rightBarButtonItems;
}

- (void)setMerchantDetail:(SLMerchantDetail *)merchantDetail
{
    _merchantDetail = merchantDetail;
    SLMerchantDetailFrame *merchantDetailFrame = [[SLMerchantDetailFrame alloc] init];
    merchantDetailFrame.merchantDetail = merchantDetail;
    if (self.sectionArray) {
        self.sectionArray = nil;
    }
    // 第一组
    SLMerchantDetailGroup *group1 = [[SLMerchantDetailGroup alloc] init];
    SLMerchantDetailItem *headItem = [SLMerchantDetailItem itemWithMerchantDetail:merchantDetailFrame andCellClass:[SLMerchantHeadCell class]];
    [group1.merchantDetailItems addObject:headItem];
    
    SLMerchantDetailItem *adressItem = [SLMerchantDetailItem itemWithMerchantDetail:merchantDetailFrame andCellClass:[SLBaseArrowCell class]];
    [group1.merchantDetailItems addObject:adressItem];
    
    SLMerchantDetailItem *telItem = [SLMerchantDetailItem itemWithMerchantDetail:merchantDetailFrame andCellClass:[SLBaseArrowCell class]];
    [group1.merchantDetailItems addObject:telItem];
    
    [self.sectionArray addObject:group1];
    
    // 第二组
    SLMerchantDetailGroup *group2 = [[SLMerchantDetailGroup alloc] init];
    if (merchantDetail.merchantPhotoList.count) {
        SLMerchantDetailItem *photoItem = [SLMerchantDetailItem itemWithMerchantDetail:merchantDetailFrame andCellClass:[SLMerchantPhotosCell class]];
        group2.title = @"商家图片";
        [group2.merchantDetailItems addObject:photoItem];
    } else {
        group2.title = @"商家图片(无)";
    }
    [self.sectionArray addObject:group2];
    
    // 第三组
    SLMerchantDetailGroup *group3 = [[SLMerchantDetailGroup alloc] init];
    if (merchantDetail.materialInfoList.count) {
        group3.title = @"相关信息";
        for (int i = 0; i < merchantDetail.materialInfoList.count; i++) {
            SLMerchantDetailItem *saleItem = [SLMerchantDetailItem itemWithMerchantDetail:merchantDetailFrame andCellClass:[SLBaseArrowCell class]];
            [group3.merchantDetailItems addObject:saleItem];
        }
    } else {
        group3.title = @"相关信息(无)";
    }
    [self.sectionArray addObject:group3];
    
    // 第四组
    SLMerchantDetailGroup *group4 = [[SLMerchantDetailGroup alloc] init];
    if (merchantDetail.Description) {
        group4.title = @"信息详情";
        SLMerchantDetailItem *detailInfo = [SLMerchantDetailItem itemWithMerchantDetail:merchantDetailFrame andCellClass:[SLWebViewCell class]];
        [group4.merchantDetailItems addObject:detailInfo];
    } else {
        group4.title = @"信息详情(无)";
    }
    
    [self.sectionArray addObject:group4];
    
    // 第五组
    SLMerchantDetailGroup *group5 = [[SLMerchantDetailGroup alloc] init];
    if (merchantDetail.myCommentList.count) {
        group5.title = @"我的点评";
        for (int i = 0; i < merchantDetail.myCommentList.count; i++) {
            SLMerchantCommentFrame *merchantCommentFrame = [[SLMerchantCommentFrame alloc] init];
            merchantCommentFrame.otherComment = merchantDetail.myCommentList[i];
            merchantDetailFrame.merchantCommentFrame = merchantCommentFrame;
            SLMerchantDetailItem *myCommentItem = [SLMerchantDetailItem itemWithMerchantDetail:merchantDetailFrame andCellClass:[SLCommentCell class]];
            [group5.merchantDetailItems addObject:myCommentItem];
        }
    } else {
        group5.title = @"我的点评(无)";
    }
    [self.sectionArray addObject:group5];
    
    // 第六组
    SLMerchantDetailGroup *group6 = [[SLMerchantDetailGroup alloc] init];
    if (merchantDetail.othersCommentList.count) {
        group6.title = @"其他人的点评";
        for (int i = 0; i < merchantDetail.othersCommentList.count; i++) {
            SLMerchantCommentFrame *merchantCommentFrame = [[SLMerchantCommentFrame alloc] init];
            SLOthersComment *otherComment = merchantDetail.othersCommentList[i];
            merchantCommentFrame.otherComment = otherComment;
            SLMerchantDetailFrame *merchantDetailFrame1 = [[SLMerchantDetailFrame alloc] init];
            merchantDetailFrame1.merchantCommentFrame = merchantCommentFrame;
            SLMerchantDetailItem *otherCommentItem = [SLMerchantDetailItem itemWithMerchantDetail:merchantDetailFrame1 andCellClass:[SLCommentCell class]];
            [group6.merchantDetailItems addObject:otherCommentItem];
        }
    } else {
        group6.title = @"其他人的点评(无)";
    }
    [self.sectionArray addObject:group6];
    
    [self.tableView reloadData];
}

#pragma mark ----- uiwebView的代理方法
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    if (webView.tag == 1) {
        CGSize actualSize = [webView sizeThatFits:CGSizeZero];
        CGRect newFrame = webView.frame;
        newFrame.size.height = actualSize.height;
        self.webViewCellHeight = actualSize.height;
        [self.tableView reloadData];
    }
}

@end
