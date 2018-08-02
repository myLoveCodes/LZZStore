//
//  UITableView+DequeueReusableCell.h
//  LZZStore
//
//  Created by LZZ on 2018/7/17.
//  Copyright © 2018年 罗志忠. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (DequeueReusableCell)

-(UITableViewCell *)dequeueReusableCellWithClass:(Class)cla;
-(UITableViewHeaderFooterView *)dequeueReusableHeaderFooterViewWithClass:(Class)cla;

@end
