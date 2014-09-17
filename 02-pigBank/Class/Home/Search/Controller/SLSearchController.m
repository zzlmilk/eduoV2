//
//  SLSearchController.m
//  02-pigBank
//
//  Created by 陆承东 on 14-9-15.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLSearchController.h"
#import "SLSearchBar.h"

@interface SLSearchController ()

@end

@implementation SLSearchController

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
    
//    UINavigationBar *navBar = self.navigationController.navigationBar;
//    // 设置背景
//    [navBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    SLSearchBar *search = [[SLSearchBar alloc] init];
    search.frame = CGRectMake(10, 100, 300, 30);
    self.navigationItem.titleView = search;
    
    // 隐藏返回按钮
    self.navigationItem.hidesBackButton = YES;
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    
    self.navigationItem.rightBarButtonItem = item;
}

- (void)cancel
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        nil;
    }];
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
