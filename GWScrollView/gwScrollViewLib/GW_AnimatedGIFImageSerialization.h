// AnimatedGIFImageSerialization.h
//
//  iSpeakDemo
//
//  Created by gw on 2017/12/2.
//  Copyright © 2017年 gw. All rights reserved.
//

#import <Foundation/Foundation.h>

#if defined(__IPHONE_OS_VERSION_MIN_REQUIRED)

#import <UIKit/UIKit.h>

/**
 
 */
extern __attribute__((overloadable)) UIImage * UIImageWithAnimatedGIFData(NSData *data);

/**
 
 */
extern __attribute__((overloadable)) UIImage * UIImageWithAnimatedGIFData(NSData *data, CGFloat scale, NSTimeInterval duration, NSError * __autoreleasing *error);

#pragma mark -

/**
 
 */
extern __attribute__((overloadable)) NSData * UIImageAnimatedGIFRepresentation(UIImage *image);

/**
 
 */
extern __attribute__((overloadable)) NSData * UIImageAnimatedGIFRepresentation(UIImage *image, NSTimeInterval duration, NSUInteger loopCount, NSError * __autoreleasing *error);

#pragma mark -

/**
 
 */
@interface GW_AnimatedGIFImageSerialization : NSObject

/// @name Creating an Animated GIF

/**

 */
+ (UIImage *)GW_ImageWithData:(NSData *)data
                     error:(NSError * __autoreleasing *)error;

/**

 */
+ (UIImage *)GW_ImageWithData:(NSData *)data
                     scale:(CGFloat)scale
                  duration:(NSTimeInterval)duration
                     error:(NSError * __autoreleasing *)error;

/// @name Creating Animated Gif Data

/**

 */
+ (NSData *)GW_AnimatedGIFDataWithImage:(UIImage *)image
                               error:(NSError * __autoreleasing *)error;

/**
 
 */
+ (NSData *)GW_AnimatedGIFDataWithImage:(UIImage *)image
                            duration:(NSTimeInterval)duration
                           loopCount:(NSUInteger)loopCount
                               error:(NSError * __autoreleasing *)error;

@end

/**
 
 */
extern NSString * const GW_AnimatedGIFImageErrorDomain;
#endif
