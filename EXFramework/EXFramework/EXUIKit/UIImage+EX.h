//
//  UIImage+EX.h
//  EXFrameWork
//
//  Created by Eric on 2019/1/23.
//  Copyright © 2019 icety. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (EX)

/**
 // Pure color image.
 
 @param color Image color.
 @param size Image size.
 @return UIImage.
 */
+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size;

/**
 // Image scale.
 
 @param image Source image.
 @param newSize Image size.
 @return UIImage.
 */
+ (UIImage *)imageWithSourceImage:(UIImage *)image scaleToSize:(CGSize)newSize;

@end
