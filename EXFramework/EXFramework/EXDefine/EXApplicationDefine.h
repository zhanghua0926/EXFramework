//
//  EXApplicationDefine.h
//  EXFrameWork
//
//  Created by Eric on 2019/1/18.
//  Copyright © 2019 icety. All rights reserved.
//

#ifndef EXApplicationDefine_h
#define EXApplicationDefine_h

// App name.
#define kAppName            [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"]
// App version.
#define kAppVersion         [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]
// iOS system version.
#define kSystemVersion      [[UIDevice currentDevice] systemVersion]
// Langugage.
#define kCurrentLanguage    [[NSLocale preferredLanguages] firstObject]
// Device id.
#define kDeviceId           [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString]


#import "sys/utsname.h"
#import "EXFunctionDefine.h"

#define kEXDeviceType             @"kEXDeviceType"

static inline NSString * deviceType() {
    struct utsname systemInfo;
    uname(&systemInfo);
    
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    NSString *deviceType = nil;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *device = [userDefaults stringForKey:kEXDeviceType];
    if (STRINGHASVALUE(device)) {
        deviceType = device;
        return deviceType;
    }
    
    if (IS_IPAD) {
        if ([deviceString isEqualToString:@"iPad1,1"]) {
            
            deviceType = @"iPad";
        } else if ([deviceString isEqualToString:@"iPad2,1"] ||
                   [deviceString isEqualToString:@"iPad2,2"] ||
                   [deviceString isEqualToString:@"iPad2,3"] ||
                   [deviceString isEqualToString:@"iPad2,4"]) {
            
            deviceType = @"iPad 2";
        } else if ([deviceString isEqualToString:@"iPad3,1"] ||
                   [deviceString isEqualToString:@"iPad3,2"] ||
                   [deviceString isEqualToString:@"iPad3,3"]) {
            
            deviceType = @"iPad 3";
        } else if ([deviceString isEqualToString:@"iPad3,4"] ||
                   [deviceString isEqualToString:@"iPad3,5"] ||
                   [deviceString isEqualToString:@"iPad3,6"]) {
            
            deviceType = @"iPad 4";
        } else if ([deviceString isEqualToString:@"iPad4,1"] ||
                   [deviceString isEqualToString:@"iPad4,2"] ||
                   [deviceString isEqualToString:@"iPad4,3"]) {
            
            deviceType = @"iPad Air";
        } else if ([deviceString isEqualToString:@"iPad5,3"] ||
                   [deviceString isEqualToString:@"iPad5,4"]) {
            
            deviceType = @"iPad Air 2";
        } else if ([deviceString isEqualToString:@"iPad6,7"] ||
                   [deviceString isEqualToString:@"iPad6,8"]) {
            
            deviceType = @"iPad Pro(12.9-inch)";
        } else if ([deviceString isEqualToString:@"iPad6,3"] ||
                   [deviceString isEqualToString:@"iPad6,4"]) {
            
            deviceType = @"iPad Pro(9.7-inch)";
        } else if ([deviceString isEqualToString:@"iPad6,11"] ||
                   [deviceString isEqualToString:@"iPad6,12"]) {
            
            deviceType = @"iPad 5";
        } else if ([deviceString isEqualToString:@"iPad7,1"] ||
                   [deviceString isEqualToString:@"iPad7,2"]) {
            
            deviceType = @"iPad Pro 2(12.9-inch)";
        } else if ([deviceString isEqualToString:@"iPad7,3"] ||
                   [deviceString isEqualToString:@"iPad7,4"]) {
            
            deviceType = @"iPad Pro(10.5-inch)";
        } else if ([deviceString isEqualToString:@"iPad7,5"] ||
                   [deviceString isEqualToString:@"iPad7,6"]) {
            
            deviceType = @"iPad 6";
        } else if ([deviceString isEqualToString:@"iPad2,5"] ||
                   [deviceString isEqualToString:@"iPad2,6"] ||
                   [deviceString isEqualToString:@"iPad2,7"]) {
            
            deviceType = @"iPad mini";
        } else if ([deviceString isEqualToString:@"iPad4,4"] ||
                   [deviceString isEqualToString:@"iPad4,5"] ||
                   [deviceString isEqualToString:@"iPad4,6"]) {
            
            deviceType = @"iPad mini 2";
        } else if ([deviceString isEqualToString:@"iPad4,7"] ||
                   [deviceString isEqualToString:@"iPad4,8"] ||
                   [deviceString isEqualToString:@"iPad4,9"]) {
            
            deviceType = @"iPad mini 3";
        } else if ([deviceString isEqualToString:@"iPad5,1"] ||
                   [deviceString isEqualToString:@"iPad5,2"]) {
            
            deviceType = @"iPad mini 4";
        } else if ([deviceString isEqualToString:@"i386"] ||
                   [deviceString isEqualToString:@"x86_64"]) {
            
            deviceType = @"Simulator";
        }
        
    } else if (IS_IPHONE) {
        if ([deviceString isEqualToString:@"iPhone1,1"]) {
            
            deviceType = @"iPhone";
        } else if ([deviceString isEqualToString:@"iPhone1,2"]) {
            
            deviceType = @"iPhone 3G";
        } else if ([deviceString isEqualToString:@"iPhone2,1"]) {
            
            deviceType = @"iPhone 3GS ";
        } else if ([deviceString isEqualToString:@"iPhone3,1"] ||
                   [deviceString isEqualToString:@"iPhone3,2"] ||
                   [deviceString isEqualToString:@"iPhone3,3"]) {
            
            deviceType = @"iPhone 4";
        } else if ([deviceString isEqualToString:@"iPhone4,1"]) {
            
            deviceType = @"iPhone 4S";
        } else if ([deviceString isEqualToString:@"iPhone5,1"] ||
                   [deviceString isEqualToString:@"iPhone5,2"]) {
            
            deviceType = @"iPhone 5";
        } else if ([deviceString isEqualToString:@"iPhone5,3"] ||
                   [deviceString isEqualToString:@"iPhone5,4"]) {
            
            deviceType = @"iPhone 5c";
        } else if ([deviceString isEqualToString:@"iPhone6,1"] ||
                   [deviceString isEqualToString:@"iPhone6,2"]) {
            
            deviceType = @"iPhone 5s";
        } else if ([deviceString isEqualToString:@"iPhone7,2"]) {
            
            deviceType = @"iPhone 6";
        } else if ([deviceString isEqualToString:@"iPhone7,1"]) {
            
            deviceType = @"iPhone 6 Plus";
        } else if ([deviceString isEqualToString:@"iPhone8,1"]) {
            
            deviceType = @"iPhone 6s";
        } else if ([deviceString isEqualToString:@"iPhone8,2"]) {
            
            deviceType = @"iPhone 6s Plus";
        } else if ([deviceString isEqualToString:@"iPhone8,4"]) {
            
            deviceType = @"iPhone SE";
        } else if ([deviceString isEqualToString:@"iPhone9,1"] ||
                   [deviceString isEqualToString:@"iPhone9,3"]) {
            
            deviceType = @"iPhone 7";
        } else if ([deviceString isEqualToString:@"iPhone9,2"] ||
                   [deviceString isEqualToString:@"iPhone9,4"]) {
            
            deviceType = @"iPhone 7 Plus";
        } else if ([deviceString isEqualToString:@"iPhone10,1"] ||
                   [deviceString isEqualToString:@"iPhone10,4"]) {
            
            deviceType = @"iPhone 8";
        } else if ([deviceString isEqualToString:@"iPhone10,2"] ||
                   [deviceString isEqualToString:@"iPhone10,5"]) {
            
            deviceType = @"iPhone 8 Plus";
        } else if ([deviceString isEqualToString:@"iPhone10,3"] ||
                   [deviceString isEqualToString:@"iPhone10,6"]) {
            
            deviceType = @"iPhone X";
        } else if ([deviceString isEqualToString:@"iPhone11,8"]) {
            
            deviceType = @"iPhone XR";
        } else if ([deviceString isEqualToString:@"iPhone11,2"]) {
            
            deviceType = @"iPhone XS";
        } else if ([deviceString isEqualToString:@"iPhone11,6"] ||
                   [deviceString isEqualToString:@"iPhone11,4"]) {
            
            deviceType = @"iPhone XS Max";
        } else if ([deviceString isEqualToString:@"i386"] ||
                   [deviceString isEqualToString:@"x86_64"]) {
            
            deviceType = @"Simulator";
        }
    }
    
    
    [userDefaults setObject:deviceType forKey:kEXDeviceType];
    
    return deviceType;
}


#endif /* EXApplicationDefine_h */
