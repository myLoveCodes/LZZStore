//
//  LZZLoginView.m
//  LZZStore
//
//  Created by LZZ on 2018/7/19.
//  Copyright © 2018年 罗志忠. All rights reserved.
//

#import "LZZLoginView.h"
#import "LZZLoginViewModel.h"

@interface LZZLoginView ()

@property (nonatomic,strong)UITextField *phoneTF;
@property (nonatomic,strong)UITextField *codeTF;
@property (nonatomic,strong)UIButton *sendBtn;
@property (nonatomic,strong)UIButton *loginBtn;

@property (nonatomic,strong)UIButton *agreeBtn;
@property (nonatomic,strong)UIButton *protocolBtn;

@property (nonatomic,strong)UIView *lineV;
@property (nonatomic,strong)UILabel *otherLoginTitleL;
@property (nonatomic,strong)UIView *lineV1;

@property (nonatomic,strong)FL_Button *wechatBtn;
@property (nonatomic,strong)FL_Button *qqBtn;

@property (nonatomic,strong)UILabel *otherLoginModeL;

@property (nonatomic,strong)UIActivityIndicatorView *indicatorView;

@property (nonatomic,strong)RACDisposable *dispoable;

@property (nonatomic,weak)LZZLoginViewModel *viewModel;

@end

@implementation LZZLoginView

-(instancetype)initWithViewModel:(LZZLoginViewModel *)viewModel{
    if (self = [super init]) {
        self.viewModel = viewModel;
        [self setSubviews];
        [self setLayout];
        [self bindViewModel];
    }
    return self;
}

#pragma mark - set UI
-(void)setSubviews{
    [self addSubview:self.phoneTF];
    [self addSubview:self.codeTF];
    [self addSubview:self.loginBtn];
    [self addSubview:self.agreeBtn];
    [self addSubview:self.protocolBtn];
    [self addSubview:self.wechatBtn];
    [self addSubview:self.qqBtn];
    [self addSubview:self.otherLoginModeL];
    [self addSubview:self.lineV];
    [self addSubview:self.lineV1];
    [self addSubview:self.otherLoginTitleL];
    
}
-(void)setLayout{
    kWeakSelf
    [self.phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(16.0f);
        make.top.offset(kStatusBarHeight + 64.0f);
        make.right.offset(-16.0f);
        make.height.offset(48.0f);
    }];
    [self.codeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(16.0f);
        make.top.equalTo(weakSelf.phoneTF.mas_bottom).offset(0.0f);
        make.right.offset(-16.0f);
        make.height.offset(48.0f);
    }];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(16.0f);
        make.top.equalTo(weakSelf.codeTF.mas_bottom).offset(48.0f);
        make.right.offset(-16.0f);
        make.height.offset(44.0f);
    }];
    [self.agreeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(16.0f);
        make.height.offset(24.0f);
        make.top.equalTo(weakSelf.loginBtn.mas_bottom).offset(10.0f);
    }];
    [self.protocolBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.agreeBtn.mas_right).offset(0.0f);
        make.height.offset(24.0f);
        make.top.equalTo(weakSelf.loginBtn.mas_bottom).offset(10.0f);
    }];
    [self.otherLoginModeL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.bottom.offset(-(kTabBarHeight - 49.0f) - 8.0f);
    }];
    [self.wechatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0.0f);
        make.bottom.equalTo(self.otherLoginModeL.mas_top).offset(-8.0f);
        make.width.offset(SCREEN_WIDTH / 2);
        make.height.offset(90.0f);
    }];
    [self.qqBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(0.0f);
        make.bottom.equalTo(self.otherLoginModeL.mas_top).offset(-8.0f);
        make.width.offset(SCREEN_WIDTH / 2);
        make.height.offset(90.0f);
    }];
    [self.otherLoginTitleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf.wechatBtn.mas_top).offset(-16.0f);
    }];
    [self.lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(16.0f);
        make.right.equalTo(weakSelf.otherLoginTitleL.mas_left).offset(-16.0f);
        make.height.offset(1.0f);
        make.bottom.equalTo(weakSelf.wechatBtn.mas_top).offset(-23.0f);
    }];
    [self.lineV1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-16.0f);
        make.left.equalTo(weakSelf.otherLoginTitleL.mas_right).offset(16.0f);
        make.height.offset(1.0f);
        make.bottom.equalTo(weakSelf.wechatBtn.mas_top).offset(-23.0f);
    }];
}
#pragma makr - private mothed
-(void)bindViewModel{
    kWeakSelf
    [self.viewModel.sendCodeCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        [weakSelf countDown];
    }];
    RAC(self.viewModel,account) = [RACSignal merge:@[RACObserve(self.phoneTF, text),self.phoneTF.rac_textSignal]];
    RAC(self.viewModel,code) = [RACSignal merge:@[RACObserve(self.codeTF, text),self.codeTF.rac_textSignal]];
    RACSignal *phoneSignal = [self.phoneTF.rac_textSignal map:^id _Nullable(NSString * _Nullable value) {
        return @(value.length == 11);
    }];
    RACSignal *codeSignal = [self.codeTF.rac_textSignal map:^id _Nullable(NSString * _Nullable value) {
        return @(value.length == 4);
    }];
    [[RACSignal combineLatest:@[phoneSignal,codeSignal]] subscribeNext:^(RACTuple * _Nullable x) {
        BOOL phoneFlag = [x.first boolValue];
        if (phoneFlag == YES) {
            weakSelf.sendBtn.userInteractionEnabled = YES;
            weakSelf.sendBtn.layer.borderColor = ThemeColor.CGColor;
            [weakSelf.sendBtn setTitleColor:ThemeColor forState:UIControlStateNormal];
        }else{
            weakSelf.sendBtn.userInteractionEnabled = NO;
            weakSelf.sendBtn.layer.borderColor = ColorWithHex(@"e6e6e6").CGColor;
            [weakSelf.sendBtn setTitleColor:ColorWithHex(@"999999") forState:UIControlStateNormal];
            [weakSelf indicatorViewZero];
            [weakSelf stopSendBtnAnimation];
        }
        BOOL flag = YES;
        for (NSNumber *num in x) {
            if ([num boolValue] == NO) {
                flag = NO;
                break;
            }
        }
        if (!flag) {
            weakSelf.loginBtn.userInteractionEnabled = NO;
            weakSelf.loginBtn.backgroundColor = ColorWithHex(@"c6c6c6");
        }else{
            weakSelf.loginBtn.userInteractionEnabled = YES;
            weakSelf.loginBtn.backgroundColor = ThemeColor;
        }
    }];
}
-(void)countDown{
    [self indicatorViewZero];
    [self.sendBtn setTitle:@"59s" forState:UIControlStateNormal];
    __block NSInteger timer = 59;
    kWeakSelf
    self.dispoable = [[RACSignal interval:1.0f onScheduler:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSDate * _Nullable x) {
        timer --;
        if (timer > 0) {
            [weakSelf.sendBtn setTitle:[NSString stringWithFormat:@"%lds",timer] forState:UIControlStateNormal];
            weakSelf.sendBtn.userInteractionEnabled = NO;
        }else{
            [weakSelf stopSendBtnAnimation];
        }
    }];
}
-(void)indicatorViewZero{
    [self.indicatorView stopAnimating];
    [self.indicatorView removeFromSuperview];
    self.indicatorView = nil;
}
-(void)startSendBtnAnimation{
    [self.indicatorView startAnimating];
    [self.sendBtn addSubview:self.indicatorView];
    [UIView animateWithDuration:0.25f animations:^{
        [self.sendBtn setTitle:@"" forState:UIControlStateNormal];
        CGRect rect = self.sendBtn.frame;
        rect.origin.x = 100.0f - 32.0f;
        rect.origin.y = 8.0f;
        rect.size = CGSizeMake(32.0f, 32.0f);
        self.sendBtn.layer.cornerRadius = 16.0f;
        self.sendBtn.frame = rect;
    } completion:^(BOOL finished) {
        if (finished) {
            [self.viewModel.sendCodeCommand execute:nil];
        }
    }];
}
-(void)stopSendBtnAnimation{
    [self.dispoable dispose];
    [self.sendBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [UIView animateWithDuration:0.25f animations:^{
        CGRect rect = self.sendBtn.frame;
        rect.origin.x = 0.0f;
        rect.origin.y = 8.0f;
        rect.size = CGSizeMake(100.0f, 32.0f);
        self.sendBtn.layer.cornerRadius = 4.0f;
        self.sendBtn.frame = rect;
        
    } completion:^(BOOL finished) {
    }];
}
#pragma mark - getter/setter
-(UITextField *)phoneTF{
    if (_phoneTF == nil) {
        _phoneTF = [[UITextField alloc] init];
        _phoneTF.placeholder = @"请输入您的手机号";
        _phoneTF.keyboardType = UIKeyboardTypeNumberPad;
        _phoneTF.font = APPFONT(16.0f);
        
        _phoneTF.rightView = [[UIView alloc] init];
        _phoneTF.rightView.frame = CGRectMake(0, 0, 100.0f, 48.0f);
        _phoneTF.rightViewMode = UITextFieldViewModeAlways;
        [_phoneTF.rightView addSubview:self.sendBtn];
        
        CALayer *layer = [[CALayer alloc] init];
        layer.frame = CGRectMake(0.0f, 47.5f, SCREEN_WIDTH - 32.0f, 0.5f);
        layer.backgroundColor = ColorWithHex(@"e6e6e6").CGColor;
        [_phoneTF.layer addSublayer:layer];
    }
    return _phoneTF;
}
-(UITextField *)codeTF{
    if (_codeTF == nil) {
        _codeTF = [[UITextField alloc] init];
        _codeTF.placeholder = @"请输入验证码";
        _codeTF.keyboardType = UIKeyboardTypeNumberPad;
        _codeTF.font = APPFONT(16.0f);
        _codeTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        CALayer *layer = [[CALayer alloc] init];
        layer.frame = CGRectMake(0.0f, 47.5f, SCREEN_WIDTH - 32.0f, 0.5f);
        layer.backgroundColor = ColorWithHex(@"e6e6e6").CGColor;
        [_codeTF.layer addSublayer:layer];
    }
    return _codeTF;
}
-(UIButton *)sendBtn{
    if (_sendBtn == nil) {
        _sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sendBtn.frame = CGRectMake(0.0f, 8.0f, 100.0f, 32.0f);
        [_sendBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_sendBtn setTitleColor:ColorWithHex(@"999999") forState:UIControlStateNormal];
        _sendBtn.titleLabel.font = APPFONT(14.0f);
        _sendBtn.layer.cornerRadius = 4.0f;
        _sendBtn.layer.borderColor = ColorWithHex(@"e6e6e6").CGColor;
        _sendBtn.layer.borderWidth = 0.5f;
        
        kWeakSelf
        [[_sendBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            [weakSelf startSendBtnAnimation];
        }];
    }
    return _sendBtn;
}
-(UIButton *)loginBtn{
    if (_loginBtn == nil) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginBtn.layer.cornerRadius = 4.0f;
        _loginBtn.backgroundColor = ColorWithHex(@"c6c6c6");
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _loginBtn.titleLabel.font = APPFONT(16.0f);
        _loginBtn.userInteractionEnabled = NO;
        kWeakSelf
        [[_loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            [MBProgressHUD showMessag:@"登录中..." toView:weakSelf];
            [weakSelf.viewModel.loginCommand execute:nil];
        }];
    }
    return _loginBtn;
}
-(UIButton *)agreeBtn{
    if (_agreeBtn == nil) {
        _agreeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_agreeBtn setImage:[UIImage imageNamed:@"not_selected"] forState:UIControlStateNormal];
        [_agreeBtn setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateSelected];
        [_agreeBtn setTitle:@"  同意LZZStore" forState:UIControlStateNormal];
        [_agreeBtn setTitleColor:ColorWithHex(@"a6a6a6") forState:UIControlStateNormal];
        _agreeBtn.titleLabel.font = APPFONT(12.0f);
        _agreeBtn.selected = YES;
        [[_agreeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            x.selected = !x.selected;
        }];
    }
    return _agreeBtn;
}
-(UIButton *)protocolBtn{
    if (_protocolBtn == nil) {
        _protocolBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_protocolBtn setTitle:@"《用户使用协议》" forState:UIControlStateNormal];
        [_protocolBtn setTitleColor:ThemeColor forState:UIControlStateNormal];
        _protocolBtn.titleLabel.font = APPFONT(12.0f);
    }
    return _protocolBtn;
}

-(UIView *)lineV{
    if (_lineV == nil) {
        _lineV = [[UIView alloc] init];
        _lineV.backgroundColor = ColorWithHex(@"e6e6e6");
    }
    return _lineV;
}
-(UILabel *)otherLoginTitleL{
    if (_otherLoginTitleL == nil) {
        _otherLoginTitleL = [[UILabel alloc] init];
        _otherLoginTitleL.text = @"其他登录方式";
        _otherLoginTitleL.textColor = ColorWithHex(@"999999");
        _otherLoginTitleL.font = APPFONT(14.0f);
    }
    return _otherLoginTitleL;
}
-(UIView *)lineV1{
    if (_lineV1 == nil) {
        _lineV1 = [[UIView alloc] init];
        _lineV1.backgroundColor = ColorWithHex(@"e6e6e6");
    }
    return _lineV1;
}


-(FL_Button *)wechatBtn{
    if (_wechatBtn == nil) {
        _wechatBtn = [FL_Button fl_shareButton];
        _wechatBtn.status = FLAlignmentStatusTop;
        [_wechatBtn setImage:[UIImage imageNamed:@"wechat"] forState:UIControlStateNormal];
        [_wechatBtn setTitle:@"微信登录" forState:UIControlStateNormal];
        _wechatBtn.titleLabel.font = APPFONT(14.0f);
        [_wechatBtn setTitleColor:ColorWithHex(@"999999") forState:UIControlStateNormal];
        kWeakSelf
        [[_wechatBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            [weakSelf.viewModel.wechatLoginCommand execute:nil];
        }];
    }
    return _wechatBtn;
}
-(FL_Button *)qqBtn{
    if (_qqBtn == nil) {
        _qqBtn = [FL_Button fl_shareButton];
        _qqBtn.status = FLAlignmentStatusTop;
        [_qqBtn setImage:[UIImage imageNamed:@"qq"] forState:UIControlStateNormal];
        [_qqBtn setTitle:@"QQ登录" forState:UIControlStateNormal];
        _qqBtn.titleLabel.font = APPFONT(14.0f);
        [_qqBtn setTitleColor:ColorWithHex(@"999999") forState:UIControlStateNormal];
        kWeakSelf
        [[_qqBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            [weakSelf.viewModel.qqLoginCommand execute:nil];
        }];
    }
    return _qqBtn;
}
-(UILabel *)otherLoginModeL{
    if (_otherLoginModeL == nil) {
        _otherLoginModeL = [[UILabel alloc] init];
        _otherLoginModeL.textColor = ColorWithHex(@"c6c6c6");
        _otherLoginModeL.font = APPFONT(12.0f);
        _otherLoginModeL.text = @"未注册过的用户将直接为您创建LZZStore账户";
    }
    return _otherLoginModeL;
}
-(UIActivityIndicatorView *)indicatorView{
    if (_indicatorView == nil) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _indicatorView.frame = CGRectMake(0, 0, 32.0f, 32.0f);
        _indicatorView.color = ThemeColor;
    }
    return _indicatorView;
}
@end
