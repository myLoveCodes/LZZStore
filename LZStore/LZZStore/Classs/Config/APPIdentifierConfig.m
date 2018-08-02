//
//  APPIdentifierConfig.m
//  LZZStore
//
//  Created by LZZ on 2018/7/18.
//  Copyright © 2018年 罗志忠. All rights reserved.
//

#import "APPIdentifierConfig.h"

static NSString *const bundleIdDev = @"LZZ.LZZStore.dev";
static NSString *const bundleIdProd = @"LZZ.LZZStore";

@implementation APPIdentifierConfig

+(instancetype)shareConfig{
    static APPIdentifierConfig *config = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        config = [[APPIdentifierConfig alloc] init];
    });
    return config;
}

-(NSString *)baseURL{
    NSString *bundleId = [NSBundle mainBundle].bundleIdentifier;
    if ([bundleId isEqual:bundleIdProd]) {
        return @"";
    }
    return @"";
}
-(NSString *)buglyAppKey{
    NSString *bundleId = [NSBundle mainBundle].bundleIdentifier;
    if ([bundleId isEqual:bundleIdProd]) {
        return @"";
    }
    return @"";
}
-(NSString *)jpushAppKey{
    NSString *bundleId = [NSBundle mainBundle].bundleIdentifier;
    if ([bundleId isEqual:bundleIdProd]) {
        return @"";
    }
    return @"";
}
-(NSString *)mtaAppKey{
    NSString *bundleId = [NSBundle mainBundle].bundleIdentifier;
    if ([bundleId isEqual:bundleIdProd]) {
        return @"";
    }
    return @"";
}
-(NSString *)shareAppKey{
    NSString *bundleId = [NSBundle mainBundle].bundleIdentifier;
    if ([bundleId isEqual:bundleIdProd]) {
        return @"567b665667e58e963b004712";
    }
    return @"567b665667e58e963b004712";
}
-(NSString *)wechatAppKey{
    NSString *bundleId = [NSBundle mainBundle].bundleIdentifier;
    if ([bundleId isEqual:bundleIdProd]) {
        return @"wx13d1c32f3085041e";
    }
    return @"wx13d1c32f3085041e";
}
-(NSString *)wechatSecret{
    NSString *bundleId = [NSBundle mainBundle].bundleIdentifier;
    if ([bundleId isEqual:bundleIdProd]) {
        return @"75615ef571cb81bf28475e7064789557";
    }
    return @"75615ef571cb81bf28475e7064789557";
}
-(NSString *)qqAppId{
    NSString *bundleId = [NSBundle mainBundle].bundleIdentifier;
    if ([bundleId isEqual:bundleIdProd]) {
        return @"1104877302";
    }
    return @"1104877302";
}
-(NSString *)qqAppKey{
    NSString *bundleId = [NSBundle mainBundle].bundleIdentifier;
    if ([bundleId isEqual:bundleIdProd]) {
        return @"5X7VzBU50ocnTmf3";
    }
    return @"5X7VzBU50ocnTmf3";
}
-(NSString *)currentEnv{
    NSString *bundleId = [NSBundle mainBundle].bundleIdentifier;
    if ([bundleId isEqual:bundleIdProd]) {
        return @"prod";
    }
    return @"dev";
}
@end
