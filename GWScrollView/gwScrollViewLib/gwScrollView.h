//
//  gwScrollView.h
//  GWScrollView
//
//  Created by gw on 2017/1/22.
//  Copyright © 2017年 gw. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^gwScrollViewSelectBlock)(NSInteger);
@interface gwScrollView : UIView<UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *slideImagesArray; //存储图片的地址
@property (nonatomic, copy) gwScrollViewSelectBlock gwEcrollViewSelectAction; // 图片点击事件
@property (nonatomic) BOOL showPageControl; // 是否显示pageControl, 默认为NO
@property (nonatomic) BOOL withoutAutoScroll; // 是否自动滚动
@property (nonatomic) NSNumber *autoTime; //滚动时间
@property (assign,nonatomic)BOOL urlImageBool;//是否是网络加载图片，默认是NO

@property (copy,nonatomic)NSString *pageImageStr;//pageControl底部图片
@property (copy,nonatomic)NSString *currentPageImageStr;//pageControl当前图片

@property (assign,nonatomic)CGFloat pageControlScale;//pageControl缩放倍数
@property (assign,nonatomic)CGFloat pageControlBottom;//pageControl距离scroll底部的距离


@property (nonatomic, strong) UIColor *pageControlCurrentPageIndicatorTintColor;
@property (nonatomic, strong) UIColor *PageControlPageIndicatorTintColor;

@property (nonatomic, strong) UIImage *defaultIamge;
//@property (nonatomic, strong) NSMutableArray *imageArr;

- (void)startLoading; //加载初始化（必须实现）

- (void)stopTimer;//销毁定时器
@end
