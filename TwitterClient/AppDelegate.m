//
//  AppDelegate.m
//  TwitterClient
//
//  Created by Ramasamy Dayanand on 11/4/15.
//  Copyright © 2015 Dayanand Ramasamy. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "TweetsViewController.h"
#import "HamburgerViewController.h"
//#import "MenuViewController.h"
#import "TwitterClient.h"
#import "User.h"
#import "Tweet.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    User *user = [User currentUser];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userDidLogout) name:UserDidLogoutNotification object:nil];
//    
//    if(user != nil){
//        NSLog(@"Welcome User:%@", user.name);
//        TweetsViewController *twc = [[TweetsViewController alloc] init];
//        UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:twc];
//
//        self.window.rootViewController =  nvc;
//        
//    }else{
//        NSLog(@"User is logged out");
//        self.window.rootViewController = [[LoginViewController alloc] init];
//    }
    
    HamburgerViewController *hamburgerViewController = [[HamburgerViewController alloc] init];
    self.window.rootViewController = hamburgerViewController;
    MenuViewController *menuViewController = [[MenuViewController alloc] initWithMenu];
    menuViewController.hamburgerController = hamburgerViewController;
    hamburgerViewController.menuViewController = menuViewController;

    
    
    [self.window makeKeyAndVisible];
    return YES;
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

-(BOOL)application:(UIApplication *)application openURL:(nonnull NSURL *)url options:(nonnull NSDictionary<NSString *,id> *)options{
    
    [[TwitterClient sharedInstance] openURL: url];

     return YES;
}


-(void) userDidLogout{
    self.window.rootViewController = [[LoginViewController alloc] init];
}

@end
