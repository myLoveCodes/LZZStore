//
//  AppDelegate+JPush.h
//  LZZStore
//
//  Created by LZZ on 2018/7/18.
//  Copyright © 2018年 罗志忠. All rights reserved.
//

#import "AppDelegate.h"

#import <JPUSHService.h>
#import <UserNotifications/UserNotifications.h>
#import <AdSupport/AdSupport.h>

@interface AppDelegate (JPush) <JPUSHRegisterDelegate>

- (void)jpushApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;
- (void)jpushApplication:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;
- (void)jpushApplication:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler;
- (void)jpushHandleRemoteNotification:(NSDictionary *)userInfo;

@end
