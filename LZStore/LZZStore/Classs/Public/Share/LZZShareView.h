//
//  LZZShareView.h
//  LZZStore
//
//  Created by LZZ on 2018/7/23.
//  Copyright © 2018年 罗志忠. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LZZShareView : UIView
/**
 * @title 标题
 * @title 简介
 * @title 图片 只能是data类型或者网址
 * @title 网址
 * @title 当然vc
 * @success 成功
 * @error 失败
 */
+(void)shareWithTitle:(NSString *)title
                 desc:(NSString *)desc
            thumImage:(id)thumImage
           webPageUrl:(NSString *)webPageUrl
currentViewController:(UIViewController *)currentViewController
              success:(void (^)(id data))successBlock
                error:(void (^)(NSError *error))errorBlock;

@end
