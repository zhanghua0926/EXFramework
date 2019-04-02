//
//  EXRootNavigationController.m
//  EXFrameWork
//
//  Created by Eric on 2019/1/22.
//  Copyright © 2019 icety. All rights reserved.
//

#import "EXRootNavigationController.h"
#import "EXBaseViewController.h"

@interface EXRootNavigationController ()<UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@end

@implementation EXRootNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.delegate = self;
    self.interactivePopGestureRecognizer.delegate = self;
}


-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return self.navigationController.viewControllers.count != 1;
}


- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if ([navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
    //使navigationcontroller中第一个控制器不响应右滑pop手势
    if (navigationController.viewControllers.count == 1) {
        navigationController.interactivePopGestureRecognizer.enabled = NO;
        navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
}


-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    // Prevent multiple push controller.
    EXBaseViewController *controller = (EXBaseViewController *)[self currentController];
    if (![controller isKindOfClass:[viewController class] ]) {
        [super pushViewController:viewController animated:animated];
    }
}


- (UIViewController *)currentController {
    UIViewController *controller = nil;
    
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        
        for (UIWindow *item in windows) {
            if (item.windowLevel == UIWindowLevelNormal) {
                window = item;
                break;
            }
        }
    }
    
    id nextResponder = nil;
    
    UIViewController *rootController = window.rootViewController;
    
    if (rootController.presentedViewController) {
        while (rootController.presentedViewController) {
            rootController = rootController.presentedViewController;
            
            if (rootController)
                nextResponder = rootController;
            else
                break;
        }
    } else {
        int i = 0;
        if ([window subviews] && [[window subviews] isKindOfClass:[NSArray class]] && [[window subviews] count] > 0) {
            UIView *frontView = [[window subviews] objectAtIndex:i];
            nextResponder = [frontView nextResponder];
            
            while (![nextResponder isKindOfClass:[UIViewController class]]) {
                i++;
                frontView = [[window subviews] objectAtIndex:i];
                nextResponder = [frontView nextResponder];
            }
        }
    }
    
    if ([nextResponder isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController *)nextResponder;
        
        UINavigationController *navController = (UINavigationController *)tabBarController.viewControllers[tabBarController.selectedIndex];
        
        controller = navController.childViewControllers.lastObject;
    } else if ([nextResponder isKindOfClass:[UINavigationController class]]) {
        UIViewController *viewController = (UIViewController *)nextResponder;
        
        controller = [viewController.childViewControllers lastObject];
    } else
        controller = nextResponder;
    
    return controller;
}

@end
