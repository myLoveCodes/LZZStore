//
//  UIColor+HexColor.h
//  LZZStore
//
//  Created by LZZ on 2018/7/17.
//  Copyright © 2018年 罗志忠. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexColor)

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert alpha:(CGFloat)alpha;
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;

@end
