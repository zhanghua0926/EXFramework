//
//  UIView+EX.h
//  EXFrameWork
//
//  Created by Eric on 2019/1/23.
//  Copyright © 2019 icety. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (EX)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;

- (CGSize)sizeForLabel:(UILabel *)label;

- (CGSize)sizeForLabel:(UILabel *)label
              maxWidth:(CGFloat)maxWidth;

@end
