//
//  LZZHttpClient.m
//  ZBT
//
//  Created by LZZ on 2018/7/3.
//  Copyright © 2018年 罗志忠. All rights reserved.
//

#import "LZZHttpClient.h"
#import <AFNetworking/AFNetworking.h>

@interface LZZHttpClient ()

@property (nonatomic,strong)AFHTTPSessionManager *manager;

@end

@implementation LZZHttpClient

+(instancetype)shareClient{
    static LZZHttpClient *client = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        client = [[LZZHttpClient alloc] init];
        client.manager = [AFHTTPSessionManager manager];
        client.manager.requestSerializer.timeoutInterval = 5;
        client.manager.responseSerializer = [AFJSONResponseSerializer serializer];
        client.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    });
    return client;
}

-(void)post:(NSString *)url
     params:(NSDictionary *)params
    success:(void (^)(NSDictionary *))successBlock
      error:(void (^)(NSError *))errorBlock{
    url = [url stringByReplacingOccurrencesOfString:@" " withString:@""];

    [self.manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (successBlock != nil) {
            NSDictionary *result = responseObject;
            successBlock(result);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (errorBlock != nil) {
            errorBlock(error);
        }
    }];
}

-(void)get:(NSString *)url
    params:(NSDictionary *)params
   success:(void (^)(NSDictionary *))successBlock
     error:(void (^)(NSError *))errorBlock{
    url = [url stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    [self.manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (successBlock != nil) {
            NSDictionary *result = responseObject;
            successBlock(result);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (errorBlock != nil) {
            errorBlock(error);
        }
    }];
}
-(void)uploadImageWithPath:(NSString *)path
                    params:(NSDictionary *)params
                  fileName:(NSString *)fileName
                    images:(NSArray *)images
                  progress:(void (^)(double))progressBlock
                   success:(void (^)(NSDictionary *))successBlock
                   failure:(void (^)(NSError *))errorBlock{
    path = [path stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    self.manager.requestSerializer.timeoutInterval = 20.0f;
    [self.manager POST:path parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [images enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSData *imageData = nil;
            if (![obj isKindOfClass:[NSData class]]) {
                imageData = UIImagePNGRepresentation(obj);
            }else{
                imageData = obj;
            }
            NSString *tempFileName = [NSString stringWithFormat:@"photo%lu.png",(unsigned long)idx];
            if (imageData.length > 0) {
                [formData appendPartWithFileData:imageData name:fileName fileName:tempFileName mimeType:@"image/png"];
            }
        }];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progressBlock != nil) {
            progressBlock(uploadProgress.fractionCompleted);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (successBlock != nil) {
            NSDictionary *result = responseObject;
            successBlock(result);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (errorBlock != nil) {
            errorBlock(error);
        }
    }];
}

@end
