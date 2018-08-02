//
//  LZZLoginViewModel.m
//  LZZStore
//
//  Created by LZZ on 2018/7/25.
//  Copyright © 2018年 罗志忠. All rights reserved.
//

#import "LZZLoginViewModel.h"

@implementation LZZLoginViewModel

-(RACCommand *)sendCodeCommand{
    if (_sendCodeCommand == nil) {
        _sendCodeCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [subscriber sendNext:@""];
                    [subscriber sendCompleted];
                });
                return nil;
            }];
        }];
    }
    return _sendCodeCommand;
}
-(RACCommand *)loginCommand{
    if (_loginCommand == nil) {
        _loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [subscriber sendNext:@""];
                    [subscriber sendCompleted];
                });
                return nil;
            }];
        }];
    }
    return _loginCommand;
}
-(RACCommand *)wechatLoginCommand{
    if (_wechatLoginCommand == nil) {
        _wechatLoginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                [subscriber sendNext:@""];
                [subscriber sendCompleted];
                return nil;
            }];
        }];
    }
    return _wechatLoginCommand;
}
-(RACCommand *)qqLoginCommand{
    if (_qqLoginCommand == nil) {
        _qqLoginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                [subscriber sendNext:@""];
                [subscriber sendCompleted];
                return nil;
            }];
        }];
    }
    return _qqLoginCommand;
}


@end
