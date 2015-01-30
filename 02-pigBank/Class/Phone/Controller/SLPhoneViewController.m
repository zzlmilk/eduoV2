//
//  SLPhoneViewController.m
//  02-pigBank
//
//  Created by 陆承东 on 14-9-13.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLPhoneViewController.h"

#import "SLConsultantTool.h"

#import "MBProgressHUD+MJ.h"

@interface SLPhoneViewController ()<UIActionSheetDelegate>

@property (nonatomic, strong) SLConsultant *consultant;

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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setActionSheet];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark ----- 设置actionSheet
- (void)setActionSheet
{
    self.consultant = [SLConsultantTool getConsultantAccount];
    
    UIActionSheet *actionSheet;
    if (self.consultant.mobile) {
        if (self.consultant.telephone) {
            actionSheet = [[UIActionSheet alloc] initWithTitle:self.consultant.dispName delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:self.consultant.mobile, self.consultant.telephone, nil];
        } else {
            actionSheet = [[UIActionSheet alloc] initWithTitle:self.consultant.dispName delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:self.consultant.mobile, nil];
        }
    } else {
        if (self.consultant.telephone) {
            actionSheet = [[UIActionSheet alloc] initWithTitle:self.consultant.dispName delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:self.consultant.telephone, nil];
        } else {
            actionSheet = [[UIActionSheet alloc] initWithTitle:self.consultant.dispName delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:nil];
        }
    }
    
    actionSheet.delegate = self;
    [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIWebView *callWebView = [[UIWebView alloc] init];
    [self.view addSubview:callWebView];
    
    if (self.consultant.mobile) {
        if (self.consultant.telephone) {
            if (buttonIndex == 0) {
                NSURL *url = [NSURL URLWithString:self.consultant.mobile];
                [callWebView loadRequest:[NSURLRequest requestWithURL:url]];
                [self pop];
            } else if (buttonIndex == 1) {
                NSURL *url = [NSURL URLWithString:self.consultant.telephone];
                [callWebView loadRequest:[NSURLRequest requestWithURL:url]];
                [self pop];
            } else if (buttonIndex == 2) {
                [self pop];
            }
        } else {
            if (buttonIndex == 0) {
                NSURL *url = [NSURL URLWithString:self.consultant.mobile];
                [callWebView loadRequest:[NSURLRequest requestWithURL:url]];
                [self pop];
            } else if (buttonIndex == 1) {
                [self pop];
            }
        }
    } else {
        if (self.consultant.telephone) {
            if (buttonIndex == 0) {
                NSURL *url = [NSURL URLWithString:self.consultant.telephone];
                [callWebView loadRequest:[NSURLRequest requestWithURL:url]];
                [self pop];
            } else if (buttonIndex == 1) {
                [self pop];
            }
        } else {
            if (buttonIndex == 0) {
                [self pop];
            }
        }
    }
}

- (void)pop
{
    if ([self.delegate respondsToSelector:@selector(phoneViewControllerDidPoped:)]) {
        [self.delegate phoneViewControllerDidPoped:self];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
