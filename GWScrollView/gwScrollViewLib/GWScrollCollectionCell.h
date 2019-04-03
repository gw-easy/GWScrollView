//
//  GWScrollCollectionCell.h
//  GWScrollView
//
//  Created by zdwx on 2019/4/3.
//  Copyright © 2019 gw. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GWScrollCollectionCell : UICollectionViewCell
//image
@property (strong ,nonatomic) UIImageView *imageView;

@property (strong ,nonatomic) UILabel *titleLabel;

@property (nonatomic, assign) BOOL hasConfigured;

/** 只展示文字轮播 */
@property (nonatomic, assign) BOOL onlyDisplayText;
@end

NS_ASSUME_NONNULL_END
