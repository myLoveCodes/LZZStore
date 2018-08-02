//
//  APPConfig.h
//  LZZStore
//
//  Created by LZZ on 2018/7/17.
//  Copyright © 2018年 罗志忠. All rights reserved.
//

#ifndef APPConfig_h
#define APPConfig_h
/**
 *   本文件只可以放app相关的宏定义
 */


// Font字体大小
#define APPFONT(size)  [UIFont systemFontOfSize:size]
// 屏幕尺寸相关
#define SCREEN_BOUNDS [ [ UIScreen mainScreen ] bounds ]
#define SCREEN_WIDTH [ [ UIScreen mainScreen ] bounds ].size.width
#define SCREEN_HEIGHT [ [ UIScreen mainScreen ] bounds ].size.height
// StatusBar 高度
#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
// TabBar 高度
#define kTabBarHeight (kStatusBarHeight == 44.0f ? 83.0f : 49.0f)
// 根据iPhone6宽度计算适配当前屏幕
#define kFitSize(size) (SCREEN_WIDTH / 375.0f) * size

#define kWeakSelf __weak typeof(self) weakSelf = self;
#define kStrongSelf __Strong typeof(self) strongSelf = self;
// 非空验证
#define ValidateNullValue(value) ((value == nil || [value isKindOfClass:[NSNull class]]) ? @"" : value)
// 颜色相关宏定义
#define ThemeColor ColorWithHex(@"f2227a")
#define ColorWithHex(hex) [UIColor colorWithHexString:hex]
#define ColorWithHexA(hex,alp) [UIColor colorWithHexString:hex alpha:alp]
#define ColorWithRGB(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0f]
#define ColorWithRGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
// NSLog
#define NSLog(format,...) NSLog((@"%s [Line %d]"format), __PRETTY_FUNCTION__,__LINE__,## __VA_ARGS__)


#endif /* APPConfig_h */
