//
//  gwScrollImageView.m
//  GWScrollView
//
//  Created by gw on 2017/1/22.
//  Copyright © 2017年 gw. All rights reserved.
//

#import "gwScrollImageView.h"

@implementation gwScrollImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.userInteractionEnabled=YES;
        self.contentMode = UIViewContentModeScaleAspectFill;
    }
    return self;
}

-(void)addTarget:(id)target action:(SEL)action
{
    self.target = target;
    self.action = action;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //如果self.target表示的对象中, self.action表示的方法存在的话
    if([self.target respondsToSelector:self.action])
    {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self.target performSelector:self.action withObject:self];
#pragma clang diagnostic pop
    }
}

@end
