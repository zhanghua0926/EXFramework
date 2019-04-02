//
//  EXApiHost.m
//  EXFrameWork
//
//  Created by Eric on 2019/1/23.
//  Copyright © 2019 icety. All rights reserved.
//

#import "EXApiHost.h"

NSString *const mApiHost = @"https://www.bmcode.com/api";

@implementation EXApiHost

+ (NSString *)getApiHost {
    return mApiHost;
}


+ (NSString *)getPayHost {
    return @"";
}


+ (NSString *)getWebHost {
    return @"";
}

@end
