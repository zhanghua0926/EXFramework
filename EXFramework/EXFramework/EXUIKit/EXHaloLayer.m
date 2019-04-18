//
//  EXHaloLayer.m
//  EXFramework
//
//  Created by Eric on 2019/4/19.
//  Copyright © 2019 icety. All rights reserved.
//

#import "EXHaloLayer.h"

@interface EXHaloLayer ()

@property (nonatomic, assign) BOOL outward;
@property (nonatomic, assign) BOOL shouldCornerRadius;
@property (nonatomic, assign) CGFloat strokeWidth;
@property (nonatomic, strong) UIColor *color;

@end


@implementation EXHaloLayer
// 直角
+ (EXHaloLayer *)layerWithSize:(CGSize)size haloColor:(UIColor *)color stroke:(CGFloat)strokeWidth {
    return [EXHaloLayer layerWithSize:size haloColor:color stroke:strokeWidth outward:YES];
}


+ (EXHaloLayer *)layerWithSize:(CGSize)size haloColor:(UIColor *)color stroke:(CGFloat)strokeWidth outward:(BOOL)outward {
    CGRect bounds = {.origin = CGPointZero, .size = size};
    EXHaloLayer *layer = [EXHaloLayer layer];
    [layer drawInBounds:bounds color:color stroke:strokeWidth shouldCornerRadius:NO outward:outward];
    return layer;
}

// 圆角
+(EXHaloLayer *)layerWithSize:(CGSize)size haloColor:(UIColor *)color radius:(CGFloat)radius {
    return [EXHaloLayer layerWithSize:size haloColor:color radius:radius outward:YES];
}


+(EXHaloLayer *)layerWithSize:(CGSize)size haloColor:(UIColor *)color radius:(CGFloat)radius outward:(BOOL)outward {
    CGRect bounds = {.origin = CGPointZero, .size = size};
    EXHaloLayer *layer = [EXHaloLayer layer];
    [layer drawInBounds:bounds color:color stroke:radius shouldCornerRadius:YES outward:outward];
    return layer;
}


- (void)drawInBounds:(CGRect)bounds color:(UIColor *)color stroke:(CGFloat)strokeWidth shouldCornerRadius:(BOOL)cornerRadius outward:(BOOL)outward {
    self.bounds = bounds;
    self.color = color;
    self.strokeWidth = strokeWidth;
    self.shouldCornerRadius = cornerRadius;
    self.outward = outward;
    
    self.position = CGPointMake(bounds.size.width/2, bounds.size.height/2);
    [self setNeedsDisplay];
}


- (void)drawInContext:(CGContextRef)ctx {
    CGContextSetFillColorWithColor(ctx, [UIColor clearColor].CGColor);
    CGContextFillPath(ctx);
    
    CGFloat r,g,b,a;
    [self.color getRed:&r green:&g blue:&b alpha:&a];
    
    CGFloat single = 1 / [UIScreen mainScreen].scale;
    NSInteger count = self.strokeWidth / single;
    CGFloat a0 = a/count;
    
    CGContextSetLineWidth(ctx, single);
    for (int i = 0; i < count; i++) {
        UIColor *color;
        if (self.outward) {
            color = [UIColor colorWithRed:r green:g blue:b alpha:a0 *i * i/count];
        } else {
            color = [UIColor colorWithRed:r green:g blue:b alpha:a - a0 *i];
        }
        
        UIBezierPath *path = [self pathAtIndex:i];
        CGContextSetStrokeColorWithColor(ctx, color.CGColor);
        CGContextAddPath(ctx, path.CGPath);
        CGContextStrokePath(ctx);
    }
}


- (UIBezierPath *)pathAtIndex:(NSInteger)index {
    CGFloat single = 1 / [UIScreen mainScreen].scale;
    CGFloat r0 = single * index;
    CGFloat r = self.strokeWidth;
    CGFloat w = self.bounds.size.width;
    CGFloat h = self.bounds.size.height;
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    if (self.shouldCornerRadius) {
        [path moveToPoint:CGPointMake(r + r0, 0 + r0)];
        [path addLineToPoint:CGPointMake(w- (r + r0), 0 + r0)];
        [path addArcWithCenter:CGPointMake(w - (r + r0), r + r0) radius:r startAngle:M_PI_2 * 3 endAngle:M_PI * 2 clockwise:YES];
        
        [path addLineToPoint:CGPointMake(w - r0, h - (r + r0))];
        [path addArcWithCenter:CGPointMake(w - (r + r0), h - (r + r0)) radius:r startAngle:0 endAngle:M_PI_2 clockwise:YES];
        
        [path addLineToPoint:CGPointMake(r + r0, h - r0)];
        [path addArcWithCenter:CGPointMake(r + r0, h - (r + r0)) radius:r startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
        
        [path addLineToPoint:CGPointMake(0 + r0, r + r0)];
        [path addArcWithCenter:CGPointMake(r + r0, r + r0) radius:r startAngle:M_PI endAngle:M_PI_2 * 3 clockwise:YES];
    } else {
        [path moveToPoint:CGPointMake(r0, r0)];
        [path addLineToPoint:CGPointMake(w - r0, r0)];
        [path addLineToPoint:CGPointMake(w - r0, h - r0)];
        [path addLineToPoint:CGPointMake(r0, h - r0)];
        [path closePath];
    }
    
    return path;
}
@end
