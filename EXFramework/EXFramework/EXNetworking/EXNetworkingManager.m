//
//  EXNetworkingManager.m
//  EXFrameWork
//
//  Created by Eric on 2019/1/23.
//  Copyright © 2019 icety. All rights reserved.
//

#import "EXNetworkingManager.h"
#import "AFHTTPSessionManager.h"
#import <AdSupport/AdSupport.h>
#import "EXApplicationDefine.h"
#import "EXApiHost.h"

@interface EXNetworkingManager ()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@end


@implementation EXNetworkingManager
+ (EXNetworkingManager *)manager {
    static dispatch_once_t onceToken;
    static id singleton;
    dispatch_once(&onceToken, ^{
        singleton = [[EXNetworkingManager alloc] init];
    });
    
    return singleton;
}


- (void)configureHttpHeader {
    // weak reference avoid cycle.
    __weak typeof(self) weakSelf = self;
//    [weakSelf.sessionManager.requestSerializer setValue:kAppVersion forHTTPHeaderField:@"version"];
//    [weakSelf.sessionManager.requestSerializer setValue:kDeviceId forHTTPHeaderField:@"deviceId"];
//    [weakSelf.sessionManager.requestSerializer setValue:KChannelId forHTTPHeaderField:@"channelId"];
//    [weakSelf.sessionManager.requestSerializer setValue:KClientType forHTTPHeaderField:@"clientType"];
//    [weakSelf.sessionManager.requestSerializer setValue:kSystemVersion forHTTPHeaderField:@"osVersion"];
//    [weakSelf.sessionManager.requestSerializer setValue:KOSName forHTTPHeaderField:@"osName"];
    [weakSelf.sessionManager.requestSerializer setValue:deviceType() forHTTPHeaderField:@"mediaType"];
}


- (void)request:(NSString *)url type:(HttpType)httpType parameters:(NSDictionary *)parameters success:(void (^)(id))success failure:(void (^)(EXNetworkingError *))failure {
    [self request:url type:httpType parameters:parameters progress:nil success:success failure:failure];
}


- (void)request:(NSString *)url type:(HttpType)httpType parameters:(NSDictionary *)parameters progress:(void (^)(NSProgress *))progress success:(void (^)(id))success failure:(void (^)(EXNetworkingError *))failure {
    if (!_sessionManager) {
        self.sessionManager = [AFHTTPSessionManager manager];
    }
    
    [self.sessionManager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    self.sessionManager.requestSerializer.timeoutInterval = 10.f;
    [self.sessionManager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    [self configureHttpHeader];
    
    EXNetworkingError *bmError = [[EXNetworkingError alloc] init];
    
    if (!STRINGHASVALUE(url)) {
//        bmError.code = HTTPURLErrorCode;
//        bmError.msg = HTTPURLError;
        failure(bmError);
        return;
    }
    
    if (httpType == Post) {
        [self POST:url parameters:parameters progress:progress success:success failure:failure];
    } else if (httpType == Get) {
        [self GET:url parameters:parameters progress:progress success:success failure:failure];
    }
}


- (nullable NSURLSessionDataTask *)GET:(NSString *)URLString
                            parameters:(nullable id)parameters
                              progress:(nullable void (^)(NSProgress *progress))progress
                               success:(nullable void (^)(id _Nullable responseObject))success
                               failure:(nullable void (^)(EXNetworkingError *))failure {
    EXNetworkingError *bmError = [[EXNetworkingError alloc] init];
    
    return [self.sessionManager GET:[[EXApiHost getApiHost] stringByAppendingString:URLString]
                         parameters:parameters
                           progress:^(NSProgress * _Nonnull downloadProgress) {
                               if (progress) {
                                   progress(downloadProgress);
                               }
                           }
                            success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                if (success) {
                                    success(responseObject);
                                }
                            }
                            failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                if (failure) {
                                    failure(bmError);
                                }
                            }];
}


- (nullable NSURLSessionDataTask *)POST:(NSString *)URLString
                             parameters:(nullable id)parameters
                               progress:(nullable void (^)(NSProgress *progress))progress
                                success:(nullable void (^)(id _Nullable responseObject))success
                                failure:(nullable void (^)(EXNetworkingError *))failure {
    EXNetworkingError *bmError = [[EXNetworkingError alloc] init];
    
    NSString *apiString = [[EXApiHost getApiHost] stringByAppendingString:URLString];
    return [self.sessionManager POST:apiString
                          parameters:parameters
                            progress:^(NSProgress * _Nonnull downloadProgress) {
                                if (progress) {
                                    progress(downloadProgress);
                                }
                            }
            
                             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                 NSLog(@"%@", responseObject);
                                 
                                 if (failure) {
                                     if ([responseObject[@"code"] isEqualToString:@"Err"]) {
                                         bmError.msg = responseObject[@"msg"];
                                         failure(bmError);
                                         return;
                                     }
                                 }
                                 
                                 if (success) {
                                     success(responseObject);
                                 }
                             }
            
                             failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                 NSLog(@"%@", error);
                                 
                                 if (failure) {
                                     if (error.code == -1001) {
                                         bmError.msg = @"请求超时";
                                         bmError.code = @"-1001";
                                     }
                                     
                                     if (error.code == -1003) {
                                         bmError.msg = @"请求失败";
                                         bmError.code = @"-1001";
                                     }
                                     
//                                     if ([AppDelegate appDelegate].ability.currentReachabilityStatus == NotReachable) {
//                                         bmError.msg = HTTPConnectError;
//                                         bmError.code = HTTPConnectErrorCode;
//                                     }
                                     
                                     failure(bmError);
                                 }
                             }];
}

@end
