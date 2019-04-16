//
//  GWScrollCollecttionView.m
//  GWScrollView
//
//  Created by zdwx on 2019/4/3.
//  Copyright © 2019 gw. All rights reserved.
//

#import "GWScrollCollectionView.h"
#import "GWScrollCollectionCell.h"
#import "UIImageView+WebCache.h"
@interface GWScrollCollectionView()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong ,nonatomic) NSTimer *timer;
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
    _infiniteLoop = YES;
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


#pragma mark - 定时器
//创建定时器
- (void)setupTimer{
    // 创建定时器前先停止定时器，不然会出现僵尸定时器，导致轮播频率错误
    [self invalidateTimer];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:self.autoScrollTimeInterval target:self selector:@selector(automaticScroll) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}
//销毁定时器
- (void)invalidateTimer
{
    [_timer invalidate];
    _timer = nil;
}

#pragma mark - 页面滚动相关事件
//自动滚动
- (void)automaticScroll{
    if (!self.GW_ImagesArray.count) return;
    int currentIndex = [self currentIndex];
    int targetIndex = currentIndex + 1;
    [self scrollToIndex:targetIndex];
}

//滚动到指定位置
- (void)scrollToIndex:(int)targetIndex
{
    if (targetIndex >= self.GW_ImagesArray.count) {
        if (self.infiniteLoop) {
            targetIndex = self.GW_ImagesArray.count * 0.5;
            [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        }
        return;
    }
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}

//获取当前位置
- (int)currentIndex
{
    if (_collectionView.bounds.size.width == 0 || _collectionView.bounds.size.height == 0) {
        return 0;
    }
    
    int index = 0;
    if (_flowLayout.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
        index = (_collectionView.contentOffset.x + _flowLayout.itemSize.width * 0.5) / _flowLayout.itemSize.width;
    } else {
        index = (_collectionView.contentOffset.y + _flowLayout.itemSize.height * 0.5) / _flowLayout.itemSize.height;
    }
    
    return MAX(0, index);
}

- (NSInteger)pageControlIndexWithCurrentCellIndex:(NSInteger)index{
    return index % self.GW_ImagesArray.count;
}

#pragma mark - UI
- (void)startLoading{
    
    [self createCollectionView];
    [self createPageControl];
    [self initData];
}

#pragma mark - 初始化数据
- (void)initData{
    if (_GW_ImagesArray.count != 0)
    {
        if (self.data_Type == GWScrollCollectionView_dataType_Image) {
            UIImage *firstImage=[_GW_ImagesArray objectAtIndex:0];
            UIImage *lastImage=[_GW_ImagesArray lastObject];
            [_GW_ImagesArray insertObject:lastImage atIndex:0];
            [_GW_ImagesArray addObject:firstImage];
        }else{
            
            NSString *firstImageUrl=[_GW_ImagesArray objectAtIndex:0];
            NSString *lastImageUrl=[_GW_ImagesArray lastObject];
            [_GW_ImagesArray insertObject:lastImageUrl atIndex:0];
            [_GW_ImagesArray addObject:firstImageUrl];
        }
//        for (NSInteger i = 0; i < _slideImagesArray.count; i++) {
//            GWScrollImageView *slideImage = [[GWScrollImageView alloc] init];
//
//            if (self.data_Type == GWScrollCollectionView_dataType_Url) {
//                NSString *iUrl = _slideImagesArray[i];
//                iUrl = [iUrl stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//                iUrl = [iUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
//                [slideImage sd_setImageWithURL:[NSURL URLWithString:iUrl] placeholderImage: self.defaultImage ? self.defaultImage : [UIImage imageNamed: @"scrollImageDefault"]];
//            }else if(self.data_Type == GWScrollCollectionView_dataType_Image){
//                slideImage.image = _slideImagesArray[i];
//            }else{
//                slideImage.image = [UIImage imageNamed:_slideImagesArray[i]];
//            }
//            if (!(i == 0||i==_slideImagesArray.count-1)) {
//                slideImage.tag = i-1;
//            }
//
//            slideImage.frame = CGRectMake(_scrollView.frame.size.width * i, 0, _scrollView.frame.size.width, _scrollView.frame.size.height);
//            [slideImage addTarget:self action:@selector(ImageClick:)];
//            [_scrollView addSubview:slideImage];// 首页是第0页,默认从第1页开始的。所以+_scrollView.frame.size.width
//        }
//
//        [_scrollView setContentSize:CGSizeMake(_scrollView.frame.size.width * _slideImagesArray.count, _scrollView.frame.size.height)]; //+上第1页和第4页  原理：4-[1-2-3-4]-1
//        [_scrollView setContentOffset:CGPointMake(0, 0)];
//        [_scrollView scrollRectToVisible:CGRectMake(_scrollView.frame.size.width, 0, _scrollView.frame.size.width, _scrollView.frame.size.height) animated:NO];
//
//        if (self.slideImagesArray.count>3) {
//            if (!self.withoutAutoScroll) {
//                if (!self.autoTime) {
//                    self.autoTime = [NSNumber numberWithFloat:2.0f];
//                }
//
//                if (_myTimer)
//                {
//                    [self stopTimer];
//                }
//
//                _myTimer = [NSTimer timerWithTimeInterval:[self.autoTime floatValue] target:self selector:@selector(runTimePage)userInfo:nil repeats:YES];
//
//                [[NSRunLoop  currentRunLoop] addTimer:_myTimer forMode:NSDefaultRunLoopMode];
//            }
        }
}

#pragma mark - UICollectionViewDataSource
    
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.GW_ImagesArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    GWScrollCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([GWScrollCollectionCell class]) forIndexPath:indexPath];
    
    long itemIndex = [self pageControlIndexWithCurrentCellIndex:indexPath.item];
    
    if ([self.delegate respondsToSelector:@selector(GWScrollCollectionViewCell:forIndex:ScrollCollectionView:)] &&
        [self.delegate respondsToSelector:@selector(GWScrollCollectionViewCellClassForScrollCollectionView:)]) {
        [self.delegate GWScrollCollectionViewCell:cell forIndex:itemIndex ScrollCollectionView:self];
        return cell;
    }else if ([self.delegate respondsToSelector:@selector(GWScrollCollectionViewCell:forIndex:ScrollCollectionView:)] &&
              [self.delegate respondsToSelector:@selector(GWScrollCollectionViewCellNibForScrollCollectionView:)]) {
        [self.delegate GWScrollCollectionViewCell:cell forIndex:itemIndex ScrollCollectionView:self];
        return cell;
    }
    
    NSString *imagePath = self.GW_ImagesArray[itemIndex];
    
    if (!self.onlyDisplayText && [imagePath isKindOfClass:[NSString class]]) {
        if ([imagePath hasPrefix:@"http"]) {
            [cell.imageView sd_setImageWithURL:[NSURL URLWithString:imagePath] placeholderImage:self.placeholderImage];
        } else {
            UIImage *image = [UIImage imageNamed:imagePath];
            if (!image) {
                image = [UIImage imageWithContentsOfFile:imagePath];
            }
            cell.imageView.image = image;
        }
    } else if (!self.onlyDisplayText && [imagePath isKindOfClass:[UIImage class]]) {
        cell.imageView.image = (UIImage *)imagePath;
    }
    
    if (self.GW_TitleArray.count && itemIndex < self.GW_TitleArray.count) {
        cell.titleLabel.text = self.GW_TitleArray[itemIndex];
    }
    
    if (!cell.hasConfigured) {
        cell.titleLabel.backgroundColor = self.titleLabelBackgroundColor;
//        cell.titleLabel. = self.titleLabelHeight;
//        cell.titleLabelTextAlignment = self.titleLabelTextAlignment;
//        cell.titleLabelTextColor = self.titleLabelTextColor;
//        cell.titleLabelTextFont = self.titleLabelTextFont;
        cell.hasConfigured = YES;
        cell.imageView.contentMode = self.bannerImageViewContentMode;
        cell.clipsToBounds = YES;
        cell.onlyDisplayText = self.onlyDisplayText;
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(GWScrollCollectionView:didSelectItemIndex:)]) {
        [self.delegate GWScrollCollectionView:self didSelectItemIndex:[self pageControlIndexWithCurrentCellIndex:indexPath.item]];
    }
    if (self.GWScrollCollectionViewSelectAction) {
        self.GWScrollCollectionViewSelectAction([self pageControlIndexWithCurrentCellIndex:indexPath.item]);
    }
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

#pragma mark - PageControl
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
    _pageControl.numberOfPages = [self.GW_ImagesArray count];
    _pageControl.currentPage = 0;
    if(self.GW_ImagesArray.count < 2){
        _pageControl.hidden = YES;
    }
    [_pageControl addTarget:self action:@selector(runTimePageAction:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:_pageControl];
}

#pragma mark - getter
- (NSMutableArray *)GW_ImagesArray{
    if (!_GW_ImagesArray) {
        _GW_ImagesArray = [[NSMutableArray alloc] init];
    }
    return _GW_ImagesArray;
}

- (NSMutableArray *)GW_TitleArray{
    if (!_GW_TitleArray) {
        _GW_TitleArray = [[NSMutableArray alloc] init];
    }
    return _GW_TitleArray;
}
@end
