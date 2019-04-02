//
//  NSString+EXHash.h
//  EXFrameWork
//
//  Created by Eric on 2019/1/23.
//  Copyright © 2019 icety. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    EXHashTypeMD5,
    EXHashTypeSHA1,
    EXHashTypeSHA256
}EXHashType;


@interface NSString (EXHash)

/**
 Generate MD5.

 @return Generated MD5 value.
 */
- (NSString *)md5;


/**
 Generate SHA1.

 @return Generated SHA1 value.
 */
- (NSString *)sha1;


/**
 Generate SHA256.

 @return Generated SHA256 value.
 */
- (NSString *)sha256;


/**
 Generate a hash value by type.

 @param type Hash type.
 @return Generated hash value.
 */
- (NSString *)hashWithType:(EXHashType)type;


/**
 Generate a hash MAC by key.
 MAC:Message Authentication Code.

 @param key Hash key.
 @return Generated MAC.
 */
- (NSString *)hmacWithKey:(NSString *)key;

@end
