//
//  LZZShareView.m
//  LZZStore
//
//  Created by LZZ on 2018/7/23.
//  Copyright © 2018年 罗志忠. All rights reserved.
//

#import "LZZShareView.h"
#import <UMShare/UMShare.h>

static LZZShareView *shareView = nil;

@interface LZZShareView()

@property (nonatomic,strong) UIView *shareBgV;
@property (nonatomic,strong) UIButton *cancelBtn;

@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *desc;
@property (nonatomic,copy) NSString *thumImage;
@property (nonatomic,copy) NSString *webPageUrl;
@property (nonatomic,weak) UIViewController *currentViewController;
@property (nonatomic,copy) void (^successBlock)(id data);
@property (nonatomic,copy) void (^errorBlock)(NSError *error);

@end

@implementation LZZShareView

+(void)shareWithTitle:(NSString *)title
                 desc:(NSString *)desc
            thumImage:(id)thumImage
           webPageUrl:(NSString *)webPageUrl
currentViewController:(UIViewController *)currentViewController
              success:(void (^)(id))successBlock
                error:(void (^)(NSError *))errorBlock{
    if (shareView == nil) {
        shareView = [[LZZShareView alloc] initWithTitle:title desc:desc thumImage:thumImage webPageUrl:webPageUrl currentViewController:currentViewController success:successBlock error:errorBlock];
    }
    [[UIApplication sharedApplication].keyWindow addSubview:shareView];
}
-(instancetype)initWithTitle:(NSString *)title
                        desc:(NSString *)desc
                   thumImage:(id)thumImage
                  webPageUrl:(NSString *)webPageUrl
       currentViewController:(UIViewController *)currentViewController
                     success:(void (^)(id))successBlock
                       error:(void (^)(NSError *))errorBlock{
    if (self = [super init]) {
        self.title = title;
        self.desc = desc;
        self.thumImage = thumImage;
        self.webPageUrl = webPageUrl;
        self.currentViewController = currentViewController;
        self.successBlock = successBlock;
        self.errorBlock = errorBlock;
        
        self.frame = [UIScreen mainScreen].bounds;
        
        [self setSubviews];
        [self showAnimation];
    }
    return self;
}

-(void)shareWithType:(UMSocialPlatformType)type{
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:self.title descr:self.desc thumImage:self.thumImage];
    shareObject.webpageUrl = self.webPageUrl;
    messageObject.shareObject = shareObject;
    kWeakSelf
    [[UMSocialManager defaultManager] shareToPlatform:type messageObject:messageObject currentViewController:self.currentViewController completion:^(id data, NSError *error) {
        if (error) {
            if (weakSelf.errorBlock != nil) {
                weakSelf.errorBlock(error);
            }
        }else{
            if (weakSelf.successBlock != nil) {
                weakSelf.successBlock(data);
            }
        }
    }];
    [weakSelf closeAnimation];
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touche = touches.anyObject;
    if (touche.view != self.shareBgV) {
        [self closeAnimation];
    }
}
-(void)btnClick:(UIButton *)sender{
    [self shareWithType:(UMSocialPlatformType)([[self types][sender.tag] integerValue])];
}

-(void)showAnimation{
    [UIView animateWithDuration:0.25f animations:^{
        self.backgroundColor = ColorWithHexA(@"000000", 0.2f);
        CGRect rect = CGRectZero;
        rect.size.width = SCREEN_WIDTH;
        rect.size.height = 88.0f + kTabBarHeight;
        rect.origin.x = 0.0f;
        rect.origin.y = SCREEN_HEIGHT - rect.size.height;
        self.shareBgV.frame = rect;
    }];
}
-(void)closeAnimation{
    [UIView animateWithDuration:0.25f animations:^{
        self.backgroundColor = ColorWithHexA(@"000000", 0.0f);
        CGRect rect = CGRectZero;
        rect.size.width = SCREEN_WIDTH;
        rect.size.height = 88.0f + kTabBarHeight;
        rect.origin.x = 0.0f;
        rect.origin.y = SCREEN_HEIGHT;
        self.shareBgV.frame = rect;
    } completion:^(BOOL finished) {
        if (finished) {
            [shareView removeFromSuperview];
            shareView = nil;
        }
    }];
}
-(void)setSubviews{
    [self addSubview:self.shareBgV];
    [self.shareBgV addSubview:self.cancelBtn];
    
    NSArray *icons = [self icons];
    NSArray *titles = [self titles];
    NSInteger count = icons.count;
    for (NSInteger i = 0; i < count; i ++) {
        FL_Button *btn = [FL_Button fl_shareButton];
        btn.frame = CGRectMake(i * (SCREEN_WIDTH / count), 0.0f, SCREEN_WIDTH / count, 88.0f);
        btn.status = FLAlignmentStatusTop;

        [btn setTitle:titles[i] forState:UIControlStateNormal];
        [btn setTitleColor:ColorWithHex(@"333333") forState:UIControlStateNormal];
        [btn setImage:icons[i] forState:UIControlStateNormal];
        btn.titleLabel.font = APPFONT(14.0f);
        btn.tag = i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.shareBgV addSubview:btn];
    }
}
-(UIView *)shareBgV{
    if (_shareBgV == nil) {
        CGRect rect = CGRectZero;
        rect.size.width = SCREEN_WIDTH;
        rect.size.height = 88.0f + kTabBarHeight;
        rect.origin.x = 0.0f;
        rect.origin.y = SCREEN_HEIGHT;
        _shareBgV = [[UIView alloc] initWithFrame:rect];
        _shareBgV.backgroundColor = [UIColor whiteColor];
    }
    return _shareBgV;
}
-(UIButton *)cancelBtn{
    if (_cancelBtn == nil) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelBtn.frame = CGRectMake(0.0f, 88.0f, SCREEN_WIDTH, 49.0f);
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:ColorWithHex(@"666666") forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = APPFONT(16.0f);
        kWeakSelf
        [[_cancelBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            [weakSelf closeAnimation];
        }];
        
        CALayer *layer = [[CALayer alloc] init];
        layer.frame = CGRectMake(8.0f, 0.0f, _cancelBtn.frame.size.width - 16.0f, 0.5f);
        layer.backgroundColor = ColorWithHex(@"e6e6e6").CGColor;
        [_cancelBtn.layer addSublayer:layer];
    }
    return _cancelBtn;
}
-(NSArray *)icons{
    return @[[UIImage imageNamed:@"QQ"],
             [UIImage imageNamed:@"Qzone"],
             [UIImage imageNamed:@"wechatSession"],
             [UIImage imageNamed:@"wechatTimeLine"]];
}
-(NSArray *)titles{
    return @[@"QQ",
             @"QQ空间",
             @"微信",
             @"朋友圈"];
}
-(NSArray *)types{
    return @[@(UMSocialPlatformType_QQ),
             @(UMSocialPlatformType_Qzone),
             @(UMSocialPlatformType_WechatSession),
             @(UMSocialPlatformType_WechatTimeLine)];
}

@end
