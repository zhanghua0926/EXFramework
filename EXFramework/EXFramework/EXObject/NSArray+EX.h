//
//  NSArray+EX.h
//  EXFrameWork
//
//  Created by Eric on 2019/1/23.
//  Copyright © 2019 icety. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (EX)

- (id)safetyObjectAtIndex:(NSUInteger)index;

- (id)safetyObjectAtIndex:(NSUInteger)index default:(id)defaultValue;

@end
