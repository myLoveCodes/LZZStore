//
//  AppDelegate+UMCShare.m
//  LZZStore
//
//  Created by LZZ on 2018/7/20.
//  Copyright © 2018年 罗志忠. All rights reserved.
//

#import "AppDelegate+UMCShare.h"
#import <UMShare/UMShare.h>

@implementation AppDelegate (UMCShare)

-(void)setUSharePlatforms{
    
    APPIdentifierConfig *config = [APPIdentifierConfig shareConfig];
    
    [[UMSocialManager defaultManager] setUmSocialAppkey:config.shareAppKey];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:config.wechatAppKey appSecret:config.wechatSecret redirectURL:@"http://mobile.umeng.com/social"];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:config.qqAppId  appSecret:config.qqAppKey  redirectURL:@"http://mobile.umeng.com/social"];
}
-(BOOL)umshareApplication:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    BOOL result = [[UMSocialManager defaultManager]  handleOpenURL:url options:options];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}
@end
