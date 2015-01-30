//
//  SLPhoneActionSheet.m
//  02-pigBank
//
//  Created by 陆承东 on 15/1/28.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import "SLPhoneActionSheet.h"

#import "SLConsultantTool.h"

@interface SLPhoneActionSheet () <UIActionSheetDelegate>

@property (nonatomic, strong) SLConsultant *consultant;

@end

@implementation SLPhoneActionSheet

- (instancetype)init
{
    if (self) {
        SLConsultant *consultant = [SLConsultantTool getConsultantAccount];
        self.consultant = consultant;
        
        if (self.consultant.mobile) {
            if (consultant.telephone) {
                self = [self initWithTitle:self.consultant.dispName delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:self.consultant.mobile, self.consultant.telephone, nil];
            } else {
                self = [self initWithTitle:self.consultant.dispName delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:self.consultant.mobile, nil];
            }
        } else {
            if (consultant.telephone) {
                self = [self initWithTitle:self.consultant.dispName delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:self.consultant.telephone, nil];
            } else {
                self = [self initWithTitle:self.consultant.dispName delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:nil];
            }
        }
        
        self.delegate = self;
    }
    return self;
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIWebView *callWebView = [[UIWebView alloc] init];
    [self addSubview:callWebView];
    
    if (self.consultant.mobile) {
        if (self.consultant.telephone) {
            if (buttonIndex == 0) {
                NSURL *url = [NSURL URLWithString:self.consultant.mobile];
                [callWebView loadRequest:[NSURLRequest requestWithURL:url]];
            } else if (buttonIndex == 1) {
                NSURL *url = [NSURL URLWithString:self.consultant.telephone];
                [callWebView loadRequest:[NSURLRequest requestWithURL:url]];
            } else if (buttonIndex == 2) {
            }
        } else {
            if (buttonIndex == 0) {
                NSURL *url = [NSURL URLWithString:self.consultant.mobile];
                [callWebView loadRequest:[NSURLRequest requestWithURL:url]];
            } else if (buttonIndex == 1) {
            }
        }
    } else {
        if (self.consultant.telephone) {
            if (buttonIndex == 0) {
                NSURL *url = [NSURL URLWithString:self.consultant.telephone];
                [callWebView loadRequest:[NSURLRequest requestWithURL:url]];
            } else if (buttonIndex == 1) {
            }
        } else {
            if (buttonIndex == 0) {
            }
        }
    }
}

@end
