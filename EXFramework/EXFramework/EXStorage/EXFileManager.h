//
//  EXFileManager.h
//  EXFramework
//
//  Created by Eric on 2019/8/30.
//  Copyright © 2019 icety. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EXFileManager : NSObject

/**
 Create a folder under the specified path.

 @param folderName Folder name.
 @param directory Folder directory,such as document, library...
 @return Success or not.
 */
+ (BOOL)createFolder:(NSString *)folderName
           directory:(NSString *)directory;

/**
 Create a file under the specified path.

 @param fileName File name that include extension, such as test.txt, city.plist...
 @param directory File directory.
 @return Success or not.
 */
+ (BOOL)createFile:(NSString *)fileName
         directory:(NSString *)directory;

/**
 Write content to a file.

 @param fileName File name that include extension, such as .txt, .doc...
 @param content Content will be write.
 @param directory File directory.
 @return Success or not.
 */
+ (BOOL)writeFile:(NSString *)fileName
          content:(NSString *)content
        directory:(NSString *)directory;

/**
 Read content from a file.

 @param fileName File name that include extension, such as .txt, .doc...
 @param directory File directory.
 @return File content.
 */
+ (NSString *)readFile:(NSString *)fileName
             directory:(NSString *)directory;

/**
 Determine whether a file exists.

 @param directory File directory.
 @return Exist or not.
 */
+ (BOOL)isExistFile:(NSString *)fileName
          directory:(NSString *)directory;

/**
 Delete file.

 @param fileName  File name that include extension, such as .txt, .doc...
 @param directory File directory.
 @return Success or not.
 */
+ (BOOL)deleteFile:(NSString *)fileName
         directory:(NSString *)directory;

/**
 Calculate file size.

 @param fileName File name that include extension, such as .txt, .doc...
 @param directory File directory.
 @return File size in byte, such as 18742B.
 */
+ (unsigned long long)fileSizeAtPath:(NSString *)fileName
                           directory:(NSString *)directory;

/**
 Calculate folder size.

 @param folderName Folder name.
 @param directory Folder directory.
 @return Folder size in MB, such as 12.88M.
 */
+ (double)folderSizeAtPath:(NSString *)folderName
                 directory:(NSString *)directory;
@end
