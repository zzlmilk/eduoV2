//
//  SLClientTagHeaderView.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/20.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SLClientTag.h"

@class SLClientTagHeaderView;

@protocol SLClientTagHeaderViewDegegate <NSObject>

@optional
- (void)clientTagHeaderViewDidClickTitleButton:(SLClientTagHeaderView *)clientTagHeaderView;

@end

@interface SLClientTagHeaderView : UITableViewHeaderFooterView

+ (SLClientTagHeaderView *)headerViewWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) SLClientTag *clientTag;

@property (nonatomic, weak) id<SLClientTagHeaderViewDegegate> delegate;

@end
