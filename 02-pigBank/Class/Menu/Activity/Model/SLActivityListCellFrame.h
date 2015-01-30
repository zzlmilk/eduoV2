//
//  SLActivityListCellFrame.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/20.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

/*
 @property (nonatomic, weak) UILabel *activityStatusLabel;
 @property (nonatomic, weak) UILabel *nameLabel;
 @property (nonatomic, weak) UILabel *addressLabel;
 @property (nonatomic, weak) UILabel *timeLabel;
 @property (nonatomic, weak) UILabel *myJoinStatusLabel;
 */

#import <Foundation/Foundation.h>

#import "SLActivityList.h"

@interface SLActivityListCellFrame : NSObject

@property (nonatomic, assign) CGRect activityStatusLabelF;
@property (nonatomic, assign) CGRect nameLabelF;
@property (nonatomic, assign) CGRect addressLabelF;
@property (nonatomic, assign) CGRect timeLabelF;
@property (nonatomic, assign) CGRect myJoinStatusLabelF;

@property (nonatomic, strong) SLActivityList *activityList;

@end
