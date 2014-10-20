//
//  SLServiceItemCoverView.m
//  02-pigBank
//
//  Created by 陆承东 on 14-10-17.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLServiceItemCoverView.h"

#import "SLOutletsServiceItem.h"

@interface SLServiceItemCoverView () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UITableView *tableView;

@end

@implementation SLServiceItemCoverView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = SLColorRGBA(0, 0, 0, 0.5);
        
        /** serviceItemButton 服务项目 */
        UITableView *tableView = [[UITableView alloc] init];
        [self addSubview:tableView];
        self.tableView = tableView;
        tableView.delegate = self;
        tableView.alpha = 1;
        tableView.dataSource = self;
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (self.serviceItemArray.count + 1);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"所有项目";
    } else {
        SLOutletsServiceItem *serviceItem = self.serviceItemArray[(indexPath.row - 1)];
        cell.textLabel.text = serviceItem.dataText;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        if ([self.delegate respondsToSelector:@selector(serviceItemCoverView:didSelectedServiceItem:)]) {
            [self.delegate serviceItemCoverView:self didSelectedServiceItem:nil];
        }
    } else {
        SLOutletsServiceItem *serviceItem = self.serviceItemArray[(indexPath.row - 1)];
        if ([self.delegate respondsToSelector:@selector(serviceItemCoverView:didSelectedServiceItem:)]) {
            [self.delegate serviceItemCoverView:self didSelectedServiceItem:serviceItem];
        }
    }
}

- (void)setServiceItemArray:(NSArray *)serviceItemArray
{
    _serviceItemArray = serviceItemArray;
    
    
    CGFloat height = heightForCell * (serviceItemArray.count + 1);
    if (height > 220) {
        height = 220;
    }
    _tableView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, height);
    
    [self.tableView reloadData];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{}
@end
