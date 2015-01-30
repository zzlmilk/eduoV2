//
//  SLSubscribeList.h
//  02-pigBank
//
//  Created by 陆承东 on 15/1/23.
//  Copyright (c) 2015年 陆承东. All rights reserved.
//

/*
 {
 content = "<p>\U7559\U5b66\U53ef\U4ee5\U5230\U6d77\U6d0b\U5b66\U6821\U89c2\U770b\U554a1</p>";
 insertTime = 1421750157089;
 insertUser = 1;
 labelName = "\U7559\U5b66";
 pictureSmallUrl = "";
 pictureUrl = "http://localhost:8080/vipJn/img/c4ccb52a-aebf-4c0e-9123-21899f29bd79.jpg";
 siId = 4;
 slId = 3;
 status = 1;
 title = "\U7559\U5b66\U6d4b\U8bd51";
 updateTime = 1421751425116;
 updater = 1;
 }
 */

#import <Foundation/Foundation.h>

@interface SLSubscribeList : NSObject

@property (nonatomic, copy) NSString *content;
@property (nonatomic, strong) NSNumber *insertTime;
@property (nonatomic, strong) NSNumber *insertUser;
@property (nonatomic, copy) NSString *labelName;
@property (nonatomic, copy) NSString *pictureSmallUrl;
@property (nonatomic, copy) NSString *pictureUrl;
@property (nonatomic, strong) NSNumber *siId;
@property (nonatomic, strong) NSNumber *slId;
@property (nonatomic, strong) NSNumber *status;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSNumber *updateTime;
@property (nonatomic, strong) NSNumber *updater;

@end
