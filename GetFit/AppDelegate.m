//
//  AppDelegate.m
//  GetFit
//
//  Created by Albert Carter on 12/3/14.
//  Copyright (c) 2014 CSAIL Big Data Initiative. All rights reserved.
//

#import "AppDelegate.h"
#import "PageVC.h"

#import "AboutVC.h"
#import "GraphVC.h"
#import "MinuteVC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    AboutVC *aboutVC = [[AboutVC alloc] init];
    GraphVC *graphVC = [[GraphVC alloc] init];
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = @[graphVC, aboutVC];
    
    self.window.rootViewController = tabBarController;
    self.window.backgroundColor = [UIColor whiteColor];
    
    // add plus button
    CGRect frame = [UIScreen mainScreen].bounds;
    CGRect rightFrame = CGRectMake(frame.size.width - 170, 10, 200, 40);
    UIButton *plusButton = [[UIButton alloc] initWithFrame:rightFrame];
    [plusButton setTitle:@"add minutes +" forState:UIControlStateNormal];
    [plusButton setTitleColor:[UIColor colorWithRed:0 green:0.478431 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
    [plusButton addTarget:self action:@selector(pushMinuteVC) forControlEvents:UIControlEventTouchUpInside];
    [self.window.rootViewController.view addSubview:plusButton];
    
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)pushMinuteVC {
    NSLog(@"PushMinuteVC Called");
    MinuteVC *minuteVC = [[MinuteVC alloc] initWithNibName:@"MinuteVC" bundle:nil];
    
//    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:];
    minuteVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    [self.window.rootViewController presentViewController:minuteVC animated:YES completion:nil];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
