//
//  SLMerchantTypeCoverView.m
//  02-pigBank
//
//  Created by 陆承东 on 14/10/20.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLMerchantTypeCoverView.h"

#import "MJExtension.h"

@interface SLMerchantTypeCoverView() <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UITableView *bigTypeTable;

@property (nonatomic, weak) UITableView *detailTypeTable;

@property (nonatomic, strong) NSArray *childrenScopeListArray;

@end

@implementation SLMerchantTypeCoverView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = SLColorRGBA(0, 0, 0, 0.5);
        
        /** 大类型 */
        UITableView *bigTypeTable = [[UITableView alloc] init];
        [self addSubview:bigTypeTable];
        self.bigTypeTable = bigTypeTable;
        bigTypeTable.tag = 1;
        bigTypeTable.delegate = self;
        bigTypeTable.alpha = 1;
        bigTypeTable.dataSource = self;
        bigTypeTable.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width * 0.4, 220);
        
        /** serviceItemButton 服务项目 */
        UITableView *detailTypeTable = [[UITableView alloc] init];
        [self addSubview:detailTypeTable];
        self.detailTypeTable = detailTypeTable;
        detailTypeTable.tag = 2;
        detailTypeTable.delegate = self;
        detailTypeTable.alpha = 1;
        detailTypeTable.dataSource = self;
        detailTypeTable.frame = CGRectMake([UIScreen mainScreen].bounds.size.width * 0.4, 0, [UIScreen mainScreen].bounds.size.width * 0.6, 220);
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 1) {
        return (self.merchantChildScopeArray.count + 1);
    } else {
        if (self.childrenScopeListArray == nil) {
            return 1;
        };
        return self.childrenScopeListArray.count;
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
        static NSString *ID = @"bigType";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        cell.textLabel.font = SLFont16;
        
        if (indexPath.row == 0) {
            cell.textLabel.text = @"全部类型";
        } else {
            SLChildrenScope *childrenScope = self.merchantChildScopeArray[(indexPath.row - 1)];
            cell.textLabel.text = childrenScope.scopeName;
        }
        
        return cell;
    } else if (tableView.tag == 2) {
        static NSString *ID = @"detialType";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        cell.textLabel.font = SLFont16;
        
        if (self.childrenScopeListArray == nil) {
            cell.textLabel.text = @"全部类型";
        } else {
            SLChildrenScope *childrenScope = self.childrenScopeListArray[indexPath.row];
            cell.textLabel.text = childrenScope.scopeName;
        }
        return cell;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 1) {
        if (indexPath.row == 0) {
            NSArray *childrenScopeListArray = nil;
            self.childrenScopeListArray = childrenScopeListArray;
        } else {
            SLChildrenScope *childrenScope = self.merchantChildScopeArray[(indexPath.row - 1)];
            NSArray *childrenScopeListArray = [SLChildrenScope objectArrayWithKeyValuesArray:childrenScope.childrenScopeList];
            self.childrenScopeListArray = childrenScopeListArray;
        }
    } else {
        if (self.childrenScopeListArray == nil) {
            if ([self.delegate respondsToSelector:@selector(merchantTypeCoverView:didSelectedChildrenScope:)]) {
                [self.delegate merchantTypeCoverView:self didSelectedChildrenScope:nil];
            }
        } else {
            SLChildrenScope *childrenScope = self.childrenScopeListArray[indexPath.row];
            if ([self.delegate respondsToSelector:@selector(merchantTypeCoverView:didSelectedChildrenScope:)]) {
                [self.delegate merchantTypeCoverView:self didSelectedChildrenScope:childrenScope];
            }
        }
    }
}

- (void)setChildrenScopeListArray:(NSArray *)childrenScopeListArray
{
    _childrenScopeListArray = childrenScopeListArray;
    
    [self.detailTypeTable reloadData];
}

- (void)setMerchantChildScopeArray:(NSArray *)merchantChildScopeArray
{
    _merchantChildScopeArray = merchantChildScopeArray;
    
    if (self.bigTypeTable) {
        CGFloat height = heightForCell * (merchantChildScopeArray.count + 1);
        if (height > 220) {
            height = 220;
        }
        self.bigTypeTable.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width * 0.4, height);
    }
    
    [self.bigTypeTable reloadData];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([self.delegate respondsToSelector:@selector(merchantTypeCoverViewDidTouchCoverView:)]) {
        [self.delegate merchantTypeCoverViewDidTouchCoverView:self];
    }
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{}

@end
