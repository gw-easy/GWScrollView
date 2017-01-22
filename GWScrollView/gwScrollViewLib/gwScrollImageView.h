//
//  gwScrollImageView.h
//  GWScrollView
//
//  Created by gw on 2017/1/22.
//  Copyright © 2017年 gw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface gwScrollImageView : UIImageView
@property (nonatomic, assign) id target;
@property (nonatomic, assign) SEL action;
-(void)addTarget:(id)target action:(SEL)action;
@end
