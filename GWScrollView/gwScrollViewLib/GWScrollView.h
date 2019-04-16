//
//  gwScrollView.h
//  GWScrollView
//
//  Created by gw on 2017/1/22.
//  Copyright © 2017年 gw. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,dataType) {
    //    图片路径(默认)
    dataType_Str = 0,
    //    请求地址
    dataType_Url = 1,
    //    图片
    dataType_Image = 2
};

typedef void (^gwScrollViewSelectBlock)(NSInteger select);
@interface GWScrollView : UIView<UIScrollViewDelegate>

///////dataSource
@property (nonatomic, strong) NSMutableArray *slideImagesArray; //存储图片的地址

@property (assign, nonatomic)dataType data_Type;//存储的类型（默认是图片路径）
///////scrollView
@property (nonatomic, copy) gwScrollViewSelectBlock gwEcrollViewSelectAction; // 图片点击事件
@property (nonatomic) BOOL showPageControl; // 是否显示pageControl, 默认为NO
@property (assign, nonatomic)CGFloat scrollHeight;//定义scroll高度
@property (nonatomic) BOOL withoutAutoScroll; // 是否自动滚动
@property (nonatomic) NSNumber *autoTime; //滚动时间
@property (nonatomic, strong) UIImage *defaultImage; //placeholderImage

///////pageControl
@property (assign,nonatomic)CGFloat pageControlHeight;//pageControl高度
@property (nonatomic, strong) UIColor *pageControlCurrentPageIndicatorTintColor;//page当前颜色
@property (nonatomic, strong) UIColor *PageControlPageIndicatorTintColor;//page默认颜色


////////自定义page按钮
@property (assign, nonatomic)CGFloat pageWidth;//page图片宽度
@property (assign, nonatomic)CGFloat pageHeight;//page图片高度
@property (assign, nonatomic)CGFloat pageMagrin;//page图片间距
@property (copy,nonatomic)NSString *pageImageStr;//pageControl底部图片(如果需要改变图片，pageImageStr和currentPageImageStr必须同时实现)
@property (copy,nonatomic)NSString *currentPageImageStr;//pageControl当前图片(如果需要改变图片，pageImageStr和currentPageImageStr必须同时实现)

////////action
- (void)startLoading; //加载初始化（必须实现）

- (void)stopTimer;//销毁定时器
@end
