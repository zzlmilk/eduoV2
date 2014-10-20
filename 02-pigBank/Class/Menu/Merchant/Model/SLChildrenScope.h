//
//  SLChildrenScope.h
//  02-pigBank
//
//  Created by 陆承东 on 14/10/20.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

/*
 {
 childrenScopeList =                 (
 {
 preScopeId = 1;
 scopeId = 4;
 scopeName = "\U827a\U672f";
 scopeSort = 1;
 },
 {
 preScopeId = 1;
 scopeId = 5;
 scopeName = "\U767e\U8d27";
 scopeSort = 2;
 }
 );
 scopeId = 1;
 scopeName = "\U8d2d\U7269";
 scopeSort = 1;
 },
 */

#import <Foundation/Foundation.h>

@interface SLChildrenScope : NSObject

@property (nonatomic, strong) NSArray *childrenScopeList;

@property (nonatomic, strong) NSNumber *scopeId;

@property (nonatomic, strong) NSNumber *scopeSort;

@property (nonatomic, copy) NSString *scopeName;

@end
