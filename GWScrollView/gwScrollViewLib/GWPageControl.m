//
//  GWPageControl.m
//  GWScrollView
//
//  Created by gw on 2017/12/22.
//  Copyright © 2017年 gw. All rights reserved.
//

#import "GWPageControl.h"
#import "GW_AnimatedGIFImageSerialization.h"
@implementation GWPageControl

- (void)setPageImageStr:(NSString *)pageImageStr{
    _pageImageStr = pageImageStr;
    if ([pageImageStr hasSuffix:@".jpg"] || [pageImageStr hasSuffix:@".png"] || [pageImageStr hasSuffix:@".gif"]) {
        [self setValue:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:pageImageStr ofType:nil]] forKeyPath:@"_pageImage"];
        return;
    }
    [self setValue:[UIImage imageNamed:pageImageStr] forKeyPath:@"_pageImage"];
}

- (void)setCurrentPageImageStr:(NSString *)currentPageImageStr{
    _currentPageImageStr = currentPageImageStr;
    if ([currentPageImageStr hasSuffix:@".jpg"] || [currentPageImageStr hasSuffix:@".png"] || [currentPageImageStr hasSuffix:@".gif"]) {
        UIImage *currentImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:currentPageImageStr ofType:nil]];
        [self setValue:currentImage forKeyPath:@"_currentPageImage"];
        return;
    }
    [self setValue:[UIImage imageNamed:currentPageImageStr] forKeyPath:@"_currentPageImage"];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (!self.pageWidth || self.pageWidth<0) {
        self.pageWidth = 7;
    }
    
    if (!self.pageHeight || self.pageHeight<0) {
        self.pageHeight = self.pageWidth;
    }
    
    if (!self.pageMagrin || self.pageMagrin<0) {
        self.pageMagrin = 5;
    }
    
    //计算圆点间距
    CGFloat marginX = self.pageWidth + self.pageMagrin;
    
    //计算整个pageControl的宽度
    CGFloat newW = self.subviews.count * marginX - self.pageMagrin;
    
    //设置新frame
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, newW, self.frame.size.height);
    
    //设置居中
    CGPoint center = self.center;
    center.x = self.superview.frame.size.width/2;
    self.center = center;
    
    //遍历subview,设置圆点frame
    for (int i=0; i<[self.subviews count]; i++) {
        UIImageView* pageImage = [self.subviews objectAtIndex:i];

        [pageImage setFrame:CGRectMake(i * marginX, 0, self.pageWidth, self.pageHeight)];

    }
}


@end
