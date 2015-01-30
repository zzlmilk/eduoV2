//
//  SLAddNewTagCoverView.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/26.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SLAddNewTagCoverView;

@protocol SLAddNewTagCoverViewDelagate <NSObject>

@optional
- (void)addNewTagCoverView:(SLAddNewTagCoverView *)addNewTagCoverView didClickedCancelButton:(UIButton *)cancelButton;
- (void)addNewTagCoverView:(SLAddNewTagCoverView *)addNewTagCoverView didClickedCommitButton:(UIButton *)commitButton withTagStr:(NSString *)tagStr;

@end

@interface SLAddNewTagCoverView : UIView

@property (nonatomic, weak) id<SLAddNewTagCoverViewDelagate> delegate;

@end
