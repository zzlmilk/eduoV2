//
//  SLModifyPwdFrame.m
//  02-pigBank
//
//  Created by 陆承东 on 14-9-26.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLModifyPwdFrame.h"

#define margin 10
#define smallMargin 5
#define leftViewW 40
#define rowHeight 60

@implementation SLModifyPwdFrame

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
    
    /** oldPwdLeftImageViewF */
    CGFloat oldPwdLeftImageViewX = smallMargin;
    CGFloat oldPwdLeftImageViewY = CGRectGetMaxY(_topLineViewF);
    CGFloat oldPwdLeftImageViewW = leftViewW;
    CGFloat oldPwdLeftImageViewH = rowHeight;
    _oldPwdLeftImageViewF = CGRectMake(oldPwdLeftImageViewX, oldPwdLeftImageViewY, oldPwdLeftImageViewW, oldPwdLeftImageViewH);
    
    /** oldPwdTextFieldF */
    CGFloat oldPwdTextFieldX = CGRectGetMaxX(_oldPwdLeftImageViewF);
    CGFloat oldPwdTextFieldY = oldPwdLeftImageViewY;
    CGFloat oldPwdTextFieldW = bjViewW - margin - oldPwdLeftImageViewX;
    CGFloat oldPwdTextFieldH = rowHeight;
    _oldPwdTextFieldF = CGRectMake(oldPwdTextFieldX, oldPwdTextFieldY, oldPwdTextFieldW, oldPwdTextFieldH);
    
    /** middleUpLineViewF */
    CGFloat middleUpLineViewX = margin * 1.5;
    CGFloat middleUpLineViewY = CGRectGetMaxY(_oldPwdTextFieldF);
    CGFloat middleUpLineViewW = bjViewW - middleUpLineViewX;
    CGFloat middleUpLineViewH = 1;
    _middleUpLineViewF = CGRectMake(middleUpLineViewX, middleUpLineViewY, middleUpLineViewW, middleUpLineViewH);
    
    /** freshPwdLeftImageViewF */
    CGFloat freshPwdLeftImageViewX = smallMargin;
    CGFloat freshPwdLeftImageViewY = CGRectGetMaxY(_middleUpLineViewF);
    CGFloat freshPwdLeftImageViewW = leftViewW;
    CGFloat freshPwdLeftImageViewH = rowHeight;
    _freshPwdLeftImageViewF = CGRectMake(freshPwdLeftImageViewX, freshPwdLeftImageViewY, freshPwdLeftImageViewW, freshPwdLeftImageViewH);
    
    /** freshPwdTextFieldF */
    CGFloat freshPwdTextFieldX = CGRectGetMaxX(_freshPwdLeftImageViewF);
    CGFloat freshPwdTextFieldY = freshPwdLeftImageViewY;
    CGFloat freshPwdTextFieldW = bjViewW - margin - freshPwdTextFieldX;
    CGFloat freshPwdTextFieldH = rowHeight;
    _freshPwdTextFieldF = CGRectMake(freshPwdTextFieldX, freshPwdTextFieldY, freshPwdTextFieldW, freshPwdTextFieldH);
    
    /** middleDownLineViewF */
    CGFloat middleDownLineViewX = margin * 1.5;
    CGFloat middleDownLineViewY = CGRectGetMaxY(_freshPwdTextFieldF);
    CGFloat middleDownLineViewW = bjViewW - middleDownLineViewX;
    CGFloat middleDownLineViewH = 1;
    _middleDownLineViewF = CGRectMake(middleDownLineViewX, middleDownLineViewY, middleDownLineViewW, middleDownLineViewH);
    
    /** reFreshPwdLeftImageViewF */
    CGFloat reFreshPwdLeftImageViewX = smallMargin;
    CGFloat reFreshPwdLeftImageViewY = CGRectGetMaxY(_middleDownLineViewF);
    CGFloat reFreshPwdLeftImageViewW = leftViewW;
    CGFloat reFreshPwdLeftImageViewH = rowHeight;
    _reFreshPwdLeftImageViewF = CGRectMake(reFreshPwdLeftImageViewX, reFreshPwdLeftImageViewY, reFreshPwdLeftImageViewW, reFreshPwdLeftImageViewH);
    
    /** reFreshPwdTextFieldF */
    CGFloat reFreshPwdTextFieldX = CGRectGetMaxX(_freshPwdLeftImageViewF);
    CGFloat reFreshPwdTextFieldY = reFreshPwdLeftImageViewY;
    CGFloat reFreshPwdTextFieldW = 100;
    CGFloat reFreshPwdTextFieldH = rowHeight;
    _reFreshPwdTextFieldF = CGRectMake(reFreshPwdTextFieldX, reFreshPwdTextFieldY, reFreshPwdTextFieldW, reFreshPwdTextFieldH);
    
    /** bottomLineViewF  */
    CGFloat bottomLineViewX = 0;
    CGFloat bottomLineViewY = CGRectGetMaxY(_reFreshPwdTextFieldF);
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
