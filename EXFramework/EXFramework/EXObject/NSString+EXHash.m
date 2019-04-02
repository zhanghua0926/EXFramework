//
//  NSString+EXHash.m
//  EXFrameWork
//
//  Created by Eric on 2019/1/23.
//  Copyright © 2019 icety. All rights reserved.
//

#import "NSString+EXHash.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>
#import <CommonCrypto/CommonCryptor.h>

@implementation NSString (EXHash)
- (NSString *)md5 {
    return [self hashWithType:EXHashTypeMD5];
}


- (NSString *)sha1 {
    return [self hashWithType:EXHashTypeSHA1];
}


- (NSString *)sha256 {
    return [self hashWithType:EXHashTypeSHA256];
}


- (NSString *)hashWithType:(EXHashType)type {
    const char *ptr = [self UTF8String];
    
    NSInteger bufferSize;
    switch (type) {
        case EXHashTypeMD5:
            bufferSize = CC_MD5_DIGEST_LENGTH;
            break;
            
        case EXHashTypeSHA1:
            bufferSize = CC_SHA1_DIGEST_LENGTH;
            break;
            
        case EXHashTypeSHA256:
            bufferSize = CC_SHA256_DIGEST_LENGTH;
            break;
            
        default:
            return nil;
    }
    
    unsigned char buffer[bufferSize];
    switch (type) {
        case EXHashTypeMD5:
            CC_MD5(ptr, (unsigned int)strlen(ptr), buffer);
            break;
            
        case EXHashTypeSHA1:
            CC_SHA1(ptr, (unsigned int)strlen(ptr), buffer);
            break;
            
        case EXHashTypeSHA256:
            CC_SHA256(ptr, (unsigned int)strlen(ptr), buffer);
            break;
            
        default:
            return nil;
    }
    
    NSMutableString *hashString = [NSMutableString stringWithCapacity:bufferSize * 2];
    for (int i = 0; i < bufferSize; i++) {
        [hashString appendFormat:@"%02x",buffer[i]];
    }
    
    return hashString;
}


- (NSString *)hmacWithKey:(NSString *)key {
    const char *ptr = [self UTF8String];
    const char *keyPtr = [key UTF8String];
    
    unsigned char buffer[CC_SHA256_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgSHA256, keyPtr, kCCKeySizeAES256, ptr, strlen(ptr), buffer);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", buffer[i]];
    }
    
    return output;
}


@end
