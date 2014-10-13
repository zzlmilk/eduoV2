//
//  SLChangeMyMobileFrame.h
//  02-pigBank
//
//  Created by 陆承东 on 14-9-26.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SLFont14 [UIFont systemFontOfSize:14]

@interface SLChangeMyMobileFrame : NSObject

@property (nonatomic, assign) int login;

/** bjViewF  */
@property (nonatomic, assign, readonly) CGRect bjViewF;
/** topLineF  */
@property (nonatomic, assign, readonly) CGRect topLineViewF;
/** pwdLeftImageViewF */
@property (nonatomic, assign, readonly) CGRect pwdLeftImageViewF;
/** pwdTextFieldF */
@property (nonatomic, assign, readonly) CGRect pwdTextFieldF;
/** middleUpLineViewF */
@property (nonatomic, assign, readonly) CGRect middleUpLineViewF;
/** freshMobileLeftImageViewF */
@property (nonatomic, assign, readonly) CGRect freshMobileLeftImageViewF;
/** freshMobileTextFieldF */
@property (nonatomic, assign, readonly) CGRect freshMobileTextFieldF;
/** middleDownLineViewF */
@property (nonatomic, assign, readonly) CGRect middleDownLineViewF;
/** captchaLeftImageViewF */
@property (nonatomic, assign, readonly) CGRect captchaLeftImageViewF;
/** captchaTextFieldF */
@property (nonatomic, assign, readonly) CGRect captchaTextFieldF;
/** getCaptchaButtonF */
@property (nonatomic, assign, readonly) CGRect getCaptchaButtonF;
/** bottomLineViewF  */
@property (nonatomic, assign, readonly) CGRect bottomLineViewF;
/** sureButtonF  */
@property (nonatomic, assign, readonly) CGRect sureButtonF;


@end
