//
//  SLAppDelegate.m
//  02-pigBank
//
//  Created by 陆承东 on 14-9-12.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MAMapKit/MAMapKit.h>

#import "SLAppDelegate.h"

#import "SLNewFeaturesController.h"
#import "SLLoginViewController.h"
#import "SLNavigationController.h"


@interface SLAppDelegate ()<CLLocationManagerDelegate>
{
    UINavigationController *_navController;
    CLLocationManager      *_locationmanager;
}

@end

@implementation SLAppDelegate

- (void)configureAPIKey
{
    [MAMapServices sharedServices].apiKey = @"5027080bd14f703009c1ac06f53d43b9";
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    if (iOS8) {
        
        [UIApplication sharedApplication].idleTimerDisabled = TRUE;
        
        _locationmanager = [[CLLocationManager alloc] init];
        [_locationmanager requestAlwaysAuthorization];        //NSLocationAlwaysUsageDescription
        [_locationmanager requestWhenInUseAuthorization];     //NSLocationWhenInUseDescription
        _locationmanager.delegate = self;
        
    }
    
    [self configureAPIKey];
    
    application.statusBarHidden = NO;
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor clearColor];
    
    NSString *key = @"CFBundleVersion";
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *lastVersion = [defaults stringForKey:key];
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    
    if ([currentVersion isEqualToString:lastVersion]) {
        
#warning ----- 跳转判断
        SLAccount *account = [SLAccountTool getAccount];
        if (account.token.length > 1) {
            
        }
        
        SLLoginViewController *loginvc = [[SLLoginViewController alloc] init];
        SLNavigationController *nav = [[SLNavigationController alloc] initWithRootViewController:loginvc];
        self.window.rootViewController = nav;
    } else {
        self.window.rootViewController = [[SLNewFeaturesController alloc] init];
        
        // 存储用户偏好设置
        [defaults setObject:currentVersion forKey:key];
        [defaults synchronize];
    }
    
    [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    SLLog(@"deviceToken : %@", deviceToken);
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    SLLog(@"error : %@", error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    SLLog(@"userInfo : %@", userInfo);
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
