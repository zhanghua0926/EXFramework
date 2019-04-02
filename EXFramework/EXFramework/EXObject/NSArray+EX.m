//
//  NSArray+EX.m
//  EXFrameWork
//
//  Created by Eric on 2019/1/23.
//  Copyright © 2019 icety. All rights reserved.
//

#import "NSArray+EX.h"

@implementation NSArray (EX)

- (id)safetyObjectAtIndex:(NSUInteger)index {
    return [self safetyObjectAtIndex:index
                             default:nil];
}

- (id)safetyObjectAtIndex:(NSUInteger)index default:(id)defaultValue {
    if (index < self.count && index >= 0) {
        return [self objectAtIndex: index];
        
    } else {
        return defaultValue;
    }
}

@end
