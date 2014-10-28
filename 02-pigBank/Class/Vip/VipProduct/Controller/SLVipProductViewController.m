//
//  SLVipProductViewController.m
//  02-pigBank
//
//  Created by 陆承东 on 14-9-24.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLVipProductViewController.h"

#import "SLVipStatus.h"

#import "SLVipProductHeadView.h"
#import "SLVipProductArrorCell.H"

#import "SLMapViewController.h"

@interface SLVipProductViewController () <UIWebViewDelegate>

@property (nonatomic, weak) UIWebView *telWebView;

@property (nonatomic, weak) UIWebView *footWebView;

@property (nonatomic, assign) CGFloat footHeight;

@end

@implementation SLVipProductViewController

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
    
    // 计算foot的高度
    [self calculateFootHeight];
    
    [self setupVipProductData];
}

- (void)setupVipProductData
{
}

- (void)calculateFootHeight
{
    UIWebView *webview = [[UIWebView alloc]initWithFrame:CGRectMake(-320, 0, 320, 300)];
    webview.delegate = self;
    webview.tag = 1;
    [webview loadHTMLString:self.vipStatus.firstMaterialInfo.content baseURL:nil];
    [self.view addSubview:webview];
}

- (void)setupTableHeadFootView
{
    // headView
    SLVipProductHeadView *headView = [[SLVipProductHeadView alloc] init];
    
    headView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200);
    
    SLVipStatus *vipStatus = self.vipStatus;
    
    headView.vipStatus = vipStatus;
    
    self.tableView.tableHeaderView = headView;
    
    // footView
    UITableViewHeaderFooterView *footView = [[UITableViewHeaderFooterView alloc] init];
    
    UIWebView *webView = [[UIWebView alloc] init];
    
    webView.frame = CGRectMake(0, 0, 320, self.footHeight);
    webView.delegate = self;
    webView.backgroundColor = [UIColor clearColor];
    webView.scrollView.bounces = NO;//禁止滑动
    self.footWebView = webView;
    [webView loadHTMLString:vipStatus.firstMaterialInfo.content baseURL:nil];
    
    footView.textLabel.font = SLVipStatusTitleFont;
    footView.textLabel.textColor = [UIColor blackColor];
    footView.textLabel.text = vipStatus.firstMaterialInfo.content;
    CGSize footViewS = [vipStatus.firstMaterialInfo.content sizeWithFont:SLVipStatusTitleFont constrainedToSize:CGSizeMake(300, MAXFLOAT)];
    footView.frame = (CGRect){{0, 0}, footViewS};
    
    self.tableView.tableFooterView = webView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.vipStatus.firstMaterialInfo.privilegeDetail.saleDescript isEqualToString:@""]) {
        return 3;
    } else {
        return 4;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"vipProductCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = self.vipStatus.firstMaterialInfo.privilegeDetail.merchantDetail.fullName;
            break;
        case 1:
            if ([self.vipStatus.firstMaterialInfo.privilegeDetail.saleDescript isEqualToString:@""]) {
                cell.imageView.image = [UIImage imageNamed:@"diZhi"];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.textLabel.text = self.vipStatus.firstMaterialInfo.privilegeDetail.merchantDetail.address;
                break;
            } else {
                cell.textLabel.text = @"sdafasdfasf";
                break;
            }
        case 2:
            if ([self.vipStatus.firstMaterialInfo.privilegeDetail.saleDescript isEqualToString:@""]) {
                cell.imageView.image = [UIImage imageNamed:@"dianHua"];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.textLabel.text = [NSString stringWithFormat:@"%@", self.vipStatus.firstMaterialInfo.privilegeDetail.merchantDetail.merchantUserInfo.telephone];
                break;
            } else {
                cell.imageView.image = [UIImage imageNamed:@"diZhi"];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.textLabel.text = self.vipStatus.firstMaterialInfo.privilegeDetail.merchantDetail.address;
                break;
            }
        case 3:
            if ([self.vipStatus.firstMaterialInfo.privilegeDetail.saleDescript isEqualToString:@""]) {
                break;
            } else {
                cell.imageView.image = [UIImage imageNamed:@"dianHua"];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.textLabel.text = [NSString stringWithFormat:@"%@", self.vipStatus.firstMaterialInfo.privilegeDetail.merchantDetail.merchantUserInfo.telephone];
                break;
            }
            
        default:
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // 拨打电话首先要创建一个uiwebview
    UIWebView *telWebView = [[UIWebView alloc] init];
    [self.view addSubview:telWebView];
    self.telWebView = telWebView;
    
    SLMapViewController *mvc = [[SLMapViewController alloc] init];
    mvc.merchantDetail = self.vipStatus.firstMaterialInfo.privilegeDetail.merchantDetail;
    
    if ([self.vipStatus.firstMaterialInfo.privilegeDetail.saleDescript isEqualToString:@""]) {
        if (indexPath.row == 1) {
            [self.navigationController pushViewController:mvc animated:YES];
        } else if (indexPath.row == 2) {// 利用创建好的uiwebview加载request
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", self.vipStatus.firstMaterialInfo.privilegeDetail.merchantDetail.merchantUserInfo.telephone]];
            [telWebView loadRequest:[NSURLRequest requestWithURL:url]];
        }
        
    } else {
        if (indexPath.row == 2) {
            [self.navigationController pushViewController:mvc animated:YES];
        } else if (indexPath.row == 3) {
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", self.vipStatus.firstMaterialInfo.privilegeDetail.merchantDetail.merchantUserInfo.telephone]];
            [telWebView loadRequest:[NSURLRequest requestWithURL:url]];
        }
    }
}

#pragma mark ----- uiwebview代理方法
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    if (webView.tag == 1) {
        CGSize actualSize = [webView sizeThatFits:CGSizeZero];
        CGRect newFrame = webView.frame;
        newFrame.size.height = actualSize.height;
        self.footHeight = actualSize.height;
        [self.tableView.tableFooterView reloadInputViews];
        
        /**
         *  设置tableHeadView
         */
        [self setupTableHeadFootView];
    }
}

@end
