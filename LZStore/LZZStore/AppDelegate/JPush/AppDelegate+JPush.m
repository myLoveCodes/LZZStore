//
//  AppDelegate+JPush.m
//  LZZStore
//
//  Created by LZZ on 2018/7/18.
//  Copyright © 2018年 罗志忠. All rights reserved.
//

#import "AppDelegate+JPush.h"

@implementation AppDelegate (JPush)

-(void)jpushApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    [self registerJPushWithOptions:launchOptions];
}
-(void)jpushApplication:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    [JPUSHService registerDeviceToken:deviceToken];
}
- (void)jpushApplication:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}
- (void)jpushHandleRemoteNotification:(NSDictionary *)userInfo{
    [JPUSHService handleRemoteNotification:userInfo];
    [self jpushWithNotification:userInfo];
}
#pragma mark -JPUSHRegisterDelegate
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler  API_AVAILABLE(ios(10.0)){
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [JPUSHService setBadge:0];
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]
        ]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执 这个 法，选择 是否提醒 户，有Badge、Sound、Alert三种类型可以选择设置
}

- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler  API_AVAILABLE(ios(10.0)){
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [JPUSHService setBadge:0];
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    [self jpushWithNotification:userInfo];
    completionHandler();
    // 系统要求执 这个 法
}
#endif

#pragma mark -注册极光推送
-(void)registerJPushWithOptions:(NSDictionary *)launchOptions{
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    
    NSString *jpushAppKey = [APPIdentifierConfig shareConfig].jpushAppKey;
    BOOL isProd;
    if ([[APPIdentifierConfig shareConfig].currentEnv isEqual:@"dev"]) {
        isProd = NO;
    }else{
        isProd = YES;
    }
    [JPUSHService setupWithOption:launchOptions appKey:jpushAppKey
                          channel:@"channel"
                 apsForProduction:isProd
            advertisingIdentifier:advertisingId];
}
#pragma mark -推送消息处理
-(void)jpushWithNotification:(NSDictionary *)userInfo{
    
}

@end
