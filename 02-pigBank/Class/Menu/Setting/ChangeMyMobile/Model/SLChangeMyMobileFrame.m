//
//  SLChangeMyMobileFrame.m
//  02-pigBank
//
//  Created by 陆承东 on 14-9-26.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLChangeMyMobileFrame.h"

#define margin 10
#define smallMargin 5
#define leftViewW 40
#define rowHeight 60

@implementation SLChangeMyMobileFrame

- (void)setLogin:(int)login
{
    _login = login;
    
    /** bjViewF  */
    CGFloat bjViewX = 0;
//    CGFloat bjViewY = margin * 3 + 64;
    CGFloat bjViewY = 64;
    CGFloat bjViewW = [UIScreen mainScreen].bounds.size.width;
    
    /** topLineViewF  */
    CGFloat topLineViewX = 0;
    CGFloat topLineViewY = 0;
    CGFloat topLineViewW = bjViewW;
    CGFloat topLineViewH = 1;
    _topLineViewF = CGRectMake(topLineViewX, topLineViewY, topLineViewW, topLineViewH);
    
    /** pwdLeftImageViewF */
    CGFloat pwdLeftImageViewX = smallMargin;
    CGFloat pwdLeftImageViewY = CGRectGetMaxY(_topLineViewF);
    CGFloat pwdLeftImageViewW = leftViewW;
    CGFloat pwdLeftImageViewH = rowHeight;
    _pwdLeftImageViewF = CGRectMake(pwdLeftImageViewX, pwdLeftImageViewY, pwdLeftImageViewW, pwdLeftImageViewH);
    
    /** pwdTextFieldF */
    CGFloat pwdTextFieldX = CGRectGetMaxX(_pwdLeftImageViewF);
    CGFloat pwdTextFieldY = pwdLeftImageViewY;
    CGFloat pwdTextFieldW = bjViewW - margin - pwdLeftImageViewX;
    CGFloat pwdTextFieldH = rowHeight;
    _pwdTextFieldF = CGRectMake(pwdTextFieldX, pwdTextFieldY, pwdTextFieldW, pwdTextFieldH);
    
    /** middleUpLineViewF */
    CGFloat middleUpLineViewX = margin * 1.5;
    CGFloat middleUpLineViewY = CGRectGetMaxY(_pwdTextFieldF);
    CGFloat middleUpLineViewW = bjViewW - middleUpLineViewX;
    CGFloat middleUpLineViewH = 1;
    _middleUpLineViewF = CGRectMake(middleUpLineViewX, middleUpLineViewY, middleUpLineViewW, middleUpLineViewH);
    
    /** freshMobileLeftImageViewF */
    CGFloat freshMobileLeftImageViewX = smallMargin;
    CGFloat freshMobileLeftImageViewY = CGRectGetMaxY(_middleUpLineViewF);
    CGFloat freshMobileLeftImageViewW = leftViewW;
    CGFloat freshMobileLeftImageViewH = rowHeight;
    _freshMobileLeftImageViewF = CGRectMake(freshMobileLeftImageViewX, freshMobileLeftImageViewY, freshMobileLeftImageViewW, freshMobileLeftImageViewH);
    
    /** freshMobileTextFieldF */
    CGFloat freshMobileTextFieldX = CGRectGetMaxX(_freshMobileLeftImageViewF);
    CGFloat freshMobileTextFieldY = freshMobileLeftImageViewY;
    CGFloat freshMobileTextFieldW = bjViewW - margin - freshMobileTextFieldX;
    CGFloat freshMobileTextFieldH = rowHeight;
    _freshMobileTextFieldF = CGRectMake(freshMobileTextFieldX, freshMobileTextFieldY, freshMobileTextFieldW, freshMobileTextFieldH);
    
    /** middleDownLineViewF */
    CGFloat middleDownLineViewX = margin * 1.5;
    CGFloat middleDownLineViewY = CGRectGetMaxY(_freshMobileTextFieldF);
    CGFloat middleDownLineViewW = bjViewW - middleDownLineViewX;
    CGFloat middleDownLineViewH = 1;
    _middleDownLineViewF = CGRectMake(middleDownLineViewX, middleDownLineViewY, middleDownLineViewW, middleDownLineViewH);
    
    /** captchaLeftImageViewF */
    CGFloat captchaLeftImageViewX = smallMargin;
    CGFloat captchaLeftImageViewY = CGRectGetMaxY(_middleDownLineViewF);
    CGFloat captchaLeftImageViewW = leftViewW;
    CGFloat captchaLeftImageViewH = rowHeight;
    _captchaLeftImageViewF = CGRectMake(captchaLeftImageViewX, captchaLeftImageViewY, captchaLeftImageViewW, captchaLeftImageViewH);
    
    /** captchaTextFieldF */
    CGFloat captchaTextFieldX = CGRectGetMaxX(_freshMobileLeftImageViewF);
    CGFloat captchaTextFieldY = captchaLeftImageViewY;
    CGFloat captchaTextFieldW = 100;
    CGFloat captchaTextFieldH = rowHeight;
    _captchaTextFieldF = CGRectMake(captchaTextFieldX, captchaTextFieldY, captchaTextFieldW, captchaTextFieldH);
    
    /** getCaptchaButtonF */
    CGFloat getCaptchaButtonY = captchaTextFieldY + (rowHeight - 28) / 2;
    CGFloat getCaptchaButtonW = 81;
    CGFloat getCaptchaButtonH = 28;
    CGFloat getCaptchaButtonX = bjViewW - margin - getCaptchaButtonW;
    _getCaptchaButtonF = CGRectMake(getCaptchaButtonX, getCaptchaButtonY, getCaptchaButtonW, getCaptchaButtonH);
    
    /** bottomLineViewF  */
    CGFloat bottomLineViewX = 0;
    CGFloat bottomLineViewY = CGRectGetMaxY(_captchaTextFieldF);
    CGFloat bottomLineViewW = bjViewW;
    CGFloat bottomLineViewH = 1;
    _bottomLineViewF = CGRectMake(bottomLineViewX, bottomLineViewY, bottomLineViewW, bottomLineViewH);
    
    CGFloat bjViewH = CGRectGetMaxY(_bottomLineViewF);
    _bjViewF = CGRectMake(bjViewX, bjViewY, bjViewW, bjViewH);
    
    /** sureButtonF  */
    CGFloat sureButtonW = 269;
    CGFloat sureButtonH = 44;
    CGFloat sureButtonX = (bjViewW - sureButtonW) / 2;
    CGFloat sureButtonY = ([UIScreen mainScreen].bounds.size.height - CGRectGetMaxY(_bjViewF) - sureButtonH) / 2 + CGRectGetMaxY(_bjViewF);
    _sureButtonF = CGRectMake(sureButtonX, sureButtonY, sureButtonW, sureButtonH);
}

@end
