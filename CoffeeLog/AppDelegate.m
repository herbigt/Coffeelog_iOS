//
//  AppDelegate.m
//  CoffeeLog
//
//  Created by Philipp Waldhauer on 06.10.13.
//  Copyright (c) 2013 CoffeeLog. All rights reserved.
//

#import "AppDelegate.h"

#import "CoffeeModel.h"
#import "UserSettings.h"

#import "ListViewController.h"
#import "AddEditViewController.h"
#import "DetailViewController.h"
#import "SettingsViewController.h"
#import "VenueSearchViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[UserSettings defaultSettings] loadSettings];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    ListViewController *lvc = [[ListViewController alloc] initWithStyle:UITableViewStylePlain];

    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.tintColor = UIColorFromRGB(0xb57252);
    
    
    CoffeeModel *c1 = [[CoffeeModel alloc] init];
    c1.image = [UIImage imageNamed:@"testimage"];
    c1.name = @"Espresso Excelsior";
    c1.type = @"Espresso";
    c1.state = @"Roasted Beans";
    c1.store = @"Kafeee Koojntor";
    c1.price = 799;
    c1.weight = 250;
    c1.isFavorited = YES;
    
    DetailViewController *dvc = [[DetailViewController alloc] initWithCoffeeModel:c1];
    AddEditViewController *aevc = [[AddEditViewController alloc] initWithCoffeeModel:c1];
    SettingsViewController *svc = [[SettingsViewController alloc] init];
    
    VenueSearchViewController *vsvc = [[VenueSearchViewController alloc] init];
    
    UINavigationController *nv = [[UINavigationController alloc] initWithRootViewController:lvc];
    nv.navigationBar.tintColor = [UIColor whiteColor];
    
    nv.navigationBar.barTintColor = [UIColor colorWithRed:1 green:139/255.0 blue:0 alpha:0.65];
    nv.navigationBar.translucent = YES;
    
    [self.window setRootViewController:nv];
    
    
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
