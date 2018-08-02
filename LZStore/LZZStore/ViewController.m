//
//  ViewController.m
//  LZZStore
//
//  Created by LZZ on 2018/7/16.
//  Copyright © 2018年 罗志忠. All rights reserved.
//

#import "ViewController.h"

#import <UMShare/UMShare.h>

#import <Tangram/TangramDefaultItemModelFactory.h>
#import <Tangram/TangramDefaultDataSourceHelper.h>
#import <Tangram/TangramView.h>

@interface ViewController () <TangramViewDatasource>

@property (nonatomic,strong)NSArray *layoutModelArray;
@property (nonatomic,strong)NSArray *layoutArray;
@property (nonatomic, strong) TangramBus *tangramBus;

@property (nonatomic,strong)TangramView *tangramView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self loadMockContent];
    [self registEvent];
    [self.tangramView reloadData];
}
-(void)loadMockContent{
    [TangramDefaultItemModelFactory registElementType:@"1" className:@"TangramSingleImageElement"];
    [TangramDefaultItemModelFactory registElementType:@"2" className:@"TangramSimpleTextElement"];
    
    //获取数据
    
    NSString *mockDataString = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"TangramMock" ofType:@"json"] encoding:NSUTF8StringEncoding error:nil];
    NSData *data = [mockDataString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData: data options:NSJSONReadingAllowFragments error:nil];
    self.layoutModelArray = [[dict objectForKey:@"data"] objectForKey:@"cards"];
    self.layoutArray = [TangramDefaultDataSourceHelper layoutsWithArray:self.layoutModelArray tangramBus:self.tangramBus];
}
- (void)registEvent{
    [self.tangramBus registerAction:@"responseToClickEvent:" ofExecuter:self onEventTopic:@"jumpAction"];
}

//返回layout个数
- (NSUInteger)numberOfLayoutsInTangramView:(TangramView *)view
{
    return self.layoutModelArray.count;
}
//返回layout的实例
- (UIView<TangramLayoutProtocol> *)layoutInTangramView:(TangramView *)view atIndex:(NSUInteger)index
{
    return [self.layoutArray objectAtIndex:index];
}
//返回某一个layout中itemModel的个数
- (NSUInteger)numberOfItemsInTangramView:(TangramView *)view forLayout:(UIView<TangramLayoutProtocol> *)layout
{
    return layout.itemModels.count;
}
//返回layout中指定index的itemModel实例
- (NSObject<TangramItemModelProtocol> *)itemModelInTangramView:(TangramView *)view forLayout:(UIView<TangramLayoutProtocol> *)layout atIndex:(NSUInteger)index
{
    return [layout.itemModels objectAtIndex:index];;
}
//根据Model生成View
//以上的方法在调用Tangram的reload方法后就会执行，而这个方法是按需加载
- (UIView *)itemInTangramView:(TangramView *)view withModel:(NSObject<TangramItemModelProtocol> *)model forLayout:(UIView<TangramLayoutProtocol> *)layout atIndex:(NSUInteger)index
{
    //先尝试找可以复用的View，有的话就赋值，没有的话就生成一个
    UIView *reuseableView = [view dequeueReusableItemWithIdentifier:model.reuseIdentifier];
    
    if (reuseableView) {
        reuseableView =  [TangramDefaultDataSourceHelper refreshElement:reuseableView byModel:model];
    }
    else
    {
        reuseableView =  [TangramDefaultDataSourceHelper elementByModel:model];
    }
    return reuseableView;
}


- (TangramBus *)tangramBus{
    if (nil == _tangramBus) {
        _tangramBus = [[TangramBus alloc]init];
    }
    return _tangramBus;
}
-(TangramView *)tangramView
{
    if (nil == _tangramView) {
        _tangramView = [[TangramView alloc]init];
        _tangramView.frame = self.view.bounds;
        //要设置datasouce delegate
        [_tangramView setDataSource:self];
        _tangramView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_tangramView];
    }
    return _tangramView;
}


@end
