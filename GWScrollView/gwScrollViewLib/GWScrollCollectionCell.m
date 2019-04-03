//
//  GWScrollCollectionCell.m
//  GWScrollView
//
//  Created by zdwx on 2019/4/3.
//  Copyright © 2019 gw. All rights reserved.
//

#import "GWScrollCollectionCell.h"

@implementation GWScrollCollectionCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self imageView];
        [self titleLabel];
    }
    
    return self;
}

#pragma mark - getter
- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_imageView];
    }
    return _imageView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.hidden = YES;
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}
@end
