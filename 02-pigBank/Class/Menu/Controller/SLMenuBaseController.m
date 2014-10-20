//
//  SLMenuBaseController.m
//  02-pigBank
//
//  Created by 陆承东 on 14-10-15.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLMenuBaseController.h"

#import "SLMenuGroup.h"

#import "SLMenuCell.h"

@interface SLMenuBaseController ()

@end

@implementation SLMenuBaseController

- (NSMutableArray *)menuGroups
{
    if (_menuGroups == nil) {
        _menuGroups = [NSMutableArray array];
    }
    return _menuGroups;
}

- (SLMenuGroup *)addGroup
{
    SLMenuGroup *group = [[SLMenuGroup alloc] init];
    [self.menuGroups addObject:group];
    return group;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.menuGroups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    SLMenuGroup *menuGroup = self.menuGroups[section];
    
    return menuGroup.menuItems.count;
}





@end
