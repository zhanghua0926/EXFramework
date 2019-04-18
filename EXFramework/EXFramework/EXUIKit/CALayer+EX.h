//
//  CALayer+EX.h
//  EXFramework
//
//  Created by 张华 on 2019/4/18.
//  Copyright © 2019 icety. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CALayer (EX)

- (void)haloLayerWithRadius:(CGFloat)radius color:(NSString *)color;
- (void)haloLayerWithStroke:(CGFloat)strokeWidth color:(NSString *)color;



@end
