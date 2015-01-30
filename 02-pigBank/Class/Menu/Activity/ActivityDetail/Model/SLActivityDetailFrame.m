//
//  SLActivityDetailFrame.m
//  02-pigBank
//
//  Created by 陆承东 on 15/1/22.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import "SLActivityDetailFrame.h"

#import "NSString+S_LINE.h"

@implementation SLActivityDetailFrame

- (void)setActivityDetail:(SLActivityDetail *)activityDetail
{
    _activityDetail = activityDetail;
    
    CGSize timeSize = [[NSString stringWithFormat:@"%@ 至 \n%@", activityDetail.startTimeStr, activityDetail.endTimeStr] sizeWithFont:SLFont16 maxSize:CGSizeMake(screenW - 44 - middleMargin, CGFLOAT_MAX)];
    _timeLabelHeight = timeSize.height;
    _timeHeight = timeSize.height + 12 + largeMargin;
    
    CGSize addressSize = [activityDetail.address sizeWithFont:SLFont16 maxSize:CGSizeMake(screenW - 88, CGFLOAT_MAX)];
    CGFloat tempAddressHeight = addressSize.height + largeMargin;
    _addressHeight = tempAddressHeight < 44 ? 44 : tempAddressHeight;
}

@end
