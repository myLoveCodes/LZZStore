//
//  LZZCache.h
//  LZZStore
//
//  Created by LZZ on 2018/7/18.
//  Copyright © 2018年 罗志忠. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LZZCache : NSObject

+ (id<NSCoding>)objectForKey:(NSString *)key;
+ (void)setObject:(id<NSCoding>)object forKey:(NSString *)key;

+ (void)removeAllCache;

@end
