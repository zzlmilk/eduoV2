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

@interface SLVipProductViewController ()

@property (nonatomic, weak) UIWebView *telWebView;

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
    
    /**
     *  设置tableHeadView
     */
    [self setupTableHeadFootView];
    
    [self setupVipProductData];
}

#warning -------
- (void)setupVipProductData
{
    
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
    webView.frame = CGRectMake(0, 0, 320, 320);
    [webView loadHTMLString:vipStatus.firstMaterialInfo.content baseURL:nil];
    
    footView.textLabel.font = SLVipStatusTitleFont;
    footView.textLabel.textColor = [UIColor blackColor];
    footView.textLabel.text = vipStatus.firstMaterialInfo.content;
    SLLog(@"%@", vipStatus.firstMaterialInfo.content);
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
    
    if ([self.vipStatus.firstMaterialInfo.privilegeDetail.saleDescript isEqualToString:@""]) {
        
        // 利用创建好的uiwebview加载request
        if (indexPath.row == 2) {
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", self.vipStatus.firstMaterialInfo.privilegeDetail.merchantDetail.merchantUserInfo.telephone]];
            [telWebView loadRequest:[NSURLRequest requestWithURL:url]];
        }
        
    } else {
        if (indexPath.row == 3) {
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", self.vipStatus.firstMaterialInfo.privilegeDetail.merchantDetail.merchantUserInfo.telephone]];
            [telWebView loadRequest:[NSURLRequest requestWithURL:url]];
        }
    }
}


@end
