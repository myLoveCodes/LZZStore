//
//  UITableView+DequeueReusableCell.m
//  LZZStore
//
//  Created by LZZ on 2018/7/17.
//  Copyright © 2018年 罗志忠. All rights reserved.
//

#import "UITableView+DequeueReusableCell.h"

@implementation UITableView (DequeueReusableCell)

-(UITableViewCell *)dequeueReusableCellWithClass:(Class)cla{
    
    if (![cla isKindOfClass:[UITableViewCell class]]) {
        return [UITableViewCell new];
    }
    
    NSString *cellID = NSStringFromClass(cla);
    UITableViewCell *cell = [self dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[cla alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}

-(UITableViewHeaderFooterView *)dequeueReusableHeaderFooterViewWithClass:(Class)cla{
    
    if (![cla isKindOfClass:[UITableViewHeaderFooterView class]]) {
        return [UITableViewHeaderFooterView new];
    }
    
    NSString *headerFooterViewID = NSStringFromClass(cla);
    UITableViewHeaderFooterView *headerFooterView = [self dequeueReusableHeaderFooterViewWithIdentifier:headerFooterViewID];
    if (headerFooterView == nil) {
        headerFooterView = [[cla alloc] initWithReuseIdentifier:headerFooterViewID];
    }
    return headerFooterView;
}

@end
