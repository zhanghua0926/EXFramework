//
//  UIButton+EX.m
//  EXFrameWork
//
//  Created by Eric on 2019/1/23.
//  Copyright © 2019 icety. All rights reserved.
//

#import "UIButton+EX.h"
#import "UIImage+EX.h"

@implementation UIButton (EX)

- (void)setBackgroundColor:(UIColor *)color forState:(UIControlState)state {
    UIImage *colorImage = [[UIImage imageWithColor:color andSize:CGSizeMake(1, 1)] stretchableImageWithLeftCapWidth:0.5 topCapHeight:0.5];
    [self setBackgroundImage:colorImage forState:state];
}


@end
