//
//  LZZCache.m
//  LZZStore
//
//  Created by LZZ on 2018/7/18.
//  Copyright © 2018年 罗志忠. All rights reserved.
//

#import "LZZCache.h"
#import <YYCache.h>
static NSString *cacheName = @"LZZStoreCache";

@implementation LZZCache

+(id<NSCoding>)objectForKey:(NSString *)key{
    YYCache *cache = [[YYCache alloc] initWithName:cacheName];
    return [cache objectForKey:key];
}

+(void)setObject:(id<NSCoding>)object forKey:(NSString *)key{
    YYCache *cache = [[YYCache alloc] initWithName:cacheName];
    [cache setObject:object forKey:key];
}

+(void)removeAllCache{
    YYCache *cache = [[YYCache alloc] initWithName:cacheName];
    [cache removeAllObjects];
}

@end
