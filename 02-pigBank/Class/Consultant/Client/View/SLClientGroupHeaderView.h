//
//  SLClientGroupHeaderView.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/19.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SLClientGroup.h"

@class SLClientGroupHeaderView;

@protocol SLClientGroupHeaderViewDegegate <NSObject>

@optional
- (void)clientGroupHeaderViewDidClickTitleButton:(SLClientGroupHeaderView *)clientGroupHeaderView;

@end

@interface SLClientGroupHeaderView : UITableViewHeaderFooterView

+ (SLClientGroupHeaderView *)headerViewWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) SLClientGroup *clientGroup;

@property (nonatomic, weak) id<SLClientGroupHeaderViewDegegate> delegate;

@end
