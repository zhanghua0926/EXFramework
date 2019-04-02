//
//  EXNetworkingManager.h
//  EXFrameWork
//
//  Created by Eric on 2019/1/23.
//  Copyright © 2019 icety. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EXNetworkingError.h"

typedef enum {
    Get,
    Post,
}HttpType;


@interface EXNetworkingManager : NSObject

/**
 EXNetworkingManager singletton.
 
 @return The singletton of EXNetworkingManager.
 */
+ (EXNetworkingManager *)manager;


/**
 Network data requests are made over HTTP.
 
 @param URL URL.
 @param httpType HTTP type: GET, POST.
 @param parameters Requests pamaters.
 @param success success block if request success.
 @param failure failure block if request failure.
 */
- (void)request:(NSString *)URL
           type:(HttpType)httpType
     parameters:(NSDictionary *)parameters
        success:(void (^)(id responseObject))success
        failure:(void (^)(EXNetworkingError *errorMsg))failure;


/**
 Network data requests are made over HTTP.
 
 @param URL URL.
 @param httpType HTTP type: GET, POST.
 @param parameters Requests pamaters.
 @param progress Progress block, can show loading progress...
 @param success success block if request success.
 @param failure failure block if request failure.
 */
- (void)request:(NSString *)URL
           type:(HttpType)httpType
     parameters:(NSDictionary *)parameters
       progress:(void (^)(NSProgress *progress))progress
        success:(void (^)(id responseObject))success
        failure:(void (^)(EXNetworkingError *errorMsg))failure;


@end
