//
//  gwScrollView.m
//  GWScrollView
//
//  Created by gw on 2017/1/22.
//  Copyright © 2017年 gw. All rights reserved.
//

#import "gwScrollView.h"
#import "UIImageView+WebCache.h"
#import "gwScrollImageView.h"

@interface gwScrollView()
{
    NSInteger _tempPage;
}
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *myTimer;
@end

@implementation gwScrollView

- (void)startLoading
{
    [self _initScrollView];
}


#pragma mark -scrollView Delegate-
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWith = self.scrollView.frame.size.width;
    NSInteger page = floor((self.scrollView.contentOffset.x - pageWith/([_slideImagesArray count]+2))/pageWith) + 1;
    page --; //默认从第二页开始
    self.pageControl.currentPage = page;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWith = self.scrollView.frame.size.width;
    NSInteger currentPage = floor((self.scrollView.contentOffset.x - pageWith/ ([_slideImagesArray count]+2)) / pageWith) + 1;
    if (currentPage == 0) {
        [self.scrollView scrollRectToVisible:CGRectMake(_scrollView.frame.size.width * _slideImagesArray.count, 0, _scrollView.frame.size.width, _scrollView.frame.size.height) animated:NO];
    }else if(currentPage == _slideImagesArray.count + 1){
        [self.scrollView scrollRectToVisible:CGRectMake(_scrollView.frame.size.width, 0, _scrollView.frame.size.width,_scrollView.frame.size.height) animated:NO
         ];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if (!self.withoutAutoScroll){
        if (_tempPage == 0) {
            [self.scrollView scrollRectToVisible:CGRectMake(_scrollView.frame.size.width * _slideImagesArray.count, 0, _scrollView.frame.size.width, _scrollView.frame.size.height) animated:NO];
        }else if(_tempPage == _slideImagesArray.count){
            [self.scrollView scrollRectToVisible:CGRectMake(_scrollView.frame.size.width, 0, _scrollView.frame.size.width,_scrollView.frame.size.height) animated:NO
             ];
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


#pragma mark -private Methods-
- (void)_initScrollView
{
    if (_scrollView) {
		
		[_scrollView removeFromSuperview];
		_scrollView = nil;
//        return;
    }
    _scrollView = ({
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
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
    
    if (self.showPageControl) {
        _pageControl = ({
            CGFloat pageBottom = self.pageControlBottom?self.pageControlBottom:10;
            UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0,_scrollView.frame.size.height-pageBottom , [UIScreen mainScreen].bounds.size.width, pageBottom)];
            
            CGFloat pageScale = self.pageControlScale?self.pageControlScale:1;
            pageControl.transform = CGAffineTransformScale(CGAffineTransformIdentity, pageScale, pageScale);
            if (self.pageImageStr.length>0 && self.currentPageImageStr.length>0) {
                [pageControl setValue:[UIImage imageNamed:self.pageImageStr] forKeyPath:@"_pageImage"];
                [pageControl setValue:[UIImage imageNamed:self.currentPageImageStr] forKeyPath:@"_currentPageImage"];
            }

            
            [pageControl setCurrentPageIndicatorTintColor:self.pageControlCurrentPageIndicatorTintColor ? self.pageControlCurrentPageIndicatorTintColor : [UIColor purpleColor]];
            [pageControl setPageIndicatorTintColor:self.PageControlPageIndicatorTintColor ? self.PageControlPageIndicatorTintColor : [UIColor grayColor]];
            pageControl.numberOfPages = [_slideImagesArray count];
            pageControl.currentPage = 0;
            if(self.slideImagesArray.count < 2){
                pageControl.hidden = YES;
            }
            [self addSubview:pageControl];
            pageControl;
        });
    }
	
	if (_slideImagesArray.count != 0)
	{		
		for (NSInteger i = 0; i < _slideImagesArray.count; i++) {
			gwScrollImageView *slideImage = [[gwScrollImageView alloc] init];
            slideImage.backgroundColor = [UIColor redColor];
            if (self.urlImageBool) {
                [slideImage sd_setImageWithURL:[NSURL URLWithString:_slideImagesArray[i]] placeholderImage: self.defaultIamge ? self.defaultIamge : [UIImage imageNamed: @"scrollImageDefault"]];
            }else{
                slideImage.image = [UIImage imageNamed:_slideImagesArray[i]];
            }
			slideImage.tag = i;
			slideImage.frame = CGRectMake(_scrollView.frame.size.width * (i + 1), 0, _scrollView.frame.size.width, _scrollView.frame.size.height);
			[slideImage addTarget:self action:@selector(ImageClick:)];
			[_scrollView addSubview:slideImage];// 首页是第0页,默认从第1页开始的。所以+_scrollView.frame.size.width
		}
        

		// 取数组最后一张图片 放在第0页
		gwScrollImageView *firstSlideImage = [[gwScrollImageView alloc] init];
        if (self.urlImageBool) {
            [firstSlideImage sd_setImageWithURL:[NSURL URLWithString:_slideImagesArray[_slideImagesArray.count - 1]] placeholderImage:[UIImage imageNamed:@"scrollImageDefault"]];
        }else{
            firstSlideImage.image = [UIImage imageNamed:_slideImagesArray[_slideImagesArray.count - 1]];
        }
		
		firstSlideImage.frame = CGRectMake(0, 0, _scrollView.frame.size.width, _scrollView.frame.size.height);
		[_scrollView addSubview:firstSlideImage];
		// 取数组的第一张图片 放在最后1页
		gwScrollImageView *endSlideImage = [[gwScrollImageView alloc] init];
        if (self.urlImageBool) {
            [endSlideImage sd_setImageWithURL:[NSURL URLWithString:_slideImagesArray[0]] placeholderImage:[UIImage imageNamed:@"scrollImageDefault"]];
        }else{
            endSlideImage.image = [UIImage imageNamed:_slideImagesArray[0]];
        }
		
		endSlideImage.frame = CGRectMake((_slideImagesArray.count + 1) * _scrollView.frame.size.width, 0, _scrollView.frame.size.width, _scrollView.frame.size.height);
		[_scrollView addSubview:endSlideImage];
		
		[_scrollView setContentSize:CGSizeMake(_scrollView.frame.size.width * (_slideImagesArray.count + 2), _scrollView.frame.size.height)]; //+上第1页和第4页  原理：4-[1-2-3-4]-1
		[_scrollView setContentOffset:CGPointMake(0, 0)];
		[_scrollView scrollRectToVisible:CGRectMake(_scrollView.frame.size.width, 0, _scrollView.frame.size.width, _scrollView.frame.size.height) animated:NO];
        
        if (self.slideImagesArray.count>1) {
		if (!self.withoutAutoScroll) {
			if (!self.autoTime) {
				self.autoTime = [NSNumber numberWithFloat:2.0f];
			}
			
			if (_myTimer)
			{
				[_myTimer invalidate];
				_myTimer = nil;
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

@end
