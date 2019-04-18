//
//  EXHaloLayer.h
//  EXFramework
//
//  Created by Eric on 2019/4/19.
//  Copyright © 2019 icety. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface EXHaloLayer : CALayer

// 直角
+ (EXHaloLayer *)layerWithSize:(CGSize)size haloColor:(UIColor *)color stroke:(CGFloat)strokeWidth;
+ (EXHaloLayer *)layerWithSize:(CGSize)size haloColor:(UIColor *)color stroke:(CGFloat)strokeWidth outward:(BOOL)outward;

// 圆角
+ (EXHaloLayer *)layerWithSize:(CGSize)size haloColor:(UIColor *)color radius:(CGFloat)radius;
+ (EXHaloLayer *)layerWithSize:(CGSize)size haloColor:(UIColor *)color radius:(CGFloat)radius outward:(BOOL)outward;
@end
