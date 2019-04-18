//
//  CALayer+EX.h
//  EXFramework
//
//  Created by 张华 on 2019/4/18.
//  Copyright © 2019 icety. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface CALayer (EX)

// 圆角
- (void)haloLayerWithRadius:(CGFloat)radius color:(UIColor *)color;
// 直角
- (void)haloLayerWithStroke:(CGFloat)strokeWidth color:(UIColor *)color;

- (void)removeHaloLayer;

@end
