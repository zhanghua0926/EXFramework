//
//  EXFileManager.m
//  EXFramework
//
//  Created by Eric on 2019/8/30.
//  Copyright © 2019 icety. All rights reserved.
//

#import "EXFileManager.h"

@implementation EXFileManager

+ (BOOL)createFolder:(NSString *)folderName directory:(NSString *)directory {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *folderPath = [directory stringByAppendingPathComponent:folderName];
    
    return [fileManager createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:nil];
}


+ (BOOL)createFile:(NSString *)fileName directory:(NSString *)directory {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePath = [directory stringByAppendingPathComponent:fileName];
    
    return [fileManager createFileAtPath:filePath contents:nil attributes:nil];
}


+ (BOOL)writeFile:(NSString *)fileName content:(NSString *)content directory:(NSString *)directory {
    NSString *filePath = [directory stringByAppendingPathComponent:fileName];
    
    return [content writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
}


+ (NSString *)readFile:(NSString *)fileName directory:(NSString *)directory {
    NSString *filePath = [directory stringByAppendingPathComponent:fileName];
    
    return [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
}


+ (BOOL)isExistFile:(NSString *)fileName directory:(NSString *)directory {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePath = [directory stringByAppendingPathComponent:fileName];
    
    return [fileManager fileExistsAtPath:filePath];
}


+ (BOOL)deleteFile:(NSString *)fileName directory:(NSString *)directory {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePath = [directory stringByAppendingPathComponent:fileName];
    
    return [fileManager removeItemAtPath:filePath error:nil];
}


+ (unsigned long long)fileSizeAtPath:(NSString *)fileName directory:(NSString *)directory {
    BOOL isExist = [EXFileManager isExistFile:fileName directory:directory];
    if (!isExist) {
        return 0;
    }
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePath = [directory stringByAppendingPathComponent:fileName];
    
    return [[fileManager attributesOfItemAtPath:filePath error:nil] fileSize];
}


+ (double)folderSizeAtPath:(NSString *)folderName directory:(NSString *)directory {
    if (![EXFileManager isExistFile:folderName directory:directory]) {
        return 0.0;
    }
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *folderPath = [directory stringByAppendingPathComponent:folderName];
    NSEnumerator *childFileEnumerator = [[fileManager subpathsAtPath:folderPath] objectEnumerator];
    
    double folderSize = 0.0;
    NSString *fileName;
    while ((fileName = [childFileEnumerator nextObject]) != nil) {
        folderSize += [EXFileManager fileSizeAtPath:fileName directory:folderPath];
    }
    
    return folderSize / 1024.0 / 1024.0;
}
@end
