//
//  AppDelegate.m
//  wuaki
//
//  Created by José González Gómez on 31/3/17.
//  Copyright © 2017 OPEN input. All rights reserved.
//

#import "AppDelegate.h"

// Infrastructure
#import <Typhoon/Typhoon.h>
#import "WUAssembly.h"

// Utils - Logging
#import <Cocoalumberjack/CocoaLumberjack.h>
#import <XCDLumberjackNSLogger/XCDLumberjackNSLogger.h>
#import "INLogFormatter.h"


#pragma mark Class extension

@interface AppDelegate () <UISplitViewControllerDelegate>
@end


#pragma mark - Class implementation

@implementation AppDelegate


- (void)configureLogger {
    [DDLog addLogger:[DDASLLogger sharedInstance]];
//#if defined(CONFIGURATION_Debug)
    setenv("XcodeColors", "YES", 1);
    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0] backgroundColor:nil forFlag:DDLogFlagVerbose];
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1.0] backgroundColor:nil forFlag:DDLogFlagDebug];
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor colorWithRed:0.0 green:0.5 blue:0.0 alpha:1.0] backgroundColor:nil forFlag:DDLogFlagInfo];
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor colorWithRed:0.7 green:0.4 blue:0.0 alpha:1.0] backgroundColor:nil forFlag:DDLogFlagWarning];
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor colorWithRed:0.5 green:0.0 blue:0.0 alpha:1.0] backgroundColor:nil forFlag:DDLogFlagError];
    [DDTTYLogger sharedInstance].logFormatter = [[INLogFormatter alloc] init];
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
//#endif
//#if defined(CONFIGURATION_Debug) || defined(CONFIGURATION_Testing)
    [DDLog addLogger:[XCDLumberjackNSLogger new]];
//#endif
}

- (void)loadSharedObjectsContext {
    TyphoonComponentFactory *factory = [TyphoonBlockComponentFactory factoryWithAssemblies:@[[[WUAssembly assembly] activateWithConfigResourceName:@"wuaki.properties"]]];
    [factory makeDefault];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self configureLogger];
    [self loadSharedObjectsContext];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
