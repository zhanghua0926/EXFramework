//
//  EXBaseViewController.m
//  EXFrameWork
//
//  Created by Eric on 2019/1/22.
//  Copyright © 2019 icety. All rights reserved.
//

#import "EXBaseViewController.h"

@interface EXBaseViewController ()

@end


@implementation EXBaseViewController
#pragma mark - InitContent
- (instancetype)initWithNavBarStyle:(NavBarStyle)navBarStyle {
    return [self initWithNavBarStyle:navBarStyle data:nil];
}


- (instancetype)initWithNavBarStyle:(NavBarStyle)navBarStyle data:(id)data {
    if (self = [super init]) {
        self.controllerData = data;
        
        [self createNavbar:navBarStyle];
    }
    
    return self;
}


- (void)createNavbar:(NavBarStyle)navBarStyle {
    UIButton *navBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    navBtn.frame = CGRectMake(-10, 5, 48, 34);
    navBtn.exclusiveTouch = YES;
    
    switch (navBarStyle) {
        case NavBarStyleNone:
            return;
            
        case NavBarStyleBack:
            [navBtn setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
            [navBtn addTarget:self action:@selector(navBack) forControlEvents:UIControlEventTouchUpInside];
            self.backBtn = navBtn;
            break;
            
        case NavBarStyleHome:
            [navBtn setImage:[UIImage imageNamed:@"nav_home"] forState:UIControlStateNormal];
            [navBtn addTarget:self action:@selector(navHome) forControlEvents:UIControlEventTouchUpInside];
            break;
            
        default:
            break;
    }
    
    UIView *btnView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [btnView addSubview:navBtn];
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:btnView];
    self.navigationItem.leftBarButtonItem = barItem;
}


- (void)dealloc {
    // 停止监控键盘
    self.autoresizesForKeyboard = NO;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - LoadData
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    if ([self showNavigationBar]) {
        if (self.navigationController.navigationBarHidden) {
            [self.navigationController setNavigationBarHidden:NO animated:YES];
        }
        
    } else {
        if (!self.navigationController.navigationBarHidden) {
            [self.navigationController setNavigationBarHidden:YES animated:YES];
        }
    }
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    self.isViewWillAppear = YES;
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear: animated];
    
    self.isViewWillAppear = NO;
    self.isViewDidAppear = YES;
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
    
    self.isViewWillAppear = NO;
    self.isViewDidAppear = NO;
    self.isViewWillDisappear = YES;
}


- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear: animated];
    
    self.isViewWillDisappear = NO;
    self.isViewDidDisappear = YES;
}


#pragma mark - Keyboard Event
- (void)setAutoresizesForKeyboard:(BOOL)autoresizesForKeyboard {
    if (autoresizesForKeyboard != _autoresizesForKeyboard) {
        _autoresizesForKeyboard = autoresizesForKeyboard;
        
        if (_autoresizesForKeyboard) {
            // 添加键盘相关的Event
            [[NSNotificationCenter defaultCenter] addObserver: self
                                                     selector: @selector(keyboardWillShow:)
                                                         name: UIKeyboardWillShowNotification
                                                       object: nil];
            [[NSNotificationCenter defaultCenter] addObserver: self
                                                     selector: @selector(keyboardWillHide:)
                                                         name: UIKeyboardWillHideNotification
                                                       object: nil];
            [[NSNotificationCenter defaultCenter] addObserver: self
                                                     selector: @selector(keyboardDidShow:)
                                                         name: UIKeyboardDidShowNotification
                                                       object: nil];
            [[NSNotificationCenter defaultCenter] addObserver: self
                                                     selector: @selector(keyboardDidHide:)
                                                         name: UIKeyboardDidHideNotification
                                                       object: nil];
            
        } else {
            [[NSNotificationCenter defaultCenter] removeObserver: self
                                                            name: UIKeyboardWillShowNotification
                                                          object: nil];
            [[NSNotificationCenter defaultCenter] removeObserver: self
                                                            name: UIKeyboardWillHideNotification
                                                          object: nil];
            [[NSNotificationCenter defaultCenter] removeObserver: self
                                                            name: UIKeyboardDidShowNotification
                                                          object: nil];
            [[NSNotificationCenter defaultCenter] removeObserver: self
                                                            name: UIKeyboardDidHideNotification
                                                          object: nil];
        }
    }
}


- (void)keyboardWillShow:(NSNotification*)notification {
    if (self.isViewDidAppear) {
        NSNumber *showKeyboard = notification.userInfo[UIKeyboardIsLocalUserInfoKey];
        
        if ([showKeyboard boolValue])
            [self resizeForKeyboard:notification appearing:YES];
    }
}


- (void)keyboardDidShow:(NSNotification*)notification {
    if (self.isViewDidAppear) {
        CGRect endFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        [self keyboardDidAppear:YES withBounds:endFrame];
    }
}


- (void)keyboardWillHide:(NSNotification*)notification {
    if (self.isViewDidAppear) {
        [self resizeForKeyboard:notification appearing:NO];
    }
}


- (void)keyboardDidHide:(NSNotification*)notification {
    if (self.isViewDidAppear) {
        CGRect endFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        [self keyboardDidDisappear: YES withBounds:endFrame];
    }
}


- (void)resizeForKeyboard:(NSNotification*)notification appearing:(BOOL)appearing {
    
    CGRect keyboardEnds = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationCurve: [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue]];
    [UIView setAnimationDuration: [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue]];
    if (appearing) {
        [self keyboardWillAppear:YES withBounds:keyboardEnds];
        
    } else {
        [self keyboardWillDisappear:YES withBounds:keyboardEnds];
    }
    
    [UIView commitAnimations];
}


- (void)keyboardWillAppear:(BOOL)animated withBounds:(CGRect)bounds {
    // Empty default implementation.
}


- (void)keyboardWillDisappear:(BOOL)animated withBounds:(CGRect)bounds {
    // Empty default implementation.
}


- (void)keyboardDidAppear:(BOOL)animated withBounds:(CGRect)bounds {
    // Empty default implementation.
}


- (void)keyboardDidDisappear:(BOOL)animated withBounds:(CGRect)bounds {
    // Empty default implementation.
}


#pragma mark - Navigation
- (BOOL)showNavigationBar {
    return NO;
}


- (void)navBack {
    
    // Close keyboard if open.
    @try {
        [self.view endEditing:YES];
    } @catch (NSException *exception) {
        NSLog(@"%@", exception.reason);
    }
    
    // Close loading status.
    
    
    // Navigate to home.
    if (self.navigationController.viewControllers.count == 1)
        return;
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)navHome {
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (void)showNavBackBtn:(BOOL)show {
    if (show) {
        UIButton *navBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        navBtn.frame = CGRectMake(-10, 5, 48, 34);
        navBtn.exclusiveTouch = YES;
        [navBtn setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
        [navBtn addTarget:self action:@selector(navBack) forControlEvents:UIControlEventTouchUpInside];
        self.backBtn = navBtn;
        
        UIView *btnView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        [btnView addSubview:navBtn];
        //        UIBarButtonItem *backBar = [[UIBarButtonItem alloc] initWithCustomView:btnView];
        //        self.navigationItem.leftBarButtonItem = backBar;
    } else {
        self.navigationItem.leftBarButtonItem = nil;
    }
}


#pragma mark - Navigation controller
- (void)pushViewController:(UIViewController *)controller animated:(BOOL)animated {
    [self.navigationController pushViewController:controller animated:animated];
}


- (void)popViewcontroller {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)removeAllController {
//    EXBaseViewController *currentController = (EXBaseViewController *)[AppDelegate appDelegate].currentController;
//
//    NSMutableArray *controllers = [[NSMutableArray alloc] initWithArray:self.navigationController.viewControllers];
//    NSArray *array = [NSArray arrayWithArray:controllers];
//    for (UIViewController *vc in array) {
//        if (![vc isKindOfClass:[HomeViewController class]] && ![vc isKindOfClass:[currentController class]]) {
//
//            [controllers removeObject:vc];
//        }
//    }
    
//    self.navigationController.viewControllers = controllers;
}

@end
