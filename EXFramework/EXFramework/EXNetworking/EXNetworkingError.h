//
//  EXNetworkingError.h
//  EXFrameWork
//
//  Created by Eric on 2019/1/23.
//  Copyright © 2019 icety. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EXNetworkingError : NSObject

@property (nonatomic, copy) NSString *code;

@property (nonatomic, copy) NSString *msg;

@end
