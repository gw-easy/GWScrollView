//
//  GWScrollCollecttionView.m
//  GWScrollView
//
//  Created by zdwx on 2019/4/3.
//  Copyright © 2019 gw. All rights reserved.
//

#import "GWScrollCollectionView.h"
#import "GWScrollCollectionCell.h"

@interface GWScrollCollectionView()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation GWScrollCollectionView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setDefSetting];
    }
    return self;
}

#pragma mark - 基本设置
- (void)setDefSetting{
    //    _pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    _autoScrollTimeInterval = 2.0;
    _titleLabelTextColor = [UIColor whiteColor];
    _titleLabelTextFont= [UIFont systemFontOfSize:14];
    _titleLabelBackgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    _titleLabelHeight = 30;
    _titleLabelTextAlignment = NSTextAlignmentLeft;
    _autoScroll = YES;
    //    _infiniteLoop = YES;
    _showPageControl = YES;
    //    _pageControlDotSize = kCycleScrollViewInitialPageControlDotSize;
    _pageControlHeight = 10;
    _pageControlBottomOffset = 0;
    _pageControlRightOffset = 0;
    _pageWidth = 8;
    _pageHeight = 8;
    _pageMagrin = 5;
    //    _pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
    _hidesForSinglePage = YES;
    _pageControlCurrentPageIndicatorTintColor = [UIColor whiteColor];
    _PageControlPageIndicatorTintColor = [UIColor lightGrayColor];
    _bannerImageViewContentMode = UIViewContentModeScaleToFill;
    _scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.backgroundColor = [UIColor lightGrayColor];
}



#pragma mark - UI
- (void)startLoading{
    
    [self createCollectionView];
    [self createPageControl];
    
}


#pragma mark - CollectionView
- (void)createCollectionView{
    if (_collectionView) {
        [_collectionView removeFromSuperview];
        _collectionView = nil;
    }
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:[self createFlowLayout]];
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.pagingEnabled = YES;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    [_collectionView registerClass:[GWScrollCollectionCell class] forCellWithReuseIdentifier:NSStringFromClass([GWScrollCollectionCell class])];
    
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.scrollsToTop = NO;
    [self addSubview:_collectionView];
}

- (UICollectionViewFlowLayout *)createFlowLayout{
    if (_flowLayout) {
        return _flowLayout;
    }
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.minimumLineSpacing = 0;
    _flowLayout.scrollDirection = _scrollDirection;
    return _flowLayout;
}

- (void)createPageControl{
    if (_pageControl) {
        [_pageControl removeFromSuperview];
        _pageControl = nil;
    }
    if (!_showPageControl) {
        return;
    }
//    CGFloat pageBottom = self.pageControlHeight?self.pageControlHeight:10;
    _pageControl = [[GWPageControl alloc] initWithFrame:CGRectMake(0,self.frame.size.height-_pageControlBottomOffset-_pageControlHeight , self.frame.size.width, _pageControlHeight)];
    _pageControl.pageWidth = self.pageWidth;
    _pageControl.pageHeight = self.pageHeight;
    _pageControl.pageMagrin = self.pageMagrin;
//
    if (self.pageImageStr.length>0 && self.currentPageImageStr.length>0) {
        //两张图片必须同时存在，否则报错
        _pageControl.pageImageStr = self.pageImageStr;
        _pageControl.currentPageImageStr = self.currentPageImageStr;
    }
    [_pageControl setCurrentPageIndicatorTintColor:self.pageControlCurrentPageIndicatorTintColor ? self.pageControlCurrentPageIndicatorTintColor : [UIColor purpleColor]];
    [_pageControl setPageIndicatorTintColor:self.PageControlPageIndicatorTintColor ? self.PageControlPageIndicatorTintColor : [UIColor grayColor]];
    _pageControl.numberOfPages = [_slideImagesArray count];
    _pageControl.currentPage = 0;
    if(self.slideImagesArray.count < 2){
        _pageControl.hidden = YES;
    }
    [_pageControl addTarget:self action:@selector(runTimePageAction:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:_pageControl];
}

@end
