//
//  SLHomeViewController.m
//  02-pigBank
//
//  Created by 陆承东 on 14-9-13.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLHomeViewController.h"
#import "UIBarButtonItem+SL.h"
#import "SLSearchController.h"
#import "SLSearchBar.h"
#import "SLNavigationController.h"

@interface SLHomeViewController ()

@end

@implementation SLHomeViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 设置导航栏
    [self setupNavBar];
    
    /*
     *  不可以设置高亮状态的图片
    UIImage *image = [UIImage imageNamed:@"iconSearch"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:nil action:nil];
    */

}

- (void)setupNavBar
{
    //    // 取出appearance
    //    UINavigationBar *navBar = [UINavigationBar appearance];
    
    UINavigationBar *navBar = self.navigationController.navigationBar;
    // 设置背景
    [navBar setBackgroundImage:[UIImage imageNamed:@"bjNavigationBarPurple"] forBarMetrics:UIBarMetricsDefault];
    
    NSMutableDictionary *attri = [NSMutableDictionary dictionary];
    attri[UITextAttributeTextColor] = [UIColor whiteColor];
    [navBar setTitleTextAttributes:attri];
    
    // 设置右上角的barButton
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"iconSearch" highlightImage:@"iconSearchPress" target:self action:@selector(find)];
    
    // 设置左上角的barButton
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"iconMore" highlightImage:@"iconMorePress" target:self action:@selector(more)];
}

- (void)more
{
    SLLog(@"more");
}

- (void)find
{
    SLSearchController *searchController = [[SLSearchController alloc] init];
//    [self.navigationController pushViewController:searchController animated:NO];
    
    SLNavigationController *nav = [[SLNavigationController alloc] initWithRootViewController:searchController];
    
    [self presentViewController:nav animated:YES completion:^{
        nil;
    }];
}

- (void)textClick:(UIButton *)button
{
    self.tabBarItem.badgeValue = @"111";
    self.tabBarItem.title = @"猪子";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = @"哈哈";
    
    // Configure the cell...
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *vc = [[UIViewController alloc] init];
    
    vc.view.backgroundColor = [UIColor redColor];
    
    [self.navigationController pushViewController:vc animated:YES];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
