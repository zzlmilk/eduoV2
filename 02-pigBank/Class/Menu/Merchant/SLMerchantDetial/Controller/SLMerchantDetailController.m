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

#import "SLMapViewController.h"
#import "SLVipProductViewController.h"

#import "SLMerchantDetailTool.h"

@interface SLMerchantDetailController () <CLLocationManagerDelegate, UIWebViewDelegate, SLPostCommentViewDelegate>

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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 开始定位
    [self.locMgr startUpdatingLocation];
    
    self.tableView.sectionFooterHeight = 0;
    self.tableView.sectionHeaderHeight = 20;
    
    // 发表评论的按钮
    CGFloat commentViewX = 0;
    CGFloat commentViewW = screenW;
    CGFloat commentViewH = 44;
    CGFloat commentViewY = screenH - commentViewH - 44 - 20;
    SLPostCommentView *postCommentView = [[SLPostCommentView alloc] initWithFrame:CGRectMake(commentViewX, commentViewY, commentViewW, commentViewH)];
    self.postCommentView = postCommentView;
    postCommentView.delegate = self;
#warning ----- 工具条还没有设置好
//    [[self.tableView superview] addSubview:postCommentView];
//    [[self.tableView superview] bringSubviewToFront:postCommentView];
}

#pragma mark ----- postView的代理方法
- (void)postCommentView:(SLPostCommentView *)postCommentView didClickPostCommentButton:(UIButton *)button
{
    SLLog(@"--------buttonClick---------");
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
    
    SLMapViewController *mvc = [[SLMapViewController alloc] init];
    mvc.merchantDetail = self.vipMerchantDetail;
    
    SLMerchantDetailGroup *group = self.sectionArray[indexPath.section];
    SLMerchantDetailItem *item = group.merchantDetailItems[indexPath.row];
    SLMerchantDetail *merchantDetail = item.merchantDetailFrame.merchantDetail;
    
    if (indexPath.section == 0) {
        if (indexPath.row == 1) {
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
                    SLVipStatus *vipStatus = self.vipStatusArray[i];
                    SLVipProductViewController *vpvc = [[SLVipProductViewController alloc] init];
                    vpvc.vipStatus = vipStatus;
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
    
    // 加载网络数据
    [self loadInternetData];
    
    [self.locMgr stopUpdatingLocation];
}

- (void)loadInternetData
{
    self.parameters.latitude = [NSNumber numberWithDouble:self.location.coordinate.latitude];
    self.parameters.longitude = [NSNumber numberWithDouble:self.location.coordinate.longitude];
    self.parameters.merchantId = [NSNumber numberWithLong:self.vipMerchantDetail.merchantId];
    
    [SLMerchantDetailTool merchantDetailWithParameters:self.parameters success:^(NSArray *merchantDetailAndVipStatuses) {
        
        self.merchantDetail = merchantDetailAndVipStatuses[0];
        self.vipStatusArray = merchantDetailAndVipStatuses[1];
        
        UIWebView *webview = [[UIWebView alloc]initWithFrame:CGRectMake(-320, 0, 320, 300)];
        webview.delegate = self;
        webview.tag = 1;
        [webview loadHTMLString:self.merchantDetail.Description baseURL:nil];
        [self.view addSubview:webview];
        
    } failure:^(NSError *error) {
        
    }];
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
