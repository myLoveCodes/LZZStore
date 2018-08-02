//
//  AppDelegate+MTA.m
//  LZZStore
//
//  Created by LZZ on 2018/7/18.
//  Copyright © 2018年 罗志忠. All rights reserved.
//

#import "AppDelegate+MTA.h"


@implementation AppDelegate (MTA)

-(void)setMTA{
    [MTA startWithAppkey:[APPIdentifierConfig shareConfig].mtaAppKey];
}

@end
