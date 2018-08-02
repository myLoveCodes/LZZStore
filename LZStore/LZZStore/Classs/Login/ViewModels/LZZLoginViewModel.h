//
//  LZZLoginViewModel.h
//  LZZStore
//
//  Created by LZZ on 2018/7/25.
//  Copyright © 2018年 罗志忠. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LZZLoginViewModel : NSObject

@property (nonatomic,copy) NSString *account;
@property (nonatomic,copy) NSString *code;

@property (nonatomic,strong)RACCommand *sendCodeCommand;
@property (nonatomic,strong)RACCommand *loginCommand;
@property (nonatomic,strong)RACCommand *wechatLoginCommand;
@property (nonatomic,strong)RACCommand *qqLoginCommand;



@end
