//
//  SLActivityListCellFrame.m
//  02-pigBank
//
//  Created by 陆承东 on 15/1/20.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import "SLActivityListCellFrame.h"

@implementation SLActivityListCellFrame

- (void)setActivityList:(SLActivityList *)activityList
{
    _activityList = activityList;
    
    CGFloat activityStatusLabelX = middleMargin;
    CGFloat activityStatusLabelY = middleMargin;
    CGFloat activityStatusLabelW = 40;
    CGFloat activityStatusLabelH = 14;
    _activityStatusLabelF = CGRectMake(activityStatusLabelX, activityStatusLabelY, activityStatusLabelW, activityStatusLabelH);
    
    CGFloat nameLabelX = CGRectGetMaxX(_activityStatusLabelF) + smallMargin;
    CGFloat nameLabelY = activityStatusLabelY;
    CGFloat nameLabelW = screenW - nameLabelX - middleMargin;
    CGFloat nameLabelH = 14;
    _nameLabelF = CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    
    CGFloat addressLabelX = activityStatusLabelX;
    CGFloat addressLabelY = CGRectGetMaxY(_activityStatusLabelF) + smallMargin;
    CGFloat addressLabelW = screenW - addressLabelX - middleMargin;
    CGFloat addressLabelH = 14;
    _addressLabelF = CGRectMake(addressLabelX, addressLabelY, addressLabelW, addressLabelH);
    
    CGFloat timeLabelX = addressLabelX;
    CGFloat timeLabelY = CGRectGetMaxY(_addressLabelF) + smallMargin;
    CGFloat timeLabelW = 150;
    CGFloat timeLabelH = 14;
    _timeLabelF = CGRectMake(timeLabelX, timeLabelY, timeLabelW, timeLabelH);
    
    CGFloat myJoinStatusLabelX = CGRectGetMaxX(_timeLabelF) + smallMargin;
    CGFloat myJoinStatusLabelY = timeLabelY;
    CGFloat myJoinStatusLabelW = 40;
    CGFloat myJoinStatusLabelH = 14;
    _myJoinStatusLabelF = CGRectMake(myJoinStatusLabelX, myJoinStatusLabelY, myJoinStatusLabelW, myJoinStatusLabelH);
}

@end
