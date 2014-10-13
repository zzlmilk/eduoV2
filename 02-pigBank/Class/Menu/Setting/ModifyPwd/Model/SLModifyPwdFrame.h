//
//  SLModifyPwdFrame.h
//  02-pigBank
//
//  Created by 陆承东 on 14-9-26.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SLFont14 [UIFont systemFontOfSize:14]

@interface SLModifyPwdFrame : NSObject

@property (nonatomic, assign) int login;

/** bjViewF  */
@property (nonatomic, assign, readonly) CGRect bjViewF;
/** topLineF  */
@property (nonatomic, assign, readonly) CGRect topLineViewF;
/** pwdLeftImageViewF */
@property (nonatomic, assign, readonly) CGRect oldPwdLeftImageViewF;
/** pwdTextFieldF */
@property (nonatomic, assign, readonly) CGRect oldPwdTextFieldF;
/** middleUpLineViewF */
@property (nonatomic, assign, readonly) CGRect middleUpLineViewF;
/** freshMobileLeftImageViewF */
@property (nonatomic, assign, readonly) CGRect freshPwdLeftImageViewF;
/** freshMobileTextFieldF */
@property (nonatomic, assign, readonly) CGRect freshPwdTextFieldF;
/** middleDownLineViewF */
@property (nonatomic, assign, readonly) CGRect middleDownLineViewF;
/** captchaLeftImageViewF */
@property (nonatomic, assign, readonly) CGRect reFreshPwdLeftImageViewF;
/** captchaTextFieldF */
@property (nonatomic, assign, readonly) CGRect reFreshPwdTextFieldF;
/** bottomLineViewF  */
@property (nonatomic, assign, readonly) CGRect bottomLineViewF;
/** sureButtonF  */
@property (nonatomic, assign, readonly) CGRect sureButtonF;

@end
