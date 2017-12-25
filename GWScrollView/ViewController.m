//
//  ViewController.m
//  GWScrollView
//
//  Created by gw on 2017/1/22.
//  Copyright © 2017年 gw. All rights reserved.
//

#import "ViewController.h"
#import "GWScrollView.h"
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
    GWScrollView *_sv = [[GWScrollView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 200)];
    _sv.slideImagesArray = [NSMutableArray arrayWithArray:@[@"image1",@"image2",@"image3",@"image3",@"image3",@"image3"]];
    _sv.showPageControl = YES;
    _sv.pageImageStr = @"square-tb4";
    _sv.currentPageImageStr = @"square-tb3";
    _sv.pageControlBottom = 20;
    _sv.pageWidth = 25;
    _sv.pageHeight = 5;
    _sv.pageMagrin = 10;
    _sv.gwEcrollViewSelectAction = ^(NSInteger tag){
        //点击图片事件
        if (tag == 0) {
            NSLog(@"111");
        }else if (tag == 1){
            NSLog(@"222");
        }else{
            NSLog(@"333");
        }
    };
    [_sv startLoading];
    [self.view addSubview:_sv];
    
}

- (void)createBannerUI2{
    GWScrollView *_sv = [[GWScrollView alloc] initWithFrame:CGRectMake(0, 300, [UIScreen mainScreen].bounds.size.width, 200)];
    _sv.slideImagesArray = [NSMutableArray arrayWithArray:@[@"image1",@"image2",@"image3"]];
    _sv.showPageControl = YES;
    _sv.autoTime = @(3);
    _sv.pageControlCurrentPageIndicatorTintColor = [UIColor greenColor];
    _sv.PageControlPageIndicatorTintColor = [UIColor grayColor];
    _sv.pageImageStr = @"square-tb4";
//    _sv.currentPageImageStr = @"yezi.gif";
    _sv.currentPageImageStr = @"小太阳.gif";
    _sv.pageWidth = 30;
    _sv.pageHeight = 30;
    _sv.pageMagrin = 15;
    _sv.pageControlBottom = 40;
    _sv.gwEcrollViewSelectAction = ^(NSInteger tag){
        if (tag == 0) {
            NSLog(@"111");
        }else if (tag == 1){
            NSLog(@"222");
        }else{
            NSLog(@"333");
        }

    };
    [_sv startLoading];
    [self.view addSubview:_sv];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
