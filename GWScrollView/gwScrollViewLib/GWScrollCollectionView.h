//
//  GWScrollCollecttionView.h
//  GWScrollView
//
//  Created by zdwx on 2019/4/3.
//  Copyright © 2019 gw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GWPageControl.h"
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,GWScrollCollectionView_dataType) {
    //    图片路径(本地图片名称-默认)
    GWScrollCollectionView_dataType_Str = 0,
    //    请求地址(图片url)
    GWScrollCollectionView_dataType_Url = 1,
    //    图片（本地UIImage对象）
    GWScrollCollectionView_dataType_Image = 2
};

@class GWScrollCollectionView;
@protocol GWScrollCollectionViewDelegate <NSObject>
@optional

- (void)GWScrollCollectionView:(GWScrollCollectionView *)view didSelectItemIndex:(NSInteger)itemIndex;

#pragma mark - 自定义cell
/** 如果你需要自定义cell样式，请在实现此代理方法返回你的自定义cell的class。 */
- (Class)GWScrollCollectionViewCellClassForScrollCollectionView:(GWScrollCollectionView *)view;

/** 如果你需要自定义cell样式，请在实现此代理方法返回你的自定义cell的Nib。 */
- (UINib *)GWScrollCollectionViewCellNibForScrollCollectionView:(GWScrollCollectionView *)view;

/** 如果你自定义了cell样式，请在实现此代理方法为你的cell填充数据以及其它一系列设置 */
- (void)GWScrollCollectionViewCell:(UICollectionViewCell *)cell forIndex:(NSInteger)index ScrollCollectionView:(GWScrollCollectionView *)view;

@end

typedef void (^GWScrollCollectionViewSelect)(NSInteger select);
@interface GWScrollCollectionView : UIView

@property (nonatomic, copy) GWScrollCollectionViewSelect GWScrollCollectionViewSelectAction; // 图片点击事件
#pragma mark - dataSource
/** 存储图片的地址 */
@property (strong ,nonatomic) NSMutableArray *GW_ImagesArray;
/** title数据 */
@property (strong ,nonatomic) NSMutableArray *GW_TitleArray;

#pragma mark - CollectionView
/** 显示图片的collectionView */
@property (strong ,nonatomic) UICollectionView *collectionView;
/** collectionView布局 */
@property (strong ,nonatomic) UICollectionViewFlowLayout *flowLayout;
//图片类型
@property (assign, nonatomic) GWScrollCollectionView_dataType data_Type;
/** 自动滚动间隔时间,默认2s */
@property (assign, nonatomic) CGFloat autoScrollTimeInterval;
/** 是否自动滚动,默认Yes */
@property (assign, nonatomic) BOOL autoScroll;
/** 是否无限循环,默认Yes */
@property (assign, nonatomic) BOOL infiniteLoop;
/** 图片滚动方向，默认为水平滚动 */
@property (assign, nonatomic) UICollectionViewScrollDirection scrollDirection;
/** CollectionView高度 默认GWScrollCollectionView高度 */
@property (assign, nonatomic) CGFloat scrollHeight;

#pragma mark - 自定义样式 - bannerImage
/** 轮播图片的ContentMode，默认为 UIViewContentModeScaleToFill */
@property (assign, nonatomic) UIViewContentMode bannerImageViewContentMode;
/** 占位图，用于网络未加载到图片时 */
@property (strong ,nonatomic) UIImage *placeholderImage;

#pragma mark - 自定义样式 - titleLabel
/** 只展示文字轮播 */
@property (assign, nonatomic) BOOL onlyDisplayText;
/** 轮播文字label字体颜色 */
@property (strong ,nonatomic) UIColor *titleLabelTextColor;
/** 轮播文字label字体大小 */
@property (strong ,nonatomic) UIFont  *titleLabelTextFont;
/** 轮播文字label背景颜色 */
@property (strong ,nonatomic) UIColor *titleLabelBackgroundColor;
/** 轮播文字label高度 */
@property (assign, nonatomic) CGFloat titleLabelHeight;
/** 轮播文字label对齐方式 */
@property (assign, nonatomic) NSTextAlignment titleLabelTextAlignment;

#pragma mark - 自定义样式 - PageControl
/** pageControl */
@property (strong ,nonatomic) GWPageControl *pageControl;
/** pageControl高度 默认10 */
@property (assign, nonatomic) CGFloat pageControlHeight;
/** 是否显示分页控件 */
@property (assign, nonatomic) BOOL showPageControl;
/** 是否在只有一张图时隐藏pagecontrol，默认为YES */
@property (assign, nonatomic) BOOL hidesForSinglePage;
/** 分页控件距离轮播图的底部间距（在默认间距基础上）的偏移量 */
@property (assign, nonatomic) CGFloat pageControlBottomOffset;
/** 分页控件距离轮播图的底部间距（在默认间距基础上）的偏移量 */
@property (assign, nonatomic) CGFloat pageControlRightOffset;
/** page当前颜色 */
@property (strong ,nonatomic) UIColor *pageControlCurrentPageIndicatorTintColor;
/** page默认颜色 */
@property (nonatomic, strong) UIColor *PageControlPageIndicatorTintColor;
/** page小圆标宽度 默认8 */
@property (assign, nonatomic)CGFloat pageWidth;
/** page小圆标高度 默认8 */
@property (assign, nonatomic)CGFloat pageHeight;
/** page小圆标间距 默认5 */
@property (assign, nonatomic)CGFloat pageMagrin;
/** pageControl底部图片(如果需要改变图片，pageImageStr和currentPageImageStr必须同时实现) */
@property (copy,nonatomic)NSString *pageImageStr;
/** pageControl当前图片(如果需要改变图片，pageImageStr和currentPageImageStr必须同时实现) */
@property (copy,nonatomic)NSString *currentPageImageStr;



@property (weak, nonatomic) id<GWScrollCollectionViewDelegate> delegate;
/** 页面数据初始化（必须实现） */
- (void)startLoading;


@end

NS_ASSUME_NONNULL_END
