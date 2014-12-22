//
//  REXCommonFunctions.h
//  BankYiDou
//
//  Created by zzlmilk on 14-6-3.
//  Copyright (c) 2014年 zzlmilk. All rights reserved.
//

#import <Foundation/Foundation.h>


#ifndef REXUIKitIsFlatMode
#define REXUIKitIsFlatMode() REXSideMenuUIKitIsFlatMode()
#endif

#ifndef kCFCoreFoundationVersionNumber_iOS_6_1
#define kCFCoreFoundationVersionNumber_iOS_6_1 793.00
#endif

#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1
#define IF_IOS7_OR_GREATER(...) \
if (kCFCoreFoundationVersionNumber > kCFCoreFoundationVersionNumber_iOS_6_1) \
{ \
__VA_ARGS__ \
}
#else
#define IF_IOS7_OR_GREATER(...)
#endif

BOOL REXSideMenuUIKitIsFlatMode(void);