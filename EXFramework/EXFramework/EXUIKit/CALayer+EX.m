//
//  CALayer+EX.m
//  EXFramework
//
//  Created by 张华 on 2019/4/18.
//  Copyright © 2019 icety. All rights reserved.
//

#import "CALayer+EX.h"
#import "EXHaloLayer.h"

@implementation CALayer (EX)

- (void)haloLayerWithRadius:(CGFloat)radius color:(UIColor *)color {
    self.cornerRadius = radius;
    
    CGSize size = self.bounds.size;
    CGPoint position = CGPointMake(size.width / 2, size.height /2);
    size.width += radius * 2;
    size.height += radius * 2;
    
    [self removeHaloLayer];
    
    EXHaloLayer *layer = [EXHaloLayer layerWithSize:size haloColor:color radius:radius];
    layer.position = position;
    [self insertSublayer:layer atIndex:0];
}


- (void)haloLayerWithStroke:(CGFloat)strokeWidth color:(UIColor *)color {
    self.cornerRadius = 0;
    
    CGSize size = self.bounds.size;
    CGPoint position = CGPointMake(size.width / 2, size.height /2);
    size.width += strokeWidth * 2;
    size.height += strokeWidth * 2;
    
    [self removeHaloLayer];
    
    EXHaloLayer *layer = [EXHaloLayer layerWithSize:size haloColor:color stroke:strokeWidth];
    layer.position = position;
    [self insertSublayer:layer atIndex:0];
}


- (void)removeHaloLayer {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (CALayer *layer in self.sublayers) {
        if ([layer isKindOfClass:[EXHaloLayer class]]) {
            [array addObject:layer];
        }
    }
    
    for (EXHaloLayer *layer in array) {
        [layer removeFromSuperlayer];
    }
    
    array = nil;
}
@end
