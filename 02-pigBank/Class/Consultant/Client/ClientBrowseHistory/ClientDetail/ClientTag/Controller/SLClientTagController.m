//
//  SLClientTagController.m
//  02-pigBank
//
//  Created by 陆承东 on 15/1/26.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import "SLClientTagController.h"

#import "SLUserTag.h"

#import "SLBackButton.h"
#import "SLAddNewTagCoverView.h"

#import "SLClientTool.h"
#import "UIImage+S_LINE.h"

#import "MBProgressHUD+MJ.h"

@interface SLClientTagController ()<UITableViewDataSource, UITableViewDelegate, SLAddNewTagCoverViewDelagate>

@property (nonatomic, strong) NSArray *userTagArray;

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) SLAddNewTagCoverView *addNewTagCoverView;

@end

@implementation SLClientTagController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self loadClientTagListData];
    
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
    
    [self addSubviews];
}

#pragma mark ----- 添加子控件
- (void)addSubviews
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    tableView.delegate = self;
    tableView.dataSource = self;
    self.tableView = tableView;
    [self.view addSubview:tableView];
    
    SLAddNewTagCoverView *addNewTagCoverView = [[SLAddNewTagCoverView alloc] initWithFrame:self.view.frame];
    addNewTagCoverView.alpha = 0;
    addNewTagCoverView.hidden = YES;
    addNewTagCoverView.backgroundColor = SLColorRGBA(0, 0, 0, 0.8);
    addNewTagCoverView.delegate = self;
    self.addNewTagCoverView = addNewTagCoverView;
    [self.view addSubview:addNewTagCoverView];
    
    [self setTableHeadFootView];
}

#pragma mark ----- 添加新标签点击事件
- (void)addTagButtonClick:(UIButton *)addTagButton
{
    self.addNewTagCoverView.hidden = NO;
    [UIView animateWithDuration:0.5 animations:^{
        self.addNewTagCoverView.alpha = 1;
    }];
}

#pragma mark ----- SLAddNewTagCoverView代理方法
- (void)addNewTagCoverView:(SLAddNewTagCoverView *)addNewTagCoverView didClickedCancelButton:(UIButton *)cancelButton
{
    [UIView animateWithDuration:0.5 animations:^{
        self.addNewTagCoverView.alpha = 0;
    } completion:^(BOOL finished) {
        self.addNewTagCoverView.hidden = YES;
    }];
}

- (void)addNewTagCoverView:(SLAddNewTagCoverView *)addNewTagCoverView didClickedCommitButton:(UIButton *)commitButton withTagStr:(NSString *)tagStr
{
    SLAddNewTagParameters *parameters = [SLAddNewTagParameters parameters];
    parameters.userId = self.client.userId;
    parameters.tagName = tagStr;
    
    [SLClientTool clientAddNewTagWithParameters:parameters success:^(SLResult *result) {
        
        [UIView animateWithDuration:0.5 animations:^{
            self.addNewTagCoverView.alpha = 0;
        } completion:^(BOOL finished) {
            self.addNewTagCoverView.hidden = YES;
        }];
        
        if ([result.code isEqualToString:@"0000"]) {
            
            [MBProgressHUD showSuccess:@"成功添加标签"];
            
            [self loadClientTagListData];
        } else {
            
            [MBProgressHUD showSuccess:@"标签添加失败"];
            
            [self loadClientTagListData];
        }
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark ----- 设置tableHeadFootView
- (void)setTableHeadFootView
{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenW, 60)];
    
    UIView *separatorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenW, 0.5)];
    separatorView.backgroundColor = SLLightGray;
    [bgView addSubview:separatorView];
    
    UIButton *addTagButton = [[UIButton alloc] init];
    addTagButton.bounds = CGRectMake(0, 0, 100, 30);
    addTagButton.center = bgView.center;
    [addTagButton setTitle:@"添加新标签" forState:UIControlStateNormal];
    [addTagButton setTitleColor:SLRed forState:UIControlStateNormal];
    addTagButton.titleLabel.font = SLFont16;
    [addTagButton setImage:[UIImage imageNamed:@"icon_button_image_add_normal"] forState:UIControlStateNormal];
    [addTagButton setBackgroundImage:[UIImage resizableImageWithImageName:@"icon_button_bgImage_add_normal"] forState:UIControlStateNormal];
    [addTagButton addTarget:self action:@selector(addTagButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:addTagButton];
    
    self.tableView.tableFooterView = bgView;
}

#pragma mark ----- 获取网络数据
- (void)loadClientTagListData
{
    SLClientTagListParameters *parameters = [SLClientTagListParameters parameters];
    parameters.userId = self.client.userId;
    
    [SLClientTool clientTagListWithParameters:parameters success:^(NSArray *userTagArray) {
        
        self.userTagArray = userTagArray;
        
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - Tableview datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.userTagArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SLUserTag *userTag = self.userTagArray[indexPath.row];
    
    static NSString *ID = @"SLClientTagListCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.font = SLFont16;
    cell.textLabel.text = userTag.tagText;
    if ([userTag.used intValue] == 0) {
        cell.accessoryType = UITableViewCellAccessoryNone;
    } else {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SLUserTag *userTag = self.userTagArray[indexPath.row];
    
    SLSetTagParameters *parameters = [SLSetTagParameters parameters];
    parameters.userId = self.client.userId;
    parameters.tagId = userTag.tagId;
    parameters.operateType = [NSNumber numberWithInt:![userTag.used intValue]];
    
    [SLClientTool clientSetTagWithParameters:parameters success:^(SLResult *result) {
        
        if ([result.code isEqualToString:@"0000"]) {
            [MBProgressHUD showSuccess:result.msg];
            
            [self loadClientTagListData];
        } else if ([result.code isEqualToString:@"9997"]) {
            [MBProgressHUD showError:@"参数错误，操作类型值错误"];
        } else if ([result.code isEqualToString:@"9996"]) {
            [MBProgressHUD showError:@"逻辑原因，禁止访问。用户标签与登陆信息不匹配"];
        } else if ([result.code isEqualToString:@"9001"]) {
            [MBProgressHUD showError:@"用户不存在"];
        }
        
    } failure:^(NSError *error) {
        
    }];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        SLUserTag *userTag = self.userTagArray[indexPath.row];
        
        SLDeleteTagParameters *parameters = [SLDeleteTagParameters parameters];
        parameters.tagId = userTag.tagId;
        
        [SLClientTool clientDeleteTagWithParameters:parameters success:^(SLResult *result) {
            if ([result.code isEqualToString:@"0000"]) {
                [MBProgressHUD showSuccess:result.msg];
                
                [self loadClientTagListData];
            } else if ([result.code isEqualToString:@"9996"]) {
                [MBProgressHUD showError:result.msg];
                
                [self.tableView reloadData];
            }
        } failure:^(NSError *error) {
            
        }];
        
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
