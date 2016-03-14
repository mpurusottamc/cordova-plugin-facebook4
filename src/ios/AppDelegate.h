//
//  AppDelegate.h
//  fbmessangerintegration
//
//  Created by Purusottam M on 3/10/16.
//  Copyright © 2016 Purusottam M. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKMessengerShareKit/FBSDKMessengerShareKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property FBSDKMessengerURLHandler *messengerUrlHandler;
@property FBSDKMessengerURLHandlerOpenFromComposerContext *composerContext;
@property FBSDKMessengerURLHandlerReplyContext *replyContext;

@end
