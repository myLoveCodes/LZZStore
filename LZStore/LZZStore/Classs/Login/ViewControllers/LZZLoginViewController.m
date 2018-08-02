//
//  LZZLoginViewController.m
//  LZZStore
//
//  Created by LZZ on 2018/7/19.
//  Copyright © 2018年 罗志忠. All rights reserved.
//

#import "LZZLoginViewController.h"

#import "LZZLoginView.h"
#import <UMShare/UMShare.h>
#import "LZZShareView.h"
#import "LZZLoginViewModel.h"

@interface LZZLoginViewController ()

@property (nonatomic,strong) LZZLoginViewModel *loginViewModel;
@property (nonatomic,strong) LZZLoginView *loginView;

//@property (nonatomic,strong)UIImageView *headImgV;
//@property (nonatomic,strong)UILabel *nickNameL;
//@property (nonatomic,strong)UILabel *sexL;

@end

@implementation LZZLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setSubviews];
    [self setLayout];
    [self bindViewModel];
    
}
-(void)bindViewModel{
    kWeakSelf
    [self.loginViewModel.loginCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        [MBProgressHUD hideHUDForView:weakSelf.loginView animated:YES];
    }];
    [self.loginViewModel.wechatLoginCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        if ([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_WechatSession]) {
            [weakSelf umLoginWithType:UMSocialPlatformType_WechatSession];
        }else{
            [MBProgressHUD showError:@"你没有安装微信" toView:weakSelf.view];
        }
    }];
    [self.loginViewModel.qqLoginCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        if ([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_QQ]) {
            [weakSelf umLoginWithType:UMSocialPlatformType_QQ];
        }else{
            [MBProgressHUD showError:@"你没有安装QQ" toView:weakSelf.view];
        }
    }];
}
-(void)umLoginWithType:(UMSocialPlatformType)type{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:type currentViewController:self completion:^(id result, NSError *error) {
        
        UMSocialUserInfoResponse *resp = result;
        
        // 第三方登录数据(为空表示平台未提供)
        // 授权数据
        NSLog(@" uid: %@", resp.uid);
        NSLog(@" openid: %@", resp.openid);
        NSLog(@" accessToken: %@", resp.accessToken);
        NSLog(@" refreshToken: %@", resp.refreshToken);
        NSLog(@" expiration: %@", resp.expiration);
        
        // 用户数据
        NSLog(@" name: %@", resp.name);
        NSLog(@" iconurl: %@", resp.iconurl);
        NSLog(@" gender: %@", resp.unionGender);
        
        
        // 第三方平台SDK原始数据
        NSLog(@" originalResponse: %@", resp.originalResponse);
    }];

}

-(void)setSubviews{
    [self.view addSubview:self.loginView];
}
-(void)setLayout{
    kWeakSelf
    [self.loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
}

-(LZZLoginView *)loginView{
    if (_loginView == nil) {
        _loginView = [[LZZLoginView alloc] initWithViewModel:self.loginViewModel];
    }
    return _loginView;
}
-(LZZLoginViewModel *)loginViewModel{
    if (_loginViewModel == nil) {
        _loginViewModel = [[LZZLoginViewModel alloc] init];
    }
    return _loginViewModel;
}




@end
