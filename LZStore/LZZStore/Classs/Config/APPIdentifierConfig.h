//
//  APPIdentifierConfig.h
//  LZZStore
//
//  Created by LZZ on 2018/7/18.
//  Copyright © 2018年 罗志忠. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface APPIdentifierConfig : NSObject

+(instancetype)shareConfig;

@property (nonatomic,readonly) NSString *baseURL;
@property (nonatomic,readonly) NSString *buglyAppKey;
@property (nonatomic,readonly) NSString *jpushAppKey;
@property (nonatomic,readonly) NSString *mtaAppKey;
@property (nonatomic,readonly) NSString *shareAppKey;
@property (nonatomic,readonly) NSString *wechatAppKey;
@property (nonatomic,readonly) NSString *wechatSecret;
@property (nonatomic,readonly) NSString *qqAppId;
@property (nonatomic,readonly) NSString *qqAppKey;

@property (nonatomic,readonly) NSString *currentEnv;

@end
