//
//  AppDelegate.m
//  JSSL
//
//  Created by LDY on 14-2-22.
//  Copyright (c) 2014年 DONLIU1987. All rights reserved.
//

#import "AppDelegate.h"
#import "BookrackViewController.h"
#import "QueryViewController.h"
#import "SettingsViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch. 
    self.window.backgroundColor = [UIColor lightGrayColor];

    //设置进入正式界面后，将状态栏显示出来
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    //让主线程暂停2秒，等待启动界面显示
//    [NSThread sleepForTimeInterval:1.0];
    
    BookrackViewController *bookrackVC = [[BookrackViewController alloc]init];
    bookrackVC.tabBarItem = [[[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemBookmarks tag:0] autorelease];
    bookrackVC.title = @"书架";
    QueryViewController *queryVC = [[QueryViewController alloc]init];
    queryVC.tabBarItem = [[[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemSearch tag:1] autorelease];
    queryVC.title = @"搜索";
    SettingsViewController *settingVC = [[SettingsViewController alloc] init];
    settingVC.tabBarItem = [[[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFavorites tag:2] autorelease];
    settingVC.title = @"设置";
    
    //存放viewcontroller的数组
    NSArray *vcArray = [[NSArray alloc] initWithObjects:bookrackVC,queryVC,settingVC, nil];
    
    UITabBarController *rootTBC = [[[UITabBarController alloc] init] autorelease];

    rootTBC.viewControllers = vcArray;
    
    self.window.rootViewController = rootTBC;
    
    [bookrackVC release];
    [queryVC release];
    [settingVC release];
    
    [self.window makeKeyAndVisible];
    return YES;
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
