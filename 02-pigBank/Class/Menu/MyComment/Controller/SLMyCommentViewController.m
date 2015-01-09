//
//  SLMyCommentViewController.m
//  02-pigBank
//
//  Created by 陆承东 on 14/12/12.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLMyCommentViewController.h"

#import "SLMyCommentParameters.h"

#import "SLMyCommentCell.h"
#import "SLMyCommentSectionFootView.h"

#import "SLMerchantDetailController.h"

#import "SLMyCommentTool.h"

@interface SLMyCommentViewController ()

@property (nonatomic, strong) NSArray *myCommentStatusFrames;

@end

@implementation SLMyCommentViewController

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self loadNewData];
}

#pragma mark ----- loadInternetData加载网络数据
- (void)loadNewData
{
    SLMyCommentParameters *parameters = [SLMyCommentParameters parameters];
    parameters.curPage = @1;
    parameters.pageSize = @20;
    
    [SLMyCommentTool myCommentsWithParameters:parameters success:^(NSArray *myCommentStatusFrameArray) {
        
        self.myCommentStatusFrames = myCommentStatusFrameArray;
        
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark ----- Tableview datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.myCommentStatusFrames.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 创建cell
    SLMyCommentCell *cell = [SLMyCommentCell cellWithTableView:tableView];
    
    SLMyCommentStatusFrame *myCommentStatusFrame = self.myCommentStatusFrames[indexPath.section];
    cell.myCommentStatusFrame = myCommentStatusFrame;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SLMyCommentStatusFrame *frame = self.myCommentStatusFrames[indexPath.section];
    return frame.cellHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    SLMyCommentStatusFrame *myCommentStatusFrame = self.myCommentStatusFrames[section];
    SLMyCommentSectionFootView *myCommentSectionFootView = [[SLMyCommentSectionFootView alloc] initWithFrame:myCommentStatusFrame.sectionFootViewF];
    myCommentSectionFootView.backgroundColor = [UIColor whiteColor];
    myCommentSectionFootView.myCommentStatusFrame = myCommentStatusFrame;
    return myCommentSectionFootView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    SLMyCommentStatusFrame *myCommentStatusFrame = self.myCommentStatusFrames[section];
    return myCommentStatusFrame.sectionHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
}

#pragma mark ----- Tableview delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SLMyCommentStatusFrame *frame = self.myCommentStatusFrames[indexPath.section];
    SLVipMerchantDetail *merchantDetail = frame.myCommentStatus.merchantDetail;
    
    SLMerchantDetailController *vc = [[SLMerchantDetailController alloc] init];
//    vc.vipMerchantDetail = merchantDetail;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
