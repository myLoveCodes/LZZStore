//
//  AppDelegate+UMCShare.h
//  LZZStore
//
//  Created by LZZ on 2018/7/20.
//  Copyright © 2018年 罗志忠. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (UMCShare)

-(void)setUSharePlatforms;
-(BOOL)umshareApplication:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options;
@end
