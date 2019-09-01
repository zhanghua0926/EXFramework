//
//  EXSearchPath.h
//  EXFramework
//
//  Created by Eric on 2019/8/29.
//  Copyright © 2019 icety. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EXSearchPath : NSObject


/**
 Get documents folder directory.

 @return Documents directory.
 */
+ (NSString *)searchDocumentPath;

/**
 Get library folder directory.

 @return Library directory.
 */
+ (NSString *)searchLibraryPath;

/**
 Get cache folder directory.

 @return Caches directory.
 */
+ (NSString *)searchCachePath;

/**
 Get preferences folder directory.

 @return Preferences directory.
 */
+ (NSString *)searchPreferencePath;

/**
 Get tmp folder directory.

 @return Tmp directory.
 */
+ (NSString *)searchTmpPath;
@end
