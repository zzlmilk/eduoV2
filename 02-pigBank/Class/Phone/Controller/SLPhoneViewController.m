//
//  SLPhoneViewController.m
//  02-pigBank
//
//  Created by 陆承东 on 14-9-13.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLPhoneViewController.h"
#import "SLTitleButton.h"
#import "MBProgressHUD+MJ.h"

@interface SLPhoneViewController ()<UIActionSheetDelegate>

@property (nonatomic, weak) UIView *coverView;

@end

@implementation SLPhoneViewController

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
    
    
//    [MBProgressHUD showMessage:@""];
    
    
    
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor whiteColor];
//    
//    SLTitleButton *button = [[SLTitleButton alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
//    
//    [button setImage:[UIImage imageNamed:@"navigationbar_arrow_up_os7"] forState:UIControlStateNormal];
//    [button setTitle:@"哈哈哈哈" forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
//    
//    self.navigationItem.titleView = button;
    
    
}

//-

//- (void)titleClick:(SLTitleButton *)button
//{
//    if (button.currentImage == [UIImage imageNamed:@"navigationbar_arrow_up_os7"]) {
//        [UIView animateWithDuration:0.5 animations:^{
//            [button setImage:[UIImage imageNamed:@"navigationbar_arrow_down_os7"] forState:UIControlStateNormal];
//        }];
//    } else {
//        [UIView animateWithDuration:0.5 animations:^{
//            [button setImage:[UIImage imageNamed:@"navigationbar_arrow_up_os7"] forState:UIControlStateNormal];
//        }];
//    }
//}

- (void)viewWillAppear:(BOOL)animated
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"猪子" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"021-10000", @"18121253011", nil];
    
    [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
#warning 已经创建了call
    UIWebView *callWebView = [[UIWebView alloc] init];
    [self.view addSubview:callWebView];
    
    if (buttonIndex == 0) {
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://18121253011"]];
        [callWebView loadRequest:[NSURLRequest requestWithURL:url]];
    } else if (buttonIndex == 1) {
        SLLog(@"1111");
    } else if (buttonIndex == 2) {
        
    }
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
