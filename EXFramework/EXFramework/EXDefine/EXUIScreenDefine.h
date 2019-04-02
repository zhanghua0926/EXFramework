//
//  EXUIScreenDefine.h
//  EXFrameWork
//
//  Created by Eric on 2019/1/18.
//  Copyright © 2019 icety. All rights reserved.
//

#ifndef EXUIScreenDefine_h
#define EXUIScreenDefine_h

// Whether the landscape.
#define IS_LANDSCAPE                    UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])

// Screen width.
#define SCREEN_WIDTH                    ([[UIScreen mainScreen] bounds].size.width)

// Device width.
#define DEVICE_WIDTH                    (IS_LANDSCAPE ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width)

// Screen height.
#define SCREEN_HEIGHT                   ([[UIScreen mainScreen] bounds].size.height)

// Screen height without status bar.
#define SCREEN_HEIGHT_NOSTATUSBAR           SCREEN_HEIGHT - STATUSBAR_HEIGHT

// Screen height without navigaiton bar.
#define SCREEN_HEIGHT_NONAVIGATIONBAR       SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT

// Screen height without status and navigation bar.
#define SCREEN_HEIGHT_NOSTATUSANDNAVIBAR    SCREEN_HEIGHT - STATUSBAR_HEIGHT - NAVIGATIONBAR_HEIGHT

// Screen height without status, tabBar and navigation bar.
#define SCREEN_HEIGHT_NOSTATUSANDNAVIBARANDTABBAR    SCREEN_HEIGHT - STATUSBAR_HEIGHT - NAVIGATIONBAR_HEIGHT - TABBAR_HEIGHT

// Status bar height.
#define STATUSBAR_HEIGHT                    ([[UIApplication sharedApplication] statusBarFrame].size.height)

// Navigation bar height.
//#define NAVIGATIONBAR_HEIGHT                ((SCREEN_HEIGHT == 812.0 || SCREEN_HEIGHT == 896) ? 64 : 44)
#define NAVIGATIONBAR_HEIGHT                44

// Navigation bar height.
#define TABBAR_HEIGHT                       ((SCREEN_HEIGHT == 812.0 || SCREEN_HEIGHT == 896) ? 48 + 34 : 48)

// Status and navigation bar height.
#define STATUS_NAVIGATION_HEIGHT            STATUSBAR_HEIGHT + NAVIGATIONBAR_HEIGHT



// View Frame without status and navigation bar size.
#define ViewFrame                   CGRectMake(0, STATUS_NAVIGATION_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT_NOSTATUSANDNAVIBAR)

// View Frame for full screen.
#define FullViewFrame               CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)

// View Frame without status, tabBar and navigation bar size.
#define ViewFrameNoTab              CGRectMake(0, STATUS_NAVIGATION_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT_NOSTATUSANDNAVIBARANDTABBAR)



#endif /* EXUIScreenDefine_h */
