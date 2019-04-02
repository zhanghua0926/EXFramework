//
//  UITextView+EX.m
//  EXFrameWork
//
//  Created by Eric on 2019/1/23.
//  Copyright © 2019 icety. All rights reserved.
//

#import "UITextView+EX.h"

@implementation UITextView (EX)

- (void)contentSizeToFit {
    //先判断一下有没有文字（没文字就没必要设置居中了）
    if(self.text.length > 0) {
        //textView的contentSize属性
        CGSize contentSize = self.contentSize;
        //textView的内边距属性
        UIEdgeInsets offset;
        CGSize newSize = contentSize;
        
        //如果文字内容高度没有超过textView的高度
        if(contentSize.height <= self.frame.size.height) {
            //textView的高度减去文字高度除以2就是Y方向的偏移量，也就是textView的上内边距
            CGFloat offsetY = (self.frame.size.height - contentSize.height)/2;
            offset = UIEdgeInsetsMake(offsetY, 0, 0, 0);
            
        } else {
            //如果文字高度超出textView的高度
            newSize = self.frame.size;
            offset = UIEdgeInsetsZero;
            CGFloat fontSize = 18;
            
            //通过一个while循环，设置textView的文字大小，使内容不超过整个textView的高度（这个根据需要可以自己设置）
            while (contentSize.height > self.frame.size.height)
            {
                [self setFont:[UIFont fontWithName:@"Helvetica Neue" size:fontSize--]];
                contentSize = self.contentSize;
            }
            newSize = contentSize;
        }
        
        //根据前面计算设置textView的ContentSize和Y方向偏移量
        [self setContentSize:newSize];
        [self setContentInset:offset];
    }
}

@end
