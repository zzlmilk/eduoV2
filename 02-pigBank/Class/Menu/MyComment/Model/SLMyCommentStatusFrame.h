//
//  SLMyCommentStatusFrame.h
//  02-pigBank
//
//  Created by 陆承东 on 14/12/13.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SLMyCommentStatus.h"

@interface SLMyCommentStatusFrame : NSObject

@property (nonatomic, strong) SLMyCommentStatus *myCommentStatus;

@property (nonatomic, assign, readonly) CGRect iconImageViewF;

@property (nonatomic, assign, readonly) CGRect merchantNameLabelF;

@property (nonatomic, assign, readonly) CGRect accessoryImageViewF;

@property (nonatomic, assign, readonly) CGRect separatorImageViewF;

@property (nonatomic, assign, readonly) CGFloat cellHeight;

@property (nonatomic, assign, readonly) CGRect myCommentLabelF;

@property (nonatomic, strong, readonly) NSMutableArray *scoreImageViewFs;

@property (nonatomic, assign, readonly) CGRect dateLabelF;

@property (nonatomic, assign, readonly) CGRect sectionFootViewF;

@property (nonatomic, assign, readonly) CGRect separatorF;

@property (nonatomic, assign, readonly) CGFloat sectionHeight;

@end
