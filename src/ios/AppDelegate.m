//
//  AppDelegate.m
//  fbmessangerintegration
//
//  Created by Purusottam M on 3/10/16.
//  Copyright © 2016 Purusottam M. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate () <FBSDKMessengerURLHandlerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    _messengerUrlHandler = [[FBSDKMessengerURLHandler alloc] init];
    _messengerUrlHandler.delegate = self;
    
    // Override point for customization after application launch.
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
    
    [FBSDKAppEvents activateApp];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    // Check if the handler knows what to do with this url
    if ([_messengerUrlHandler canOpenURL:url sourceApplication:sourceApplication]) {
        // Handle the url
        [_messengerUrlHandler openURL:url sourceApplication:sourceApplication];
    }
    
    return YES;
//    return [[FBSDKApplicationDelegate sharedInstance] application:application
//                                                          openURL:url
//                                                sourceApplication:sourceApplication
//                                                       annotation:annotation
//            ];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/*
 * When people enter your app through the composer in Messenger,
 * this delegate function will be called.
 */
- (void)messengerURLHandler:(FBSDKMessengerURLHandler *)messengerURLHandler
didHandleOpenFromComposerWithContext:(FBSDKMessengerURLHandlerOpenFromComposerContext *)context;
{
    _composerContext = context;
}

/*
 * When people enter your app through the "Reply" button on content
 * this delegate function will be called.
 */
- (void)messengerURLHandler:(FBSDKMessengerURLHandler *)messengerURLHandler
  didHandleReplyWithContext:(FBSDKMessengerURLHandlerReplyContext *)context;
{
    _replyContext = context;
}

// helper enum i made to define the state
enum MessengerShareMode { MessengerShareModeSend,
    MessengerShareModeComposer,
    MessengerShareModeReply};

// shareMode holds state indicating which flow the user is in.
// Return the corresponding FBSDKMessengerContext based on that state.
enum MessengerShareMode shareMode;

- (FBSDKMessengerContext *) getContextForShareMode
{
    // shareMode holds state indicating which flow the user is in.
    // Return the corresponding FBSDKMessengerContext based on that state.
    
    if (shareMode == MessengerShareModeSend) {
        // Force a send flow by returning a broadcast context.
        return [[FBSDKMessengerBroadcastContext alloc] init];
        
    } else if (shareMode == MessengerShareModeComposer) {
        // Force the composer flow by returning the composer context.
        
        return _composerContext;
    } else if (shareMode == MessengerShareModeReply) {
        // Force the reply flow by returning the reply context.
        return _replyContext;
    }
    
    
    return nil;
}

@end
