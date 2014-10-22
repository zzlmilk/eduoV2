//
//  SLMerchantAreaCoverView.m
//  02-pigBank
//
//  Created by 陆承东 on 14/10/21.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLMerchantAreaCoverView.h"

#import "MJExtension.h"

@interface SLMerchantAreaCoverView () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UITableView *bigAreaTable;

@property (nonatomic, weak) UITableView *detailAreaTable;

@property (nonatomic, strong) NSArray *childrenAreaListArray;

@end

@implementation SLMerchantAreaCoverView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = SLColorRGBA(0, 0, 0, 0.5);
        
        /** bigAreaTable */
        UITableView *bigAreaTable = [[UITableView alloc] init];
        [self addSubview:bigAreaTable];
        self.bigAreaTable = bigAreaTable;
        bigAreaTable.tag = 1;
        bigAreaTable.delegate = self;
        bigAreaTable.alpha = 1;
        bigAreaTable.dataSource = self;
        bigAreaTable.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width * 0.4, 220);
        
        /** detailAreaTable */
        UITableView *detailAreaTable = [[UITableView alloc] init];
        [self addSubview:detailAreaTable];
        self.detailAreaTable = detailAreaTable;
        detailAreaTable.tag = 2;
        detailAreaTable.delegate = self;
        detailAreaTable.alpha = 1;
        detailAreaTable.dataSource = self;
        detailAreaTable.frame = CGRectMake([UIScreen mainScreen].bounds.size.width * 0.4, 0, [UIScreen mainScreen].bounds.size.width * 0.6, 220);
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 1) {
        return (self.merchantChildAreaArray.count + 1);
    } else {
        if (self.childrenAreaListArray == nil) {
            return 1;
        };
        return self.childrenAreaListArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    if (tableView.tag == 1) {
        static NSString *ID = @"bigArea";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        
        if (indexPath.row == 0) {
            cell.textLabel.text = @"全部区域";
        } else {
            SLChildrenArea *childrenArea = self.merchantChildAreaArray[(indexPath.row - 1)];
            cell.textLabel.text = childrenArea.areaName;
        }
        
        return cell;
    } else if (tableView.tag == 2) {
        static NSString *ID = @"detialArea";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        
        if (self.childrenAreaListArray == nil) {
            cell.textLabel.text = @"区域";
        } else {
            SLChildrenArea *childrenArea = self.childrenAreaListArray[indexPath.row];
            cell.textLabel.text = childrenArea.areaName;
        }
        return cell;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 1) {
        if (indexPath.row == 0) {
            NSArray *childrenAreaListArray = nil;
            self.childrenAreaListArray = childrenAreaListArray;
        } else {
            SLChildrenArea *childrenArea = self.merchantChildAreaArray[(indexPath.row - 1)];
            NSArray *childrenAreaListArray = [SLChildrenArea objectArrayWithKeyValuesArray:childrenArea.childrenAreaList];
            self.childrenAreaListArray = childrenAreaListArray;
        }
    } else {
        if (self.childrenAreaListArray == nil) {
            if ([self.delegate respondsToSelector:@selector(merchantAreaCoverView:didSelectedChildrenArea:)]) {
                [self.delegate merchantAreaCoverView:self didSelectedChildrenArea:nil];
            }
        } else {
            SLChildrenArea *childrenArea = self.childrenAreaListArray[indexPath.row];
            if ([self.delegate respondsToSelector:@selector(merchantAreaCoverView:didSelectedChildrenArea:)]) {
                [self.delegate merchantAreaCoverView:self didSelectedChildrenArea:childrenArea];
            }
        }
    }
}

- (void)setChildrenAreaListArray:(NSArray *)childrenAreaListArray
{
    _childrenAreaListArray = childrenAreaListArray;
    
    [self.detailAreaTable reloadData];
}

- (void)setMerchantChildAreaArray:(NSArray *)merchantChildAreaArray
{
    _merchantChildAreaArray = merchantChildAreaArray;
    
    if (self.bigAreaTable) {
        CGFloat height = heightForCell * (merchantChildAreaArray.count + 1);
        if (height > 220) {
            height = 220;
        }
        self.bigAreaTable.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width * 0.4, height);
    }
    
    [self.bigAreaTable reloadData];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{}

@end
