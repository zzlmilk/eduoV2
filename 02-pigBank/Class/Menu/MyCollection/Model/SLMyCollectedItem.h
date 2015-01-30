//
//  SLMyCollectedItem.h
//  02-pigBank
//
//  Created by 陆承东 on 14/12/23.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLMyCollectedItem : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *imageURLStr;

@property (nonatomic, copy) NSString *urlstr;

@property (nonatomic, copy) NSString *tableViewStyle;

@property (nonatomic, strong) NSNumber *plateId;
@property (nonatomic, copy) NSString *plateType;

@property (nonatomic, assign) int tag;

@end
