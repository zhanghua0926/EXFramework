//
//  UILabel+EX.m
//  EXFramework
//
//  Created by Eric on 2019/4/17.
//  Copyright © 2019 icety. All rights reserved.
//

#import "UILabel+EX.h"

@implementation UILabel (EX)

- (CGSize)sizeForLabel {
    return [self sizeForLabel:([[UIScreen mainScreen] bounds].size.width)];
}


- (CGSize)sizeForLabel:(CGFloat)maxWidth {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:self.font, NSParagraphStyleAttributeName:paragraphStyle};
    CGSize labelSize = [self.text boundingRectWithSize:CGSizeMake(maxWidth, ([[UIScreen mainScreen] bounds].size.height))
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                            attributes:attributes
                                               context:nil].size;
    return labelSize;
}

@end
