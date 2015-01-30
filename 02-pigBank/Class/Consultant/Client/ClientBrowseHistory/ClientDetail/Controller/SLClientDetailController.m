//
//  SLClientDetailController.m
//  02-pigBank
//
//  Created by 陆承东 on 15/1/23.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import "SLClientDetailController.h"

#import "SLUserTag.h"
#import "SLClientDetailFrame.h"

#import "SLBackButton.h"
#import "SLRightImageButton.h"
#import "SLUpImageButton.h"
#import "SLTagSelectView.h"

#import "SLClientRemarkController.h"
#import "SLNavigationController.h"
#import "SLClientTagController.h"

#import "SLClientTool.h"
#import "SLChangeAttentionTool.h"

#import "UIImageView+MJWebCache.h"
#import "MBProgressHUD+MJ.h"

@interface SLClientDetailController ()<SLTagSelectViewDelegate>

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIImageView *iconImageView;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *gradeLabel;
@property (nonatomic, weak) UIView *verticalSeparatorView;
@property (nonatomic, weak) SLUpImageButton *attentionButton;
@property (nonatomic, weak) UIView *horizontalSeparatorViewFirst;
@property (nonatomic, weak) SLRightImageButton *remarkButton;
@property (nonatomic, weak) UIView *horizontalSeparatorViewSecond;
@property (nonatomic, strong) NSArray *tagLabelArray;
@property (nonatomic, weak) SLTagSelectView *tagSelectedView;
@property (nonatomic, weak) UIButton *addTagButton;

@property (nonatomic, strong) SLClientDetail *clientDetail;

@end

@implementation SLClientDetailController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self loadInternetData];
    
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

#pragma mark ----- addSubviews添加子控件
- (void)addSubviews
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    self.scrollView = scrollView;
    [self.view addSubview:scrollView];
    
    UIImageView *iconImageView = [[UIImageView alloc] init];
    self.iconImageView = iconImageView;
    [scrollView addSubview:iconImageView];
    
    UILabel *nameLabel = [[UILabel alloc] init];
    self.nameLabel = nameLabel;
    [scrollView addSubview:nameLabel];
    
    UILabel *gradeLabel = [[UILabel alloc] init];
    self.gradeLabel = gradeLabel;
    [scrollView addSubview:gradeLabel];
    
    UIView *verticalSeparatorView = [[UIView alloc] init];
    self.verticalSeparatorView = verticalSeparatorView;
    [scrollView addSubview:verticalSeparatorView];
    
    SLUpImageButton *attentionButton = [[SLUpImageButton alloc] init];
    self.attentionButton = attentionButton;
    [scrollView addSubview:attentionButton];
    
    UIView *horizontalSeparatorViewFirst = [[UIView alloc] init];
    self.horizontalSeparatorViewFirst = horizontalSeparatorViewFirst;
    [scrollView addSubview:horizontalSeparatorViewFirst];
    
    SLRightImageButton *remarkButton = [[SLRightImageButton alloc] init];
    self.remarkButton = remarkButton;
    [scrollView addSubview:remarkButton];
    
    UIView *horizontalSeparatorViewSecond = [[UIView alloc] init];
    self.horizontalSeparatorViewSecond = horizontalSeparatorViewSecond;
    [scrollView addSubview:horizontalSeparatorViewSecond];
    
    
    SLTagSelectView *tagSelectedView = [[SLTagSelectView alloc] init];
    tagSelectedView.delegate = self;
    self.tagSelectedView = tagSelectedView;
    [scrollView addSubview:tagSelectedView];
}

#pragma mark ----- 加载用户详情数据
- (void)loadInternetData
{
    SLClientDetailParameters *parameters = [SLClientDetailParameters parameters];
    parameters.userId = self.client.userId;
    
    [SLClientTool clientDetailWithParameters:parameters success:^(SLClientDetail *clientDetail) {
        
        self.clientDetail = clientDetail;
        
        [self setSubviewsData];
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark ----- 设置子控件数据
- (void)setSubviewsData
{
    SLClientDetailFrame *clientDetailFrame = [[SLClientDetailFrame alloc] init];
    clientDetailFrame.clientDetail = self.clientDetail;
    SLClientDetail *clientDetail = self.clientDetail;
    
    self.iconImageView.frame = clientDetailFrame.iconImageViewF;
    [self.iconImageView setImageURLStr:clientDetail.pictureUrl placeholder:[UIImage imageNamed:@"icon_image_placehold"]];
    self.iconImageView.layer.cornerRadius = 5;
    self.iconImageView.clipsToBounds = YES;
    
    self.nameLabel.frame = clientDetailFrame.nameLabelF;
    self.nameLabel.font = SLBoldFont16;
    if (clientDetail.userRemark.remarkName.length == 0) {
        self.nameLabel.text = clientDetail.dispName;
    } else {
        self.nameLabel.text = [NSString stringWithFormat:@"%@(%@)", clientDetail.dispName, clientDetail.userRemark.remarkName];
    }
    
    self.gradeLabel.frame = clientDetailFrame.gradeLabelF;
    self.gradeLabel.font = SLFont14;
    self.gradeLabel.text = clientDetail.vipDetail.levelSignText;
    
    self.verticalSeparatorView.frame = clientDetailFrame.verticalSeparatorViewF;
    self.verticalSeparatorView.backgroundColor = SLLightGray;
    
    self.attentionButton.frame = clientDetailFrame.attentionButtonF;
    [self.attentionButton setTitle:@"取消关注" forState:UIControlStateNormal];
    [self.attentionButton setTitleColor:SLLightGray forState:UIControlStateNormal];
    [self.attentionButton setImage:[UIImage imageNamed:@"icon_button_attention_normal"] forState:UIControlStateNormal];
    [self.attentionButton setTitle:@"关注" forState:UIControlStateSelected];
    [self.attentionButton setTitleColor:SLRed forState:UIControlStateSelected];
    [self.attentionButton setImage:[UIImage imageNamed:@"icon_button_attention_selected"] forState:UIControlStateSelected];
    [self.attentionButton addTarget:self action:@selector(attentionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.horizontalSeparatorViewFirst.frame = clientDetailFrame.horizontalSeparatorViewFirstF;
    self.horizontalSeparatorViewFirst.backgroundColor = SLLightGray;
    
    self.remarkButton.frame = clientDetailFrame.remarkButtonF;
    [self.remarkButton setTitle:[NSString stringWithFormat:@"备注  %@", clientDetail.userRemark.remarkDesc] forState:UIControlStateNormal];
    [self.remarkButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.remarkButton setImage:[UIImage imageNamed:@"icon_button_rightd_normal"] forState:UIControlStateNormal];
    [self.remarkButton addTarget:self action:@selector(remarkButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.horizontalSeparatorViewSecond.frame = clientDetailFrame.horizontalSeparatorViewSecondF;
    self.horizontalSeparatorViewSecond.backgroundColor = SLLightGray;

    NSMutableArray *clientTagArray = [NSMutableArray array];
    [clientTagArray addObjectsFromArray:clientDetail.userTags];
    SLUserTag *addTag = [[SLUserTag alloc] init];
    addTag.tagText = @"编辑标签";
    [clientTagArray addObject:addTag];
    
    [self.tagSelectedView addTagWidth:screenW tagStrArray:clientTagArray];
    CGFloat tagSelectedViewX = 0;
    CGFloat tagSelectedViewY = CGRectGetMaxY(self.horizontalSeparatorViewSecond.frame);
    CGFloat tagSelectedViewW = screenW;
    CGFloat tagSelectedViewH = self.tagSelectedView.getHeight;
    self.tagSelectedView.frame = CGRectMake(tagSelectedViewX, tagSelectedViewY, tagSelectedViewW, tagSelectedViewH);
    
    CGFloat height = CGRectGetMaxY(self.tagSelectedView.frame);
    if (height > screenH) {
        self.scrollView.contentSize = CGSizeMake(0, height);
    }
}

#pragma mark ----- 关注按钮点击事件
- (void)attentionButtonClick:(SLUpImageButton *)attentionButton
{
    SLChangeAttentionParameters *parameters = [SLChangeAttentionParameters parameters];
    parameters.userId = self.client.userId;
    
    if (attentionButton.selected == YES) {
        parameters.attentionType = @"0";
        [SLChangeAttentionTool changeAttentionWithParameters:parameters success:^(SLResult *result) {
            if ([result.code isEqualToString:@"0000"]) {
                self.attentionButton.selected = NO;
                [MBProgressHUD showSuccess:@"取消关注成功"];
            }
        } failure:^(NSError *error) {
            
        }];
    } else {
        parameters.attentionType = @"1";
        [SLChangeAttentionTool changeAttentionWithParameters:parameters success:^(SLResult *result) {
            if ([result.code isEqualToString:@"0000"]) {
                self.attentionButton.selected = YES;
                [MBProgressHUD showSuccess:@"关注成功"];
            }
        } failure:^(NSError *error) {
            
        }];
    }
}

#pragma mark ----- 备注按钮点击事件
- (void)remarkButtonClick:(SLUpImageButton *)remarkButton
{
    SLClientRemarkController *crvc = [[SLClientRemarkController alloc] init];
    crvc.client = self.client;
    SLNavigationController *nav = [[SLNavigationController alloc] initWithRootViewController:crvc];
    crvc.title = @"添加备注";
    [self.navigationController presentViewController:nav animated:YES completion:^{
        
    }];
}

#pragma mark ----- SLTagSelectView代理方法
- (void)tagSelectedView:(SLTagSelectView *)tagSelectedView didSelectedScreenButton:(SLScreenButton *)screenButton
{
    SLClientTagController *ctvc = [[SLClientTagController alloc] init];
    ctvc.title = @"编辑标签";
    ctvc.client = self.client;
    [self.navigationController pushViewController:ctvc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
