//
//  LZZHttpClient.h
//  ZBT
//
//  Created by LZZ on 2018/7/3.
//  Copyright © 2018年 罗志忠. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LZZHttpClient : NSObject

+(instancetype)shareClient;

-(void)post:(NSString *)url
     params:(NSDictionary *)params
    success:(void (^) (NSDictionary *result))successBlock
      error:(void (^) (NSError *error))errorBlock;

-(void)get:(NSString *)url
    params:(NSDictionary *)params
   success:(void (^) (NSDictionary *result))successBlock
     error:(void (^) (NSError *error))errorBlock;

-(void)uploadImageWithPath:(NSString *)path
                    params:(NSDictionary *)params
                  fileName:(NSString *)fileName
                    images:(NSArray *)images
                  progress:(void (^) (double progress))progressBlock
                   success:(void (^) (NSDictionary *result))successBlock
                   failure:(void (^) (NSError *error))errorBlock;

@end
