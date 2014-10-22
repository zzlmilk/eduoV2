//
//  SLMyCollectionController.h
//  02-pigBank
//
//  Created by 陆承东 on 14/10/21.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

/*
 /material/listCollectMaterial
 
 plateId	Long	板块ID，必填
 pageSize	Integer	分页大小，默认20，传入-99则不对pageSize做限制
 
 pageSize	Integer	分页大小，默认20，传入-99则不对pageSize做限制
 curPage	Integer	当前页，从1开始，默认1
 uid	Integer	当前登录用户UID
 token	String	当前登录用户身份识别码（登陆、注册接口返回该值）

 */

#import <UIKit/UIKit.h>

@interface SLMyCollectionController : UITableViewController

@end
