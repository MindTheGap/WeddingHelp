//
//  WeddingHelpAppDelegate.m
//  WeddingHelp
//
//  Created by MTG on 1/9/14.
//  Copyright (c) 2014 MTG. All rights reserved.
//

#import "WeddingHelpAppDelegate.h"
#import "MainWindowNewUser.h"
#import "MFSideMenu.h"

@implementation WeddingHelpAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.commManager = [[CommManager alloc] init];
    
    UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"iPhone5Storyboard"
                                                  bundle:nil];
    UIViewController* vc = [sb instantiateViewControllerWithIdentifier:@"StartupNavigationController"];
//    [self.window setRootViewController:vc];
    
    UITableViewController *sideMenu = [sb instantiateViewControllerWithIdentifier:@"SideMenuTableViewController"];
    
    
    self.container = [MFSideMenuContainerViewController
                                                    containerWithCenterViewController:vc
                                                    leftMenuViewController:sideMenu
                                                    rightMenuViewController:nil];
    self.container.panMode = MFSideMenuPanModeCenterViewController | MFSideMenuPanModeSideMenu;
    [self.container setMenuSlideAnimationEnabled:YES];
    [self.container setMenuSlideAnimationFactor:3.0f];
    
    self.window.rootViewController = self.container;
    [self.window makeKeyAndVisible];
    
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [self setEmail:@"cavnery@gmail.com"];
    
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
