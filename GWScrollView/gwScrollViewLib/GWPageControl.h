//
//  GWPageControl.h
//  GWScrollView
//
//  Created by gw on 2017/12/22.
//  Copyright © 2017年 gw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GWPageControl : UIPageControl
//按钮宽度
@property (assign, nonatomic)CGFloat pageWidth;
//按钮高度
@property (assign, nonatomic)CGFloat pageHeight;
//按钮之间间距
@property (assign, nonatomic)CGFloat pageMagrin;

@property (copy,nonatomic)NSString *pageImageStr;//pageControl底部图片
@property (copy,nonatomic)NSString *currentPageImageStr;//pageControl当前图片
@end
