//
//  SLServiceAreaCoverView.m
//  02-pigBank
//
//  Created by 陆承东 on 14-10-17.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLServiceAreaCoverView.h"

#import "SLOutletsServiceArea.h"
#import "SLChildrenAreaList.h"

#import "MJExtension.h"

@interface SLServiceAreaCoverView () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, weak) UITableView *tableViewSmall;

@property (nonatomic, strong) NSArray *childrenAreaListArray;

@end

@implementation SLServiceAreaCoverView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = SLColorRGBA(0, 0, 0, 0.5);
        
        /** serviceAreaButton 服务项目 */
        UITableView *tableView = [[UITableView alloc] init];
        [self addSubview:tableView];
        self.tableView = tableView;
        tableView.tag = 1;
        tableView.delegate = self;
        tableView.alpha = 1;
        tableView.dataSource = self;
        
        /** serviceItemButton 服务项目 */
        UITableView *tableViewSmall = [[UITableView alloc] init];
        [self addSubview:tableViewSmall];
        self.tableViewSmall = tableViewSmall;
        tableViewSmall.tag = 2;
        tableViewSmall.delegate = self;
        tableViewSmall.alpha = 1;
        tableViewSmall.dataSource = self;
        tableViewSmall.frame = CGRectMake([UIScreen mainScreen].bounds.size.width * 0.4, 0, [UIScreen mainScreen].bounds.size.width * 0.6, 220);
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 1) {
        return (self.serviceAreaArray.count + 1);
    } else {
        if (self.childrenAreaListArray == nil) {
            return 1;
        };
        return self.childrenAreaListArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"SLServiceAreaCoverView";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    if (tableView.tag == 1) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"所有区域";
        } else {
            SLOutletsServiceArea *serviceArea = self.serviceAreaArray[(indexPath.row - 1)];
            cell.textLabel.text = serviceArea.areaName;
        }
    } else if (tableView.tag == 2) {
        if (self.childrenAreaListArray == nil) {
            cell.textLabel.text = @"所有区域";
        } else {
            SLChildrenAreaList *childrenAreaList = self.childrenAreaListArray[indexPath.row];
            cell.textLabel.text = childrenAreaList.areaName;
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 1) {
        if (indexPath.row == 0) {
            NSArray *childrenAreaListArray = nil;
            self.childrenAreaListArray = childrenAreaListArray;
        } else {
            SLOutletsServiceArea *serviceArea = self.serviceAreaArray[(indexPath.row - 1)];
            NSArray *childAreaListArray = [SLChildrenAreaList objectArrayWithKeyValuesArray:serviceArea.childrenAreaList];
            self.childrenAreaListArray = childAreaListArray;
        }
    } else {
        if (self.childrenAreaListArray == nil) {
            if ([self.delegate respondsToSelector:@selector(serviceAreaCoverView:didSelectedChildrenArea:)]) {
                [self.delegate serviceAreaCoverView:self didSelectedChildrenArea:nil];
            }
        } else {
            SLChildrenAreaList *childrenArea = self.childrenAreaListArray[(indexPath.row)];
            if ([self.delegate respondsToSelector:@selector(serviceAreaCoverView:didSelectedChildrenArea:)]) {
                [self.delegate serviceAreaCoverView:self didSelectedChildrenArea:childrenArea];
            }
        }
    }
}

- (void)setChildrenAreaListArray:(NSArray *)childrenAreaListArray
{
    _childrenAreaListArray = childrenAreaListArray;
    
    [self.tableViewSmall reloadData];
}

- (void)setServiceAreaArray:(NSArray *)serviceAreaArray
{
    _serviceAreaArray = serviceAreaArray;
    
    if (self.tableView) {
        CGFloat height = heightForCell * (serviceAreaArray.count + 1);
        if (height > 220) {
            height = 220;
        }
        self.tableView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width * 0.4, height);
    }
    
    [self.tableView reloadData];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{}
@end
