//
//  AppDelegate+Bugly.m
//  LZZStore
//
//  Created by LZZ on 2018/7/18.
//  Copyright © 2018年 罗志忠. All rights reserved.
//

#import "AppDelegate+Bugly.h"
#import <Bugly/Bugly.h>



@implementation AppDelegate (Bugly)

-(void)setBugly{
    [Bugly startWithAppId:[APPIdentifierConfig shareConfig].buglyAppKey];
}

@end
