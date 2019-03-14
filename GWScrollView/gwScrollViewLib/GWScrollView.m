//
//  gwScrollView.m
//  GWScrollView
//
//  Created by gw on 2017/1/22.
//  Copyright © 2017年 gw. All rights reserved.
//

#import "GWScrollView.h"
#import "UIImageView+WebCache.h"
#import "GWScrollImageView.h"
#import "GWPageControl.h"
@interface GWScrollView()
{
    NSInteger _tempPage;
}
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) GWPageControl *pageControl;
@property (nonatomic, strong) NSTimer *myTimer;
@end

@implementation GWScrollView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.slideImagesArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)startLoading
{
    [self _initScrollView];
}


#pragma mark -scrollView Delegate-
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWith = self.scrollView.frame.size.width;
    NSInteger page = floor((self.scrollView.contentOffset.x - pageWith/([_slideImagesArray count]))/pageWith) + 1;
    page --; //默认从第二页开始
    self.pageControl.currentPage = page;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWith = self.scrollView.frame.size.width;
    NSInteger currentPage = floor((self.scrollView.contentOffset.x - pageWith/ [_slideImagesArray count]) / pageWith) + 1;
    if (currentPage == 0) {
        [self.scrollView scrollRectToVisible:CGRectMake(_scrollView.frame.size.width* ([_slideImagesArray count]-2), 0, _scrollView.frame.size.width, _scrollView.frame.size.height) animated:NO];
    }else if(currentPage == _slideImagesArray.count-1){
        [self.scrollView scrollRectToVisible:CGRectMake(_scrollView.frame.size.width, 0, _scrollView.frame.size.width, _scrollView.frame.size.height) animated:NO];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if (!self.withoutAutoScroll){
        if (_tempPage == 0) {
            [self.scrollView scrollRectToVisible:CGRectMake(_scrollView.frame.size.width* ([_slideImagesArray count]-2), 0, _scrollView.frame.size.width, _scrollView.frame.size.height) animated:NO];
        }else if(_tempPage == _slideImagesArray.count-2){
            [self.scrollView scrollRectToVisible:CGRectMake(_scrollView.frame.size.width, 0, _scrollView.frame.size.width, _scrollView.frame.size.height) animated:NO];
        }
    }
}

#pragma mark -PageControl Method-
- (void)turnPage:(NSInteger)page
{
    _tempPage = page;
    [self.scrollView scrollRectToVisible:CGRectMake(_scrollView.frame.size.width * (page + 1), 0, _scrollView.frame.size.width, _scrollView.frame.size.height) animated:YES];
}

#pragma mark -定时器 Method-
- (void)runTimePage
{
    NSInteger page = self.pageControl.currentPage;
    page ++;
    [self turnPage:page];
}

- (void)runTimePageAction:(UIPageControl *)sender{
    [self.scrollView scrollRectToVisible:CGRectMake(_scrollView.frame.size.width * (sender.currentPage + 1), 0, _scrollView.frame.size.width, _scrollView.frame.size.height) animated:NO];
}

#pragma mark -private Methods-
- (void)_initScrollView
{
    if (_scrollView) {
		
		[_scrollView removeFromSuperview];
		_scrollView = nil;

    }
    _scrollView = ({
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        if (self.scrollHeight) {
            scrollView.frame = CGRectMake(0, 0, self.bounds.size.width, self.scrollHeight);
        }
        scrollView.bounces = YES;
        scrollView.pagingEnabled = YES;
        scrollView.delegate = self;
        scrollView.userInteractionEnabled = YES;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        if(self.slideImagesArray.count < 2){
            scrollView.scrollEnabled = NO;
        }
        [self addSubview:scrollView];
        scrollView;
    });
    
    if (_pageControl) {
        [_pageControl removeFromSuperview];
        _pageControl = nil;
    }
    
    if (self.showPageControl) {
        _pageControl = ({
            CGFloat pageBottom = self.pageControlHeight?self.pageControlHeight:10;
            GWPageControl *pageControl = [[GWPageControl alloc] initWithFrame:CGRectMake(0,self.frame.size.height-pageBottom , self.frame.size.width, pageBottom)];
            pageControl.pageWidth = self.pageWidth;
            pageControl.pageHeight = self.pageHeight;
            pageControl.pageMagrin = self.pageMagrin;

            if (self.pageImageStr.length>0 && self.currentPageImageStr.length>0) {
                //两张图片必须同时存在，否则报错
                pageControl.pageImageStr = self.pageImageStr;
                pageControl.currentPageImageStr = self.currentPageImageStr;
            }

            
            [pageControl setCurrentPageIndicatorTintColor:self.pageControlCurrentPageIndicatorTintColor ? self.pageControlCurrentPageIndicatorTintColor : [UIColor purpleColor]];
            [pageControl setPageIndicatorTintColor:self.PageControlPageIndicatorTintColor ? self.PageControlPageIndicatorTintColor : [UIColor grayColor]];
            pageControl.numberOfPages = [_slideImagesArray count];
            pageControl.currentPage = 0;
            if(self.slideImagesArray.count < 2){
                pageControl.hidden = YES;
            }
            [pageControl addTarget:self action:@selector(runTimePageAction:) forControlEvents:UIControlEventValueChanged];
            [self addSubview:pageControl];
            pageControl;
        });
    }
	
	if (_slideImagesArray.count != 0)
	{
        if (self.data_Type == dataType_Image) {
            UIImage *firstImage=[_slideImagesArray objectAtIndex:0];
            UIImage *lastImage=[_slideImagesArray lastObject];
            [_slideImagesArray insertObject:lastImage atIndex:0];
            [_slideImagesArray addObject:firstImage];
        }else{
            
            NSString *firstImageUrl=[_slideImagesArray objectAtIndex:0];
            NSString *lastImageUrl=[_slideImagesArray lastObject];
            [_slideImagesArray insertObject:lastImageUrl atIndex:0];
            [_slideImagesArray addObject:firstImageUrl];
        }
        for (NSInteger i = 0; i < _slideImagesArray.count; i++) {
            GWScrollImageView *slideImage = [[GWScrollImageView alloc] init];
            slideImage.backgroundColor = [UIColor redColor];
            if (self.data_Type == dataType_Url) {
                [slideImage sd_setImageWithURL:[NSURL URLWithString:_slideImagesArray[i]] placeholderImage: self.defaultImage ? self.defaultImage : [UIImage imageNamed: @"scrollImageDefault"]];
            }else if(self.data_Type == dataType_Image){
                slideImage.image = _slideImagesArray[i];
            }else{
                slideImage.image = [UIImage imageNamed:_slideImagesArray[i]];
            }
            if (!(i == 0||i==_slideImagesArray.count-1)) {
                slideImage.tag = i-1;
            }
            
            slideImage.frame = CGRectMake(_scrollView.frame.size.width * i, 0, _scrollView.frame.size.width, _scrollView.frame.size.height);
            [slideImage addTarget:self action:@selector(ImageClick:)];
            [_scrollView addSubview:slideImage];// 首页是第0页,默认从第1页开始的。所以+_scrollView.frame.size.width
        }
		
		[_scrollView setContentSize:CGSizeMake(_scrollView.frame.size.width * _slideImagesArray.count, _scrollView.frame.size.height)]; //+上第1页和第4页  原理：4-[1-2-3-4]-1
		[_scrollView setContentOffset:CGPointMake(0, 0)];
		[_scrollView scrollRectToVisible:CGRectMake(_scrollView.frame.size.width, 0, _scrollView.frame.size.width, _scrollView.frame.size.height) animated:NO];
        
        if (self.slideImagesArray.count>3) {
		if (!self.withoutAutoScroll) {
			if (!self.autoTime) {
				self.autoTime = [NSNumber numberWithFloat:2.0f];
			}
			
			if (_myTimer)
			{
                [self stopTimer];
			}
			
			_myTimer = [NSTimer timerWithTimeInterval:[self.autoTime floatValue] target:self selector:@selector(runTimePage)userInfo:nil repeats:YES];
			
			[[NSRunLoop  currentRunLoop] addTimer:_myTimer forMode:NSDefaultRunLoopMode];
		}
	}
}
}
- (void)ImageClick:(UIImageView *)sender
{
    if (self.gwEcrollViewSelectAction) {
         self.gwEcrollViewSelectAction(sender.tag);
    }
}

- (void)stopTimer{
    [_myTimer invalidate];
    _myTimer = nil;
}

@end
