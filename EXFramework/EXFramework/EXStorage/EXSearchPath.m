//
//  EXSearchPath.m
//  EXFramework
//
//  Created by Eric on 2019/8/29.
//  Copyright © 2019 icety. All rights reserved.
//

#import "EXSearchPath.h"

@implementation EXSearchPath

+ (NSString *)searchDocumentPath {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}


+ (NSString *)searchLibraryPath {
    return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
}


+ (NSString *)searchCachePath {
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
}


+ (NSString *)searchPreferencePath {
    return [[EXSearchPath searchLibraryPath] stringByAppendingPathComponent:@"Preferences"];
}


+ (NSString *)searchTmpPath {
    return NSTemporaryDirectory();
}
@end
