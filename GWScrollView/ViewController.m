//
//  ViewController.m
//  GWScrollView
//
//  Created by gw on 2017/1/22.
//  Copyright © 2017年 gw. All rights reserved.
//

#import "ViewController.h"
#import "gwScrollView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self createBannerUI];
    [self createBannerUI2];
}

#pragma mark - banner
//自定义page样式
- (void)createBannerUI{
    gwScrollView *_sv = [[gwScrollView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 200)];
    _sv.slideImagesArray = [NSMutableArray arrayWithArray:@[@"image1",@"image2",@"image3"]];
    _sv.showPageControl = YES;
    _sv.pageImageStr = @"square-tb4";
    _sv.currentPageImageStr = @"square-tb3";
    _sv.pageControlScale = 0.5;
    _sv.pageControlBottom = 20;
    _sv.gwEcrollViewSelectAction = ^(NSInteger tag){
        //点击图片事件
    };
    [_sv startLoading];
    [self.view addSubview:_sv];
    
}

- (void)createBannerUI2{
    gwScrollView *_sv = [[gwScrollView alloc] initWithFrame:CGRectMake(0, 300, [UIScreen mainScreen].bounds.size.width, 200)];
    _sv.slideImagesArray = [NSMutableArray arrayWithArray:@[@"image1",@"image2",@"image3"]];
    _sv.showPageControl = YES;
    _sv.autoTime = @(5);
    _sv.pageControlCurrentPageIndicatorTintColor = [UIColor greenColor];
    _sv.PageControlPageIndicatorTintColor = [UIColor grayColor];
    _sv.gwEcrollViewSelectAction = ^(NSInteger tag){
        
    };
    [_sv startLoading];
    [self.view addSubview:_sv];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
