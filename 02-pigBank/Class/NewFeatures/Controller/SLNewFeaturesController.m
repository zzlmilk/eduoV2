//
//  SLNewFeaturesController.m
//  02-pigBank
//
//  Created by 陆承东 on 14-9-16.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLNewFeaturesController.h"
#import "SLTabBarController.h"
#import "SLLoginViewController.h"

#define newFeatureImageCount 5

@interface SLNewFeaturesController () <UIScrollViewDelegate>

@property (nonatomic, weak) UIPageControl *pageControl;

@end

@implementation SLNewFeaturesController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupNewFeature];
    
    [self setupPageControl];
}

#pragma mark ----- setupPageControl设置控制页
- (void)setupPageControl
{
    // 创建pageControl
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    // 设置pageControl的center和bounds属性
    pageControl.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height - 30);
    pageControl.bounds = CGRectMake(0, 0, 100, 30);
    // 设置一共有多少页
    pageControl.numberOfPages = newFeatureImageCount;
    // 设置pageControl的用户交互属性为NO
    pageControl.userInteractionEnabled = NO;
    
    // 添加到控制器的view中:不要添加到scrollView里面
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
    
//    // 设置圆点的颜色:currentPageIndicatorTintColor是选中页面的圆点的颜色
//    pageControl.currentPageIndicatorTintColor = SLColor(235, 98, 42);
//    // pageIndicatorTintColor是未选中的页面的圆点的颜色
//    pageControl.pageIndicatorTintColor = SLColor(189, 189, 189);
}

#pragma mark ----- scrollViewDidScroll:scrollView的代理方法,当scrollView被拖动时调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 取出当前offset的x值
    CGFloat offsetX = scrollView.contentOffset.x;
    
    // 算出当前的页码
    int page = (offsetX + self.view.frame.size.width * 0.5) / self.view.frame.size.width;
    self.pageControl.currentPage = page;
}

#pragma mark ----- setupNewFeature设置新特性页面
- (void)setupNewFeature
{
    UIScrollView *newFeature = [[UIScrollView alloc] init];
    
    // 设置代理:可以通知pageControl什么时候应该切换页面
    newFeature.delegate = self;
    
    // 给scrollView设置frame
    newFeature.frame = self.view.frame;
    
    [self.view addSubview:newFeature];
    
    CGFloat imageW = self.view.frame.size.width;
    CGFloat imageH = self.view.frame.size.height;
    // 给scroll 添加图片
    for (int i = 0; i < newFeatureImageCount; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        // 拼接图片的名字
        NSString *name = [NSString stringWithFormat:@"app_help_%d", i + 1];
        imageView.image = [UIImage imageNamed:name];
        
        // 设置imageView的frame
        CGFloat imageX = i * imageW;
        imageView.frame = CGRectMake(imageX, 0, imageW, imageH);
        
        // 将imageView添加到scrollView里面
        [newFeature addSubview:imageView];
        
        // 设置最后一个图片的功能
        if (i == newFeatureImageCount - 1) {
            [self setupLastImageView:imageView];
        }
    }
    
    newFeature.contentSize = CGSizeMake(imageW * newFeatureImageCount, 0);
    newFeature.showsHorizontalScrollIndicator = NO;
    newFeature.pagingEnabled = YES;
    newFeature.bounces = NO;
}

#pragma mark ----- setupLastImageView设置最后一张图片,就是进入程序的按钮
- (void)setupLastImageView:(UIImageView *)imageView
{
    // 1.使当前的imageVIew可以和用户交互
    imageView.userInteractionEnabled = YES;
    
    // 添加开始按钮
    UIButton *startButton = [[UIButton alloc] init];
    
    // 设置startButton的相关属性
    // frame
    startButton.center = CGPointMake(imageView.frame.size.width * 0.5, imageView.frame.size.height * 0.8);
    startButton.bounds = CGRectMake(0, 0, 100, 30);
    [startButton setTitle:@"开始使用" forState:UIControlStateNormal];
    [startButton setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startButton setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    [startButton addTarget:self action:@selector(startButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    // 将按钮添加到imageView上面
    [imageView addSubview:startButton];
}

#pragma mark ----- startButtonClick开始按钮点击事件
- (void)startButtonClick
{
    // 隐藏状态栏
    [UIApplication sharedApplication].statusBarHidden = NO;
    
    // 更换窗口根控制器
    self.view.window.rootViewController = [[SLLoginViewController alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
