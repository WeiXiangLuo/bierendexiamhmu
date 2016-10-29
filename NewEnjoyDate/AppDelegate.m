//
//  AppDelegate.m
//  NewEnjoyDate
//
//  Created by XWQ on 16/10/27.
//  Copyright © 2016年 Dangerous. All rights reserved.
//

#import "AppDelegate.h"
#import "RDVTabBarController.h"
#import "RDVTabBar.h"
#import "RDVTabBarItem.h"
#import "HomeTabBarViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    HomeTabBarViewController *tabBarVc = [[HomeTabBarViewController alloc] init];
    self.window.rootViewController = tabBarVc;

    [self.window makeKeyAndVisible];
    
    return YES;
}




@end
