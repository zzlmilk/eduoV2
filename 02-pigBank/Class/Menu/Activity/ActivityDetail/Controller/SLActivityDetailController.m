//
//  SLActivityDetailController.m
//  02-pigBank
//
//  Created by 陆承东 on 15/1/21.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import "SLActivityDetailController.h"

#import "SLMaterialDetailParameters.h"
#import "SLActivitySignParameters.h"
#import "SLActivityDetailFrame.h"

#import "SLBackButton.h"
#import "SLPraiseButton.h"
#import "SLCollectButton.h"
#import "SLActivityDetailHeadView.h"
#import "SLActivitySignCoverView.h"
#import "SLActivityDetailSignCell.h"
#import "SLActivityDetailAddressCell.h"
#import "SLActivityDetailTimeCell.h"
#import "SLWebViewCell.h"
#import "SLClientToolBar.h"

#import "SLMessageListController.h"
#import "SLMessageViewController.h"
#import "SLClientListTableViewController.h"
#import "SLMapViewController.h"

#import "SLAccountTool.h"
#import "SLConsultantTool.h"
#import "SLActivityTool.h"
#import "NSString+S_LINE.h"

#import "MBProgressHUD+MJ.h"

@interface SLActivityDetailController () <UITableViewDataSource, UITableViewDelegate, UIWebViewDelegate, UIActionSheetDelegate, SLActivityDetailSignCellDelegate, SLActivitySignCoverViewDelegate, SLClientToolBarDelegate>

@property (nonatomic, strong) SLActivityDetail *activityDetail;
@property (nonatomic, strong) SLActivityDetailFrame *activityDetailFrame;

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) SLClientToolBar *toolBar;
@property (nonatomic, weak) SLActivityDetailSignCell *activityDetailSignCell;
@property (nonatomic, weak) UIWebView *detailInfoWebView;
@property (nonatomic, assign) CGFloat footHeight;

@property (nonatomic, weak) SLActivitySignCoverView *signCoverView;

@end

@implementation SLActivityDetailController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    
    [self setNavBar];
}

#pragma mark ----- 设置导航栏样式
- (void)setNavBar
{
//    UINavigationBar *navBar = self.navigationController.navigationBar;
//    // 设置背景
//    [navBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
//    [navBar setBarTintColor:SLColor(246, 246, 246)];
    
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
    
    [self addSubviews];
}

- (void)addSubviews
{
    self.view.backgroundColor = SLWhite;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    tableView.hidden = YES;
    self.tableView = tableView;
    [self.view addSubview:tableView];
    
    SLActivitySignCoverView *signCoverView = [[SLActivitySignCoverView alloc] initWithFrame:self.view.frame];
    signCoverView.alpha = 0;
    signCoverView.hidden = YES;
    signCoverView.delegate = self;
    self.signCoverView = signCoverView;
    [self.view addSubview:signCoverView];
    
    UITapGestureRecognizer *tapCover = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCover:)];
    [signCoverView addGestureRecognizer:tapCover];
    
    CGFloat toolBarW = screenW;
    CGFloat toolBarH = 49;
    CGFloat toolBarX = 0;
    CGFloat toolBarY = screenH - toolBarH;
    SLClientToolBar *toolBar = [[SLClientToolBar alloc] initWithFrame:CGRectMake(toolBarX, toolBarY, toolBarW, toolBarH)];
    toolBar.delegate = self;
    toolBar.hidden = YES;
    self.toolBar = toolBar;
    [self.view addSubview:toolBar];
    
    [self loadInternetData];
}

- (void)clientToolBar:(SLClientToolBar *)clientToolBar didClickedLeftButton:(SLTabBarButton *)leftButton
{
    SLAccount *account = [SLAccountTool getAccount];
    
    if ([account.accountInfo.userType isEqualToString:@"3"]) {
        SLMessageViewController *messagevc = [[SLMessageViewController alloc] init];
        messagevc.from = @"toolBar";
        [self.navigationController pushViewController:messagevc animated:YES];
    } else if ([account.accountInfo.userType isEqualToString:@"2"]) {
        SLMessageListController *mlvc = [[SLMessageListController alloc] init];
        mlvc.from = @"toolBar";
        [self.navigationController pushViewController:mlvc animated:YES];
    }
}

- (void)clientToolBar:(SLClientToolBar *)clientToolBar didClickedRightButton:(SLTabBarButton *)rightButton
{
    SLAccount *account = [SLAccountTool getAccount];
    
    if ([account.accountInfo.userType isEqualToString:@"2"]) {
        SLClientListTableViewController *clvc = [[SLClientListTableViewController alloc] init];
        clvc.from = @"toolBar";
        [self.navigationController pushViewController:clvc animated:YES];
    } else if ([account.accountInfo.userType isEqualToString:@"3"]) {
        [self setActionSheet];
    }
}

#pragma mark ----- 设置actionSheet
- (void)setActionSheet
{
    SLConsultant *consultant = [SLConsultantTool getConsultantAccount];
    
    UIActionSheet *actionSheet;
    if (consultant.mobile) {
        if (consultant.telephone) {
            actionSheet = [[UIActionSheet alloc] initWithTitle:consultant.dispName delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:consultant.mobile, consultant.telephone, nil];
        } else {
            actionSheet = [[UIActionSheet alloc] initWithTitle:consultant.dispName delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:consultant.mobile, nil];
        }
    } else {
        if (consultant.telephone) {
            actionSheet = [[UIActionSheet alloc] initWithTitle:consultant.dispName delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:consultant.telephone, nil];
        } else {
            actionSheet = [[UIActionSheet alloc] initWithTitle:consultant.dispName delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:nil];
        }
    }
    
    [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIWebView *callWebView = [[UIWebView alloc] init];
    [self.view addSubview:callWebView];
    
    SLConsultant *consultant = [SLConsultantTool getConsultantAccount];
    
    if (consultant.mobile) {
        if (consultant.telephone) {
            if (buttonIndex == 0) {
                NSURL *url = [NSURL URLWithString:consultant.mobile];
                [callWebView loadRequest:[NSURLRequest requestWithURL:url]];
            } else if (buttonIndex == 1) {
                NSURL *url = [NSURL URLWithString:consultant.telephone];
                [callWebView loadRequest:[NSURLRequest requestWithURL:url]];
            } else if (buttonIndex == 2) {
            }
        } else {
            if (buttonIndex == 0) {
                NSURL *url = [NSURL URLWithString:consultant.mobile];
                [callWebView loadRequest:[NSURLRequest requestWithURL:url]];
            } else if (buttonIndex == 1) {
            }
        }
    } else {
        if (consultant.telephone) {
            if (buttonIndex == 0) {
                NSURL *url = [NSURL URLWithString:consultant.telephone];
                [callWebView loadRequest:[NSURLRequest requestWithURL:url]];
            } else if (buttonIndex == 1) {
            }
        } else {
            if (buttonIndex == 0) {
            }
        }
    }
}

#pragma mark ----- cover的点击事件
- (void)tapCover:(UITapGestureRecognizer *)tapCover
{
    [self.view endEditing:YES];
}

#pragma mark ----- 加载网络数据
- (void)loadInternetData
{
    SLMaterialDetailParameters *parameters = [SLMaterialDetailParameters parameters];
    parameters.materialId = self.materialId;
    
    [SLActivityTool activityDetailWithParameters:parameters success:^(SLActivityDetail *activityDetail) {
        
        self.tableView.hidden = NO;
        self.toolBar.hidden = NO;
        
        self.activityDetail = activityDetail;
        SLActivityDetailFrame *activityDetailFrame = [[SLActivityDetailFrame alloc] init];
        activityDetailFrame.activityDetail = activityDetail;
        self.activityDetailFrame = activityDetailFrame;
        
        [self.tableView reloadData];
        [self setupTableHeadFootView];
        
        // 计算foot的高度
        [self calculateFootHeight];
        
        [self setCollectAndPrise];
        
        [MBProgressHUD hideHUD];
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"请检查网络..."];
    }];
}

#pragma mark ----- 设置tableHeadView
- (void)setupTableHeadFootView
{
    // headView
    SLActivityDetailHeadView *headView = [[SLActivityDetailHeadView alloc] init];
    headView.frame = CGRectMake(0, 0, screenW, 200);
    headView.activityDetail = self.activityDetail;
    
    self.tableView.tableHeaderView = headView;
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenW, 0.5)];
    footView.backgroundColor = [UIColor clearColor];
    self.tableView.tableFooterView = footView;
}

#pragma mark ----- setCollectAndPrise设置赞和收藏按钮
- (void)setCollectAndPrise
{
    // 设置右上角的barButton
    SLPraiseButton *praiseButton = [SLPraiseButton button];
    [praiseButton setMaterialId:self.activityDetail.materialId praiseCounts:@23 praiseFlag:self.activityDetail.praiseFlag];
    UIBarButtonItem *praiseItem = [[UIBarButtonItem alloc] initWithCustomView:praiseButton];
    
    SLCollectButton *collectButton = [SLCollectButton button];
    [collectButton setMaterialId:self.activityDetail.materialId collectFlag:self.activityDetail.collectFlag];
    UIBarButtonItem *collectItem = [[UIBarButtonItem alloc] initWithCustomView:collectButton];
    
    NSArray *rightBarButtonItems = @[praiseItem, collectItem];
    self.navigationItem.rightBarButtonItems = rightBarButtonItems;
}

#pragma mark ----- 计算webview的高度
- (void)calculateFootHeight
{
    UIWebView *webview = [[UIWebView alloc]initWithFrame:CGRectMake(-320, 0, 320, 1)];
    webview.delegate = self;
    webview.tag = 1;
    [webview loadHTMLString:self.activityDetail.content baseURL:nil];
    [self.view addSubview:webview];
}

#pragma mark - Tableview datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 3;
    } else if (section == 1) {
        return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            SLActivityDetailSignCell *cell = [SLActivityDetailSignCell cellWithTableView:tableView];
            cell.activityDetail = self.activityDetail;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegate = self;
            self.activityDetailSignCell = cell;
            return cell;
        } else if (indexPath.row == 1) {
            SLActivityDetailTimeCell *cell = [SLActivityDetailTimeCell cellWithTableView:tableView];
            cell.activityDetailFrame = self.activityDetailFrame;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        } else if (indexPath.row == 2) {
            SLActivityDetailAddressCell *cell = [SLActivityDetailAddressCell cellWithTableView:tableView];
            cell.activityDetailFrame = self.activityDetailFrame;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }
    } else if (indexPath.section == 1) {
        SLWebViewCell *cell = [SLWebViewCell cellWithTableView:tableView];
        UIWebView *webview = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 320, self.footHeight)];
        webview.delegate = self;
        webview.backgroundColor = [UIColor clearColor];
        webview.scrollView.bounces = NO;//禁止滑动
        self.detailInfoWebView = webview;
        [webview loadHTMLString:self.activityDetail.content baseURL:nil];
        [cell.contentView addSubview:webview];
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 44;
        } else if (indexPath.row == 1) {
            return self.activityDetailFrame.timeHeight ? self.activityDetailFrame.timeHeight : 70;
        } else if (indexPath.row == 2) {
            return self.activityDetailFrame.addressHeight ? self.activityDetailFrame.addressHeight : 44;
        }
    } else if (indexPath.section == 1) {
        return (self.footHeight < 44) ? 44 : self.footHeight;
    }
    return 44;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return nil;
    } else if (section == 1) {
        return @"活动详情";
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 2) {
            SLMapViewController *mvc = [[SLMapViewController alloc] init];
            mvc.activityDetail = self.activityDetail;
            [self.navigationController pushViewController:mvc animated:YES];
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
        
        [self.tableView reloadData];
    }
}

#pragma mark ----- SLActivityDetailSignCell代理方法
- (void)activityDetailSignCell:(SLActivityDetailSignCell *)activityDetailSignCell didClickedSignButton:(UIButton *)signButton
{
    self.signCoverView.hidden = NO;
    
    [UIView animateWithDuration:0.5 animations:^{
        self.signCoverView.alpha = 1;
    } completion:^(BOOL finished) {
        [self.signCoverView becomeFirstResponder];
    }];
}

#pragma mark ----- SLActivitySignCoverView代理方法
- (void)activitySignCoverView:(SLActivitySignCoverView *)activitySignCoverView didClickedCancelButton:(UIButton *)cancelButton
{
    [UIView animateWithDuration:0.5 animations:^{
        self.signCoverView.alpha = 0;
    } completion:^(BOOL finished) {
        self.signCoverView.hidden = YES;
    }];
}

- (void)activitySignCoverView:(SLActivitySignCoverView *)activitySignCoverView didClickedCommitButton:(UIButton *)commitButton withName:(NSString *)name mobile:(NSString *)mobile
{
    SLActivitySignParameters *parameters = [SLActivitySignParameters parameters];
    parameters.materialId = self.activityDetail.materialId;
    parameters.name = name;
    parameters.mobile = mobile;
    
    [SLActivityTool activitySignWithParameters:parameters success:^(SLResult *result) {
        
        [MBProgressHUD hideHUD];
        
        if ([result.code isEqualToString:successStr]) {
            [MBProgressHUD showSuccess:@"报名成功!"];
            
            [UIView animateWithDuration:0.5 animations:^{
                self.signCoverView.alpha = 0;
            } completion:^(BOOL finished) {
                self.signCoverView.hidden = YES;
            }];
            
            [self.activityDetailSignCell setButtonDisable];
        }
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
